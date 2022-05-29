# TLDR

Builds multiarchitecture images (amd64 and arm64) that includes awscli2 and kubectl
Publishes them and the manifest to `muccello/awscli2-kubectl` when there are changes to the Dockerfile and version file

TODO: change conditional logic around version to work with tags or releases

## awscli2-kubectl helm chart
Includes a chart that is meant to facilitate local cluster usage with AWS ECR as a respository

It installs the following resources:

### cronjob:  
That mounts your `~/.aws` directory which should be preconfigured or logged in via aws sso 

Using that credential it creates an image pull secret and keeps it up data on a schedule. 
This is required since aws ecr requires a refresh every 12 hours. 

It also patches the default service account in the given namespace to use it as the image pull secret. 

In this way your local cluster emulates clusters on aws which utilize roles to access ecr

Example usage with k3d:

```bash

# mount your local ~/.aws directory so it is available to all nodes in your local cluster
 k3d cluster create multiserver --servers 3 -v ~/.aws:/root/.aws@server:0,1,2  

# install chart to create and continual refresh image pull secret
helm template --set aws.account="nnnnnnnnnn" --set aws.region="us-east-2" registry-cred ./charts/awscli2-kubectl

```

TODO: change to use non root account 
