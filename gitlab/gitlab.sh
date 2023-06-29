#!/bin/bash

echo -e '\e[38;5;198m'"++++ Cleanup"
sudo docker stop gitlab
sudo docker rm gitlab
sudo docker stop gitlab-runner
sudo docker rm gitlab-runner
yes | sudo docker system prune -a
yes | sudo docker system prune --volumes

arch=$(lscpu | grep "Architecture" | awk '{print $NF}')
if [[ $arch == x86_64* ]]; then
  ARCH="amd64"
  echo -e '\e[38;5;198m'"CPU is $ARCH"
  sudo --preserve-env=PATH -u vagrant helm uninstall gitlab

  # https://docs.gitlab.com/charts/development/minikube/ Gitlab via minikube
  # https://gitlab.com/gitlab-org/charts/gitlab
  # https://docs.gitlab.com/ee/administration/troubleshooting/kubernetes_cheat_sheet.html
  # https://docs.gitlab.com/runner/install/kubernetes.html

  echo -e '\e[38;5;198m'"++++ Helm add Gitlab repo"
  echo -e '\e[38;5;198m'"++++ helm repo add gitlab https://charts.gitlab.io/"
  sudo --preserve-env=PATH -u vagrant helm repo add gitlab https://charts.gitlab.io/
  echo -e '\e[38;5;198m'"++++ helm repo update"
  sudo --preserve-env=PATH -u vagrant helm repo update
  echo -e '\e[38;5;198m'"++++ helm search repo gitlab"
  sudo --preserve-env=PATH -u vagrant helm search repo gitlab

  echo -e '\e[38;5;198m'"++++ Launch Gitlab on minikube using Helm Charts"
  # sudo --preserve-env=PATH -u vagrant git clone https://gitlab.com/gitlab-org/charts/gitlab.git
  # cd gitlab
  # sudo --preserve-env=PATH -u vagrant helm dependency build
  # sudo --preserve-env=PATH -u vagrant minikube profile list
  # sleep 10;

  # https://helm.sh/docs/helm/helm_upgrade/
  # https://gitlab.com/gitlab-org/charts/gitlab/-/blob/master/doc/installation/command-line-options.md
  echo -e '\e[38;5;198m'"++++ Helm install gitlab"
  echo -e "sudo --preserve-env=PATH -u vagrant helm install \
    --namespace default gitlab \
    --timeout 600s \
    --set global.edition=ce \
    --set global.hosts.https=false \
    --set global.hosts.domain=localhost \
    --set global.hosts.externalIP=\$(minikube ip) \
    --set gitlab-runner.install=false \
    --set gitlab-runner.runners.privileged=true \
    -f https://gitlab.com/gitlab-org/charts/gitlab/raw/master/examples/values-minikube-minimum.yaml gitlab/gitlab"
  sudo --preserve-env=PATH -u vagrant helm install \
    --namespace default gitlab \
    --timeout 600s \
    --set global.edition=ce \
    --set global.hosts.https=false \
    --set global.hosts.domain=localhost \
    --set global.hosts.externalIP=$(sudo --preserve-env=PATH -u vagrant minikube ip) \
    --set gitlab-runner.install=false \
    --set gitlab-runner.runners.privileged=true \
    -f https://gitlab.com/gitlab-org/charts/gitlab/raw/master/examples/values-minikube-minimum.yaml gitlab/gitlab

  echo -e '\e[38;5;198m'"++++ Stretch your legs, get a coffee or a drink, ETA 10m.."
  echo -e '\e[38;5;198m'"++++ Waiting for Gitlab to become available.."
  echo -e '\e[38;5;198m'"++++ See Minikube Dashboard for details: http://localhost:10888"

  attempts=0
  max_attempts=15
  while ! ( sudo --preserve-env=PATH -u vagrant kubectl get po | grep webservice | tr -s " " | cut -d " " -f3 | grep Running ) && (( $attempts < $max_attempts )); do
    attempts=$((attempts+1))
    sleep 60;
    echo -e '\e[38;5;198m'"++++ Waiting for Gitlab to become available, (${attempts}/${max_attempts}) sleep 60s"
    sudo --preserve-env=PATH -u vagrant kubectl get po
    sudo --preserve-env=PATH -u vagrant kubectl get events | grep -e Memory -e OOM
  done

  echo -e '\e[38;5;198m'"++++ Waiting for Gitlab to stabalize, sleep 30s"
  sleep 30;
  sudo --preserve-env=PATH -u vagrant kubectl get po
  sudo --preserve-env=PATH -u vagrant kubectl get events | grep -e Memory -e OOM

  # https://gitlab.com/gitlab-org/charts/gitlab/-/issues/2572 Error 422
  echo -e '\e[38;5;198m'"The easiest way to access this service is to let kubectl to forward the port:"
  echo -e '\e[38;5;198m'"kubectl port-forward service/gitlab-webservice-default 5580:8181"
  # https://stackoverflow.com/questions/67084554/how-to-kubectl-port-forward-gitlab-webservice
  sudo --preserve-env=PATH -u vagrant kubectl port-forward -n default service/gitlab-webservice-default 5580:8181 --address="0.0.0.0" > /dev/null 2>&1 &
  sudo --preserve-env=PATH -u vagrant kubectl port-forward -n default service/gitlab-gitlab-shell 32022:32022 --address="0.0.0.0" > /dev/null 2>&1 &
  
  ps aux | grep kubectl | grep -ve sudo -ve grep -ve bin

  # # TODO: FIXME! Error: INSTALLATION FAILED: failed to download "gitlab-runner"
  # # https://docs.gitlab.com/runner/install/kubernetes.html
  # echo -e '\e[38;5;198m'"++++ Adding Gitlab-Runner"
  # # https://charts.gitlab.io/
