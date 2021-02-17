FROM alpine:3.13

LABEL MAINTAINER "Anton Ohorodnyk <anton@ohorodnyk.name>"

# Install all needed dependencies
RUN apk update && \
    apk add rust cargo && \
    apk add python3 py-pip openssl ca-certificates git openssh sshpass rsync && \
    apk add --virtual build-dependencies python3-dev libffi-dev openssl-dev build-base && \
    # Upgrade pip
    pip install --upgrade pip ansible && \
    # Clear dependecies
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*

# Install ansible modules
RUN ansible-galaxy collection install community.general && \
    ansible-galaxy collection install ansible.posix

WORKDIR /playbook
