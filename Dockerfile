FROM alpine:3.12

LABEL MAINTAINER "Anton Ohorodnyk <anton@ohorodnyk.name>"

# Install all needed dependencies
RUN apk update && \
    apk add python3 py-pip openssl ca-certificates git openssh sshpass && \
    apk add --virtual build-dependencies python3-dev libffi-dev openssl-dev build-base && \
    # Upgrade pip
    pip install --upgrade pip ansible && \
    # Clear dependecies
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*
    # Install ansible modules

RUN ansible-galaxy collection install community.general

WORKDIR /playbook
