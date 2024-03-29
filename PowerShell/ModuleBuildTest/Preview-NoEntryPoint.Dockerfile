
FROM mcr.microsoft.com/powershell:preview-ubuntu-20.04 as base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    wget \
    mono-complete \
    libcurl4 \
    unzip \
    zip \
    --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

FROM base as src

RUN mkdir /source

RUN wget https://github.com/GitTools/GitVersion/releases/download/5.0.1/GitVersion-bin-fullfx-v5.0.1.zip \
    && unzip GitVersion-bin-fullfx-v5.0.1.zip -d GitVersion \
    && echo 'mono /GitVersion/GitVersion.exe "$@"' > /GitVersion/gitversion \
    && chmod -R 777 /GitVersion \
    && ln -s /GitVersion/gitversion /usr/bin/gitversion

LABEL maintainer="nferrell"
LABEL description="Ubuntu 20.04 for pwsh-preview module testing in CI"
LABEL vendor="scrthq"

SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY ["dockerImageBootstrap.ps1", "/data/dockerImageBootstrap.ps1"]
COPY ["moduleDependencies.ps1", "/data/moduleDependencies.ps1"]
RUN . /data/dockerImageBootstrap.ps1
RUN rm -rf /data/*

WORKDIR /source
