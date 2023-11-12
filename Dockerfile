FROM alpine:latest

LABEL MAINTAINER "Anton Ohorodnyk <me@aohorodnyk.com>"

# Install all needed dependencies
RUN apk update && \
    apk add rust cargo && \
    apk add python3 py-pip openssl ca-certificates git openssh sshpass rsync && \
    apk add --virtual build-dependencies python3-dev libffi-dev openssl-dev build-base && \
    # Upgrade pip
    pip install --upgrade pip ansible && \
    # Install ansible modules
    ansible-galaxy collection install community.general && \
    ansible-galaxy collection install ansible.posix && \
    # Clear dependecies
    apk del rust cargo && \
    apk del build-dependencies python3-dev libffi-dev openssl-dev build-base && \
    rm -rf /var/cache/apk/*

WORKDIR /playbook
