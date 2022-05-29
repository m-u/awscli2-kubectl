#!/usr/bin/env bash

echo 'Linting Dockerfile'
docker run --rm -i -v ${PWD}:/repo:ro --workdir=/repo hadolint/hadolint hadolint --config .hadolint.yaml Dockerfile

echo 'Linting charts/awscli2-kubectl'
helm lint charts/awscli2-kubectl
