#!/bin/bash

arch=$(uname -m)
if [[ $arch == x86_64* ]]; then
  ARCH="amd64"
elif  [[ $arch == arm64 ]]; then
  ARCH="arm64"
fi
echo "CPU is ${ARCH}"
pwd
docker rmi -f terraform-module_tools
ARCH=${ARCH} docker-compose run --rm tools bash -c '
# docker images | grep tools
# docker rmi -f tools-${ARCH}
# docker buildx ls
# docker buildx rm
# docker buildx ls
# docker buildx create --platform=linux/amd64,linux/arm64,linux/arm/v7,linux/arm64/v8 --name tools --use --node tools0
# docker buildx use tools
# docker buildx inspect
# # https://vikaspogu.dev/posts/docker-buildx-setup/
# docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
# docker buildx build --platform linux/${ARCH} -t tools-${ARCH} --progress=plain --load .
# #docker buildx build --platform=linux/amd64,linux/arm64,linux/arm/v7,linux/arm64/v8 --progress=plain -t tools:latest .
# docker images | grep tools
# docker buildx ls
# docker buildx imagetools inspect star3am/repository:tools
docker rmi tools-container_tools
ARCH=${ARCH} docker compose run --rm tools bash -c '
  cd /app
  env | grep PATH
  cat /etc/lsb-release
  uname -a
  pwd
  tree -a -L 1
  cat Dockerfile
  echo "*** python3 -V"
  python3 -V
  echo "*** pip -V"
  pip -V
  echo "*** terraform -version"
  terraform -version
  echo "*** terragrunt -version"
  terragrunt -version
  echo "*** pre-commit --version"
  pre-commit --version
  terraform-docs markdown document --hide requirements --escape=false --sort-by required . > docs/README.md
  terraform init -upgrade
  terraform plan
  echo "*** packer version"
  packer version
  echo "*** docker version"
  docker version
  echo "*** docker-compose version"
  docker-compose version
  DIR=~/.git-template
  git config --global init.templateDir ${DIR}
  pre-commit init-templatedir -t pre-commit ${DIR}
  pre-commit validate-config
  pre-commit run -a
