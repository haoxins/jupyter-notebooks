FROM ghcr.io/haoxins/jupyter:main

USER $NB_UID

RUN export PATH="/home/jovyan/.local/bin:$PATH"

# Install - requirements.txt
COPY --chown=jovyan:users requirements.txt /tmp/requirements.txt
RUN python3 -m pip install \
  -r /tmp/requirements.txt \
  --quiet --no-cache-dir \
  && rm -f /tmp/requirements.txt \
  && jupyter lab build
