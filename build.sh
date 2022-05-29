#!/usr/bin/env bash

VERSION=$(cat version)
DOCKER_HUB_USER="muccello"

build_push_all() {
    docker buildx build  -f Dockerfile  -t ${DOCKER_HUB_USER}/awscli2-kubectl:${VERSION} --platform linux/amd64,linux/arm64 --push . 
}

if [[ $GITHUB_ACTIONS != 'true' ]]; then
     echo "Not running in git hub actions"
     docker container prune -f
     docker image rm ${DOCKER_HUB_USER}/awscli2-kubectl:${VERSION}
     #echo "$DOCKER_HUB_ACCESS_TOKEN" | docker login -u $DOCKER_HUB_USER --password-stdin
     docker buildx create --name aws2cli_kubectl --use
fi

build_push_all

if [[ $GITHUB_ACTIONS != 'true' ]]; then
    docker buildx rm aws2cli_kubectl
fi