FROM ubuntu:24.04

# avoid interactive mode when installing packages
ENV DEBIAN_FRONTEND=noninteractive
# avoid interactive mode when installing ghcup
ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=1
# GHC version
ENV BOOTSTRAP_HASKELL_GHC_VERSION=9.0.2
# Cabal version
ENV BOOTSTRAP_HASKELL_CABAL_VERSION=3.4.1.0
# install stack
ENV BOOTSTRAP_HASKELL_INSTALL_STACK=1
# install haskell language server
ENV BOOTSTRAP_HASKELL_INSTALL_HLS=1

RUN apt-get update && apt-get install -y software-properties-common && \
    apt-get install -y sudo build-essential libgmp-dev git wget unzip which tar curl && \
    apt-get clean
#    apt-get install -y gcc git wget unzip which tar ghc ghc-Cabal && \

ARG USERNAME

RUN groupadd $USERNAME && \
    useradd -m -s /bin/bash -g $USERNAME -G sudo $USERNAME && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $USERNAME
WORKDIR /home/$USERNAME

RUN bash -c "curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh"
ENV PATH="/home/${USERNAME}/.ghcup/bin:${PATH}"
