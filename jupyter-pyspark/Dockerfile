FROM jupyter/pyspark-notebook:python-3.9.6
USER root
RUN apt-get update && apt-get install curl wget telnet gcc -y;
USER jovyan
ENV NB_PREFIX /

CMD jupyter lab \
  --ip=0.0.0.0 \
  --no-browser \
  --allow-root \
  --port=8888 \
  --ServerApp.token="" \
  --ServerApp.password="" \
  --ServerApp.allow_origin="*" \
  --ServerApp.base_url="${NB_PREFIX}" \
  --ServerApp.authenticate_prometheus=False
