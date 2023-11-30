FROM alpine:latest

LABEL MAINTAINER "Anton Ohorodnyk <me@aohorodnyk.com>"
LABEL org.opencontainers.image.description "Ansible image for CI/CD pipelines."

WORKDIR /playbook

# Installing core dependencies.
RUN apk add --no-cache ca-certificates
# Installing the main packages to support Ansible tasks.
RUN apk add --no-cache git openssh sshpass rsync
# Installing python3.
RUN apk add --no-cache python3
# Installing pip.
RUN apk add --no-cache py3-pip && \
    # Installing Ansible's build dependencies and mark all of them as "build-dependencies".
    apk add --no-cache --virtual build-dependencies python3-dev libffi-dev openssl-dev build-base rust cargo && \
    # Upgrading pip.
    pip3 install --upgrade pip && \
    # Installing Ansible.
    pip3 install ansible && \
    # Purging pip cache.
    pip3 cache purge && \
    # Deleting Ansible's build dependencies.
    apk del build-dependencies && \
    # Removing apk cache.
    apk cache clean && \
    rm -rf /var/cache/apk/*
