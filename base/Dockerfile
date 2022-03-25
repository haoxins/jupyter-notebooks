FROM ubuntu:22.04

# Common ENVs
ENV NB_USER jovyan
ENV NB_UID 1000
ENV NB_PREFIX /
ENV HOME /home/$NB_USER
ENV SHELL /bin/bash

# Args - Software versions
ARG KUBECTL_ARCH="amd64"
ARG KUBECTL_VERSION=v1.23.5
ARG S6_ARCH="amd64"
ARG S6_VERSION=v3.1.0.1

# Set shell to bash
SHELL ["/bin/bash", "-c"]

# Install - Linux packages
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get -yq update \
  && apt-get -yq upgrade \
  && apt-get -yq install --no-install-recommends \
    apt-transport-https \
    bash \
    bzip2 \
    ca-certificates \
    curl \
    git \
    gnupg \
    gnupg2 \
    locales \
    lsb-release \
    nano \
    software-properties-common \
    tzdata \
    unzip \
    vim \
    wget \
    zip \
    python3 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install - s6 overlay
RUN export GNUPGHOME=/tmp/ \
  && curl -sL "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}-installer" -o /tmp/s6-overlay-${S6_VERSION}-installer \
  && curl -sL "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}-installer.sig" -o /tmp/s6-overlay-${S6_VERSION}-installer.sig \
  && gpg --keyserver keys.gnupg.net --keyserver pgp.surfnet.nl --recv-keys 6101B2783B2FD161 \
  && gpg -q --verify /tmp/s6-overlay-${S6_VERSION}-installer.sig /tmp/s6-overlay-${S6_VERSION}-installer \
  && chmod +x /tmp/s6-overlay-${S6_VERSION}-installer \
  && /tmp/s6-overlay-${S6_VERSION}-installer / \
  && rm /tmp/s6-overlay-${S6_VERSION}-installer.sig /tmp/s6-overlay-${S6_VERSION}-installer

# Install - kubectl
RUN curl -sL "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${KUBECTL_ARCH}/kubectl" -o /usr/local/bin/kubectl \
  && curl -sL "https://dl.k8s.io/${KUBECTL_VERSION}/bin/linux/${KUBECTL_ARCH}/kubectl.sha256" -o /tmp/kubectl.sha256 \
  && echo "$(cat /tmp/kubectl.sha256) /usr/local/bin/kubectl" | sha256sum --check \
  && rm /tmp/kubectl.sha256 \
  && chmod +x /usr/local/bin/kubectl

# Create user and set required ownership
RUN useradd -M -s /bin/bash -N -u ${NB_UID} ${NB_USER} \
  && mkdir -p ${HOME} \
  && chown -R ${NB_USER}:users ${HOME} \
  && chown -R ${NB_USER}:users /usr/local/bin \
  && chown -R ${NB_USER}:users /etc/s6

# Set locale configs
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
  && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

USER $NB_UID
