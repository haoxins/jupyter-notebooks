FROM ghcr.io/haoxins/jupyter:main

# Nvidia configs
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

USER $NB_UID

COPY --chown=jovyan:users cuda-requirements.txt /tmp/requirements.txt
RUN python3 -m pip install \
  -r /tmp/requirements.txt \
  --no-cache-dir \
  && rm -f /tmp/requirements.txt \
  && jupyter lab build
