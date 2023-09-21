FROM debian:stable-slim

#
# as root
#
USER root
WORKDIR /root

RUN apt-get update && apt-get install -y \
      ca-certificates \
      curl \
      git \
      gnupg \
      nano \
      python-is-python3 python3 python3-pip python3-venv \
      sudo \
      wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ARG NODE_MAJOR=18
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install -y nodejs

RUN groupadd -g 1000 openint \
    && useradd -m -s /usr/bin/bash -g 1000 -u 1000 openint
RUN echo "openint ALL=(ALL:ALL) NOPASSWD: ALL" >/etc/sudoers.d/openint

#
# as openint
#
USER openint
WORKDIR /home/openint

RUN mkdir bin && bash -c '(echo && echo "PATH=\"$HOME/bin:$PATH\"")' >>${HOME}/.bashrc
COPY 3.5-turbo.py 3.5-turbo-16k.py 4.py 4-32k.py tokenizer.py bin/

RUN python -m venv python \
    && . python/bin/activate \
    && pip install \
        google-search \
        matplotlib \
        numpy \
        open-interpreter \
        pandas \
        tiktoken
RUN bash -c '(echo && echo "source ~/python/bin/activate")' >>${HOME}/.bashrc
