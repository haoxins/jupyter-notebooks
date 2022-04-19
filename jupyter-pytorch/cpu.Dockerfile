FROM ghcr.io/haoxins/jupyter:main

USER $NB_UID

# Install - requirements.txt
COPY --chown=jovyan:users cpu-requirements.txt /tmp/requirements.txt
RUN python3 -m pip install \
  -r /tmp/requirements.txt \
  --quiet --no-cache-dir
RUN rm -f /tmp/requirements.txt \
  && jupyter lab build
