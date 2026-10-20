FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    openssh-client \
    sshpass \
    && pip install ansible \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /ansible
