FROM ghcr.io/haoxins/jupyter:main

USER $NB_UID

COPY --chown=jovyan:users cpu-requirements.txt /tmp/requirements.txt
RUN python3 -m pip install \
  -r /tmp/requirements.txt \
  --no-cache-dir \
  && rm -f /tmp/requirements.txt \
  && jupyter lab build
