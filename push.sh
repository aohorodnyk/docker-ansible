#!/bin/bash

REPO_PATH="aohorodnyk/docker-ansible/ansible"
FULL_URL="docker.pkg.github.com/${REPO_PATH}"

docker build -t ansible:latest .

DOCKER_VERSION_FULL=$(docker run $FULL_URL:latest ansible --version | grep ansible | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1)
DOCKER_VERSION_MINOR=$(echo $DOCKER_VERSION_FULL | grep -o '[0-9]\+\.[0-9]\+' | head -1)
DOCKER_VERSION_MAJOR=$(echo $DOCKER_VERSION_MINOR | grep -o '[0-9]\+' | head -1)

docker tag ansible:latest $FULL_URL:latest

echo "Version full: ${DOCKER_VERSION_FULL}"
docker tag ansible:latest $FULL_URL:${DOCKER_VERSION_FULL}
echo "Version minor: ${DOCKER_VERSION_MINOR}"
docker tag ansible:latest $FULL_URL:${DOCKER_VERSION_MINOR}
echo "Version major: ${DOCKER_VERSION_MAJOR}"
docker tag ansible:latest $FULL_URL:${DOCKER_VERSION_MAJOR}

docker push $FULL_URL:${DOCKER_VERSION_MAJOR}
docker push $FULL_URL:${DOCKER_VERSION_MINOR}
docker push $FULL_URL:${DOCKER_VERSION_FULL}
docker push $FULL_URL:latest