#   sudo rm -rf values.yaml
#   sleep 3;
# cat <<EOF | sudo --preserve-env=PATH -u vagrant tee values.yaml
# runners:
#   config: |
#     [[runners]]
#       [runners.kubernetes]
#         image = "ubuntu:20.04"
# EOF
#   sudo --preserve-env=PATH -u vagrant helm install \
#     --namespace default gitlab-runner \
#     -f values.yaml gitlab/gitlab-runner

  # echo -e '\e[38;5;198m'"++++ Waiting for Gitlab-Runner to become available, sleep 30s"
  # sleep 30;
  # sudo --preserve-env=PATH -u vagrant kubectl get po
  # sudo --preserve-env=PATH -u vagrant kubectl get events | grep -e Memory -e OOM

  echo -e '\e[38;5;198m'"Tada! Gitlab CE http://localhost:5580 and login with Username: root and Password: "
  sudo --preserve-env=PATH -u vagrant kubectl get secret gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo

elif  [[ $arch == aarch64 ]]; then
  ARCH="arm64"
  echo -e '\e[38;5;198m'"CPU is $ARCH"
  echo -e '\e[38;5;198m'"++++ Trying to get Gitlab running on Mac M1 Chipset"
  echo -e '\e[38;5;198m'"++++ https://gitlab.com/gypsophlia/gitlab-build-arm64/-/tree/master"
  # https://gitlab.com/gypsophlia/gitlab-build-arm64/-/blob/master/build-gitlab-docker-arm64.sh
  # Running Gitlab on Mac M1 Chipset
  echo -e '\e[38;5;198m'"++++ Clone Repo https://gitlab.com/gitlab-org/omnibus-gitlab.git"
  VERSION=13.4.0
  # Replace BASE_URL and VERSION when the official arm64 package is available
  BASE_URL=https://packages.gitlab.com/gitlab/gitlab-ce/packages/ubuntu/focal/
  rm -rf omnibus-gitlab
  sudo --preserve-env=PATH -u vagrant git clone https://gitlab.com/gitlab-org/omnibus-gitlab.git
  cd omnibus-gitlab
  sudo --preserve-env=PATH -u vagrant git checkout $VERSION+ce.0

  echo -e '\e[38;5;198m'"++++ Docker Build"
  sudo --preserve-env=PATH -u vagrant sed 's/FROM\ ubuntu:16.04/FROM\ ubuntu:20.04/g' ./docker/Dockerfile > ./docker/Dockerfile_ubuntu_20.04
  echo "RELEASE_PACKAGE=gitlab-ce" > ./docker/RELEASE
  echo "RELEASE_VERSION=$VERSION-ce.0" >> ./docker/RELEASE
  echo "DOWNLOAD_URL=$BASE_URL/gitlab-ce_$VERSION-ce.0_arm64.deb/download.deb" >> ./docker/RELEASE
  sudo --preserve-env=PATH -u vagrant docker build -f ./docker/Dockerfile_ubuntu_20.04 -t gitlab/gitlab-ce:$VERSION-ce.0 --platform linux/arm64 ./docker/

  echo -e '\e[38;5;198m'"++++ Docker Images"
  sudo --preserve-env=PATH -u vagrant docker images

  echo -e '\e[38;5;198m'"++++ Docker Run"
  sudo docker run --detach \
    --memory-swap 4096M \
    --oom-kill-disable \
    --memory 2048M \
    --hostname 10.9.99.10 \
    --publish 0.0.0.0:5543:443 --publish 0.0.0.0:5580:80 --publish 0.0.0.0:32022:22 \
    --name gitlab \
    --restart always \
    gitlab/gitlab-ce:13.4.0-ce.0
  
  sleep 60;
  sh -c 'sudo docker logs gitlab -f | { sed "/gitlab Reconfigured!/ q" && kill $$ ;}'

  echo -e '\e[38;5;198m'"++++ Creating Gitlab CE login credentials"
  sudo docker exec gitlab gitlab-rails runner -e production " \
    user = User.find_by(email: 'admin@example.com'); \
    user.password = user.password_confirmation = 'password'; \
    user.save!"

  echo -e '\e[38;5;198m'"Tada! Gitlab CE http://localhost:5580 and login with Username: root and Password: password"
