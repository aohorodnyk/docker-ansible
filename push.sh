#!/bin/bash

REPO_PATH="aohorodnyk/ansible"
FULL_URL="ghcr.io/${REPO_PATH}"

docker build --platforms=linux/amd64,linux/arm64,linux/arm/v7 -t ansible:latest .

DOCKER_VERSION_FULL=$(docker run ansible:latest ansible --version | grep ansible | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1)
DOCKER_VERSION_MINOR=$(echo $DOCKER_VERSION_FULL | grep -o '[0-9]\+\.[0-9]\+' | head -1)
DOCKER_VERSION_MAJOR=$(echo $DOCKER_VERSION_MINOR | grep -o '[0-9]\+' | head -1)

echo "Version full: '${DOCKER_VERSION_FULL}'"
echo "Version minor: '${DOCKER_VERSION_MINOR}'"
echo "Version major: '${DOCKER_VERSION_MAJOR}'"

docker pull $FULL_URL:${DOCKER_VERSION_FULL}
if [[ $(docker images --filter=reference="$FULL_URL:${DOCKER_VERSION_FULL}" -q) ]]; then
  echo "Tag '${DOCKER_VERSION_FULL}' is exist"
  exit 0
fi

docker tag ansible:latest $FULL_URL:latest

docker tag ansible:latest $FULL_URL:${DOCKER_VERSION_FULL}
docker tag ansible:latest $FULL_URL:${DOCKER_VERSION_MINOR}
docker tag ansible:latest $FULL_URL:${DOCKER_VERSION_MAJOR}

docker push $FULL_URL:${DOCKER_VERSION_MAJOR}
docker push $FULL_URL:${DOCKER_VERSION_MINOR}
docker push $FULL_URL:${DOCKER_VERSION_FULL}
docker push $FULL_URL:latest
