import nbformat
import sys
from nbconvert.preprocessors import ExecutePreprocessor
from datetime import datetime

class StopOnExceptionExecutePreprocessor(ExecutePreprocessor):

    def __init__(self, **kw):
        super().__init__(**kw)

    def preprocess_cell(self, cell, resources, cell_index):
        """
        Overwrites the default cell execution method to handle execution errors.
        It records the error in the output cell and stops processing further cells.
        """
        try:
            # Process the cell as normal
            return super(StopOnExceptionExecutePreprocessor, self).preprocess_cell(cell, resources, cell_index)
        except Exception as e:
            # Add the error to the cell output
            error_output = nbformat.v4.new_output('error',
                                                  ename=str(type(e).__name__),
                                                  evalue=str(e),
                                                  traceback=e.traceback if hasattr(e, 'traceback') else [])
            if 'outputs' not in cell:
                cell['outputs'] = []
            cell['outputs'].append(error_output)
            # Stop further execution by raising the exception
            raise

def execute_notebook(input_notebook, output_notebook):
    # Read the notebook
    with open(input_notebook, 'r', encoding='utf-8') as file:
        notebook = nbformat.read(file, as_version=4)

    # Set up the processor and attempt to execute the notebook
    ep = StopOnExceptionExecutePreprocessor(timeout=36000, kernel_name='python3') # TODO timeout set 10h for temp
    print("set StopOnExceptionExecutePreprocessor timeout", ep.timeout, datetime.utcnow())
    try:
        ep.preprocess(notebook, {'metadata': {'path': './'}})
    except Exception as e:
        print("Error executing the notebook. See the output notebook for details.", datetime.utcnow())
        with open(f'{output_notebook}.err', 'w') as fp:
            pass

    # Save the notebook after execution halts
    with open(output_notebook, 'wt', encoding='utf-8') as file:
        nbformat.write(notebook, file)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        raise Exception("Usage: python3 my_nbconvert.py input.notebook output.notebook")
    input_nb = sys.argv[1]
    output_nb = sys.argv[2]
    execute_notebook(input_nb, output_nb)