fi

# https://docs.gitlab.com/runner/install/linux-manually.html
echo -e '\e[38;5;198m'"++++ Installing Gitlab-Runner"
if [[ $arch == x86_64* ]]; then
  ARCH="amd64"
  sudo curl -L --output /usr/bin/gitlab-runner "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64"
elif  [[ $arch == aarch64 ]]; then
  ARCH="arm64"
  sudo curl -L --output /usr/bin/gitlab-runner "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-arm64"
fi
sudo chmod +x /usr/bin/gitlab-runner
sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
sudo gitlab-runner start

echo -e '\e[38;5;198m'"++++ Please login to Gitlab and create a project called My awesome project"
echo -e '\e[38;5;198m'"++++ Please follow the rest of the instructions here: http://localhost:3333/#/gitlab/README?id=you-are-here"

# # DEPRECATED: We are now running Gitlab on Minikube instead of Gitlab Omnibus with docker run
# echo -e '\e[38;5;198m'"++++ Launch Gitlab on docker daemon"
# # https://docs.gitlab.com/omnibus/docker/ Gitlab via docker standalone
# sudo docker run --detach \
# --memory-swap 4096M \
# --oom-kill-disable \
# --memory 2048M \
# --hostname 10.9.99.10 \
# --publish 0.0.0.0:5543:443 --publish 0.0.0.0:5580:80 --publish 0.0.0.0:5522:22 \
# --name gitlab \
# --restart always \
# gitlab/gitlab-ce:latest
# sudo docker run -d --name gitlab-runner --memory 64M --restart always \
# -v /var/run/docker.sock:/var/run/docker.sock \
# gitlab/gitlab-runner:latest
# sh -c 'sudo docker logs gitlab -f | { sed "/gitlab Reconfigured!/ q" && kill $$ ;}'
# echo -e '\e[38;5;198m'"++++ sudo docker run --rm -v /vagrant/gitlab/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register \
#   --non-interactive \
#   --executor \"docker\" \
#   --docker-image alpine:latest \
#   --url \"http://10.9.99.10:5580/\" \
#   --description \"docker-runner\" \
#   --maintenance-note \"Free-form maintainer notes about this runner\" \
#   --tag-list \"my,awesome,project\" \
#   --run-untagged=\"true\" \
#   --locked=\"false\" \
#   --access-level=\"not_protected\" \
#   --registration-token \"PROJECT_REGISTRATION_TOKEN\""
# echo -e '\e[38;5;198m'"++++ Creating Gitlab CE login credentials"
# sudo docker exec gitlab gitlab-rails runner -e production " \
#   user = User.find_by(email: 'admin@example.com'); \
#   user.password = user.password_confirmation = 'password'; \
#   user.save!"

# echo -e '\e[38;5;198m'"Tada! Gitlab CE http://localhost:5580 and login with Username: root and Password: password"
