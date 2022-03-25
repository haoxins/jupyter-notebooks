FROM ghcr.io/pluralsh/kubeflow-notebooks-codeserver:v1.0.2

USER root

# args - software versions
ARG CODESERVER_PYTHON_VERSION=2021.5.842923320
ARG CODESERVER_GITLENS_VERSION=11.4.1
ARG CODESERVER_GIT_GRAPH_VERSION=1.30.0
ARG MINIFORGE_ARCH="x86_64"
ARG MINIFORGE_VERSION=4.10.3-7
ARG PIP_VERSION=21.1.2
ARG PYTHON_VERSION=3.8.10

# update - ensure apt packages are always updated
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get -yq update \
 && apt-get -yq upgrade \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

USER $NB_UID

# install - requirements.txt
COPY --chown=jovyan:users requirements.txt /tmp
RUN python3 -m pip install -r /tmp/requirements.txt --quiet --no-cache-dir \
 && rm -f /tmp/requirements.txt \
 && chown -R ${NB_USER}:users ${HOME}

# install - codeserver extensions
RUN code-server --install-extension "ms-python.python@${CODESERVER_PYTHON_VERSION}" \
 && code-server --install-extension "eamodio.gitlens@${CODESERVER_GITLENS_VERSION}" \
 && code-server --install-extension "mhutchie.git-graph@${CODESERVER_GIT_GRAPH_VERSION}"

# s6 - copy scripts
COPY --chown=jovyan:users s6/ /etc

# s6 - 01-copy-tmp-home
USER root
RUN mkdir -p /tmp_home \
 && cp -r ${HOME} /tmp_home \
 && chown -R ${NB_USER}:users /tmp_home
USER ${NB_UID}
