FROM python:3.10-bullseye

RUN apt update && apt install -y apt-transport-https ca-certificates gnupg curl sudo
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.asc] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | tee /usr/share/keyrings/cloud.google.asc
RUN apt update && apt install -y google-cloud-cli
RUN apt install -y openjdk-11-jdk

RUN mkdir /app
COPY dockerfiles/rm_matplotlib_cache.py /app/rm_matplotlib_cache.py
COPY dockerfiles/DCube-2.0.jar /app/DCube-2.0.jar
COPY dockerfiles/my_nbconvert.py /app/my_nbconvert.py

RUN pip install "cython<3.0.0" wheel && pip install pyyaml==5.4.1 --no-build-isolation
COPY dockerfiles/py310-jdk11.requirements.txt /app/requirements.txt
RUN pip install --use-feature=fast-deps  -r /app/requirements.txt


RUN sed -i 's/#font.family.*$/font.family: sans-serif/' /usr/local/lib/python3.10/site-packages/matplotlib/mpl-data/matplotlibrc
RUN sed -i 's/#font.sans-serif.*$/font.sans-serif: SimHei, Bitstream Vera Sans, Lucida Grande, Verdana, Geneva, Lucid, Arial, Helvetica, Avant Garde, sans-serif/' /usr/local/lib/python3.10/site-packages/matplotlib/mpl-data/matplotlibrc
RUN sed -i s'/#axes.unicode_minus.*$/axes.unicode_minus: False/' /usr/local/lib/python3.10/site-packages/matplotlib/mpl-data/matplotlibrc

RUN curl https://raw.githubusercontent.com/cceasy/public/master/SimHei.ttf > /usr/local/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/SimHei.ttf
RUN echo 'expect md5sum for SimHei.ttf a82b90f05df21b64658f35a8738098ab'
RUN md5sum /usr/local/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/SimHei.ttf

ENV PYTHONPATH="/app:${PYTHONPATH}"
RUN python /app/rm_matplotlib_cache.py

WORKDIR /app
