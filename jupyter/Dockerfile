FROM ubuntu:22.04

ENV NB_USER jovyan
ENV NB_UID 1000
ENV NB_PREFIX /
ENV HOME /home/$NB_USER
ENV SHELL /bin/bash

ARG S6_VERSION=v3.1.1.2

ARG PYTHON_VERSION=3.10
ARG PIP_VERSION=22

SHELL ["/bin/bash", "-c"]

RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get -yq update \
  && apt-get -yq upgrade \
  && apt-get -yq install \
    apt-transport-https \
    bash \
    bzip2 \
    ca-certificates \
    curl \
    gcc \
    git \
    locales \
    lsb-release \
    nodejs \
    npm \
    python3 \
    python3-pip \
    software-properties-common \
    tzdata \
    unzip \
    vim \
    wget \
    sudo \
    xz-utils \
    zip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install - s6 overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

# Create user and set required ownership
RUN useradd -M -s /bin/bash -N -u ${NB_UID} ${NB_USER} \
  && mkdir -p ${HOME} \
  && chown -R ${NB_USER}:users ${HOME} \
  && chown -R ${NB_USER}:users /usr/local/bin \
  && chown -R ${NB_USER}:users /etc/s6-overlay \
  && chown -R ${NB_USER}:users /command \
  && echo "${NB_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set locale configs
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
  && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

USER ${NB_UID}

ENV PATH /home/jovyan/.local/bin:${PATH}

COPY --chown=jovyan:users requirements.txt /tmp
RUN python3 -m pip install \
  -r /tmp/requirements.txt \
  --no-cache-dir

# TODO fix deps
#RUN rm -f /tmp/requirements.txt \
#  && jupyter lab --generate-config \
#  && jupyter lab build \
#  && chown -R ${NB_USER}:users ${HOME}

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
