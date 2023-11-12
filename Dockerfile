FROM alpine:latest

LABEL MAINTAINER "Anton Ohorodnyk <me@aohorodnyk.com>"
LABEL org.opencontainers.image.description "Ansible image for CI/CD pipelines."

WORKDIR /playbook

# Install python3 with pip.
RUN apk add --no-cache python3 py-pip && \
    # Install core dependencies.
    apk add --no-cache ca-certificates && \
    # Install the main packages to support Ansible tasks.
    apk add --no-cache git openssh sshpass rsync && \
    # Install Ansible's build dependencies and mark all of them as "build-dependencies".
    apk add --no-cache --virtual build-dependencies python3-dev libffi-dev openssl-dev build-base rust cargo && \
    # Upgrade pip.
    pip3 install --upgrade pip && \
    # Install Ansible.
    pip3 install ansible && \
    # Purge pip cache.
    pip3 cache purge && \
    # Delete Ansible's build dependencies.
    apk del build-dependencies && \
    # Remove apk cache.
    rm -rf /var/cache/apk/*
