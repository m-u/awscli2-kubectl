linux/amd64,linux/arm/v7,linux/arm64 

manifest-amd64
arm32v7
arm64v8


ARCH=amd64/



# AMD64
docker build -t muccello/awscli2-kubectl:manifest-${VERSION}-amd64 --build-arg ARCH=amd64/ .
docker push muccello/awscli2-kubectl:manifest-${VERSION}-amd64

# ARM32V7
docker build -t muccello/awscli2-kubectl:manifest-${VERSION}-arm32v7 --build-arg ARCH=arm32v7/ .
docker push muccello/awscli2-kubectl:manifest-${VERSION}-arm32v7

# ARM64V8
docker build -t muccello/awscli2-kubectl:manifest-${VERSION}-arm64v8 --build-arg ARCH=arm64v8/ .
docker push muccello/awscli2-kubectl:manifest-${VERSION}-arm64v8