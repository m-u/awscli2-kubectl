
VERSION=$(cat version)
ARCHITECTURE=$1

if [[ $GITHUB_ACTIONS != 'true' ]]; then
    echo "Not running in git hub actions"
    echo "Ensure you are logged in to dockerhub/muccello"
    docker login -u muccello
fi


if [[ $ARCHITECTURE == amd64 ]]; then
    # AMD64
    echo "Building amd64 image"
    docker build -f Dockerfile.amd64 -t muccello/awscli2-kubectl:${VERSION}-amd64 --build-arg ARCH=amd64/ .
    docker push muccello/awscli2-kubectl:${VERSION}-amd64
elif [[ $ARCHITECTURE == arm64 ]]; then
    # ARM64V8
    echo "Building arm64 image"
    docker build -f Dockerfile.arm64 -t muccello/awscli2-kubectl:${VERSION}-arm64 --build-arg ARCH=arm64v8/ .
    docker push muccello/awscli2-kubectl:${VERSION}-arm64
elif [[ $ARCHITECTURE == all ]]; then
    # AMD64
    echo "Building amd64 image"
    docker build -f Dockerfile.amd64 -t muccello/awscli2-kubectl:${VERSION}-amd64 --build-arg ARCH=amd64/ .
    docker push muccello/awscli2-kubectl:${VERSION}-amd64
    # ARM64V8
    echo "Building arm64 image"
    docker build -f Dockerfile.arm64 -t muccello/awscli2-kubectl:${VERSION}-arm64 --build-arg ARCH=arm64v8/ .
    docker push muccello/awscli2-kubectl:${VERSION}-arm64
else
    echo "Missing architecture --> ./build.sh amd64 | arm64 | all"
fi

docker manifest create muccello/awscli2-kubectl:${VERSION} \
  --amend muccello/awscli2-kubectl:${VERSION}-amd64 \
  --amend muccello/awscli2-kubectl:${VERSION}-arm64

docker manifest push muccello/awscli2-kubectl:${VERSION}