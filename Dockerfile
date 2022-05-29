FROM debian:buster-slim

ARG AWS_VERSION="2.4.5"
ARG KUBE_VERSION="1.22.6"
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGET

    
RUN if [ $TARGETPLATFORM = 'linux/amd64' ]; then TARGET=amd64; else TARGET=arm64; fi; \
    echo "TARGET=$TARGET aws_version:$AWS_VERSION kubectl_version:$KUBE_VERSION"; \
    echo "Running on $BUILDPLATFORM, building for $TARGETPLATFORM"; \
    # awscli2
    apt-get update; \
    apt-get install unzip curl -y;  \
    if [ $TARGETPLATFORM = 'linux/amd64' ]; then curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; \
    else curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"; fi;\
    unzip awscliv2.zip; \
    ./aws/install; \
    # kubectl
    curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/${KUBE_VERSION}/2022-03-09/bin/linux/${TARGET}/kubectl ;\
    chmod +x kubectl; \
    cp ./kubectl /bin/kubectl; \
    rm -rf /var/lib/apt/lists/*; \
    rm awscli2.zip; \
    rm kubectl
