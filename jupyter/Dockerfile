FROM ghcr.io/pluralsh/kubeflow-notebooks-base:v1.0.1

USER root

# args - software versions
ARG MINIFORGE_ARCH="x86_64"
ARG MINIFORGE_VERSION=4.10.3-7
ARG PIP_VERSION=21.1.2
ARG PYTHON_VERSION=3.8.10

# switch to NB_UID for installs
USER ${NB_UID}

# install - requirements.txt
COPY --chown=jovyan:users requirements.txt /tmp
RUN python3 -m pip install -r /tmp/requirements.txt --quiet --no-cache-dir \
 && rm -f /tmp/requirements.txt \
 && jupyter lab --generate-config \
 && rm -rf ${HOME}/.cache/yarn \
 && chown -R ${NB_USER}:users ${HOME}

# s6 - copy scripts
COPY --chown=jovyan:users s6/ /etc

# s6 - 01-copy-tmp-home
USER root
RUN mkdir -p /tmp_home \
 && cp -r ${HOME} /tmp_home \
 && chown -R ${NB_USER}:users /tmp_home
USER ${NB_UID}

EXPOSE 8888

ENTRYPOINT ["/init"]
