#!/bin/bash

# https://docs.gitlab.com/charts/installation/version_mappings.html#previous-chart-versions
GITLAB_HELM_CHART_VERSION=7.2.4 # Which is Gitlab v16.2.4

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Cleanup"
echo -e '\e[38;5;198m'"++++ "
sudo docker stop gitlab
sudo docker rm gitlab
sudo docker stop gitlab-runner
sudo docker rm gitlab-runner
yes | sudo docker system prune -a
yes | sudo docker system prune --volumes
sudo --preserve-env=PATH -u vagrant helm list
sudo --preserve-env=PATH -u vagrant helm uninstall gitlab
sudo --preserve-env=PATH -u vagrant helm list

arch=$(lscpu | grep "Architecture" | awk '{print $NF}')
if [[ $arch == x86_64* ]]; then
  ARCH="amd64"
elif  [[ $arch == aarch64 ]]; then
  ARCH="arm64"
fi
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"CPU is $ARCH"
echo -e '\e[38;5;198m'"++++ "

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"Ensure Minikube is running"
echo -e '\e[38;5;198m'"++++ "
if pgrep -x "minikube" >/dev/null
then
  echo "Minikube is running"
else
  echo -e '\e[38;5;198m'"Minikube is not running, launching"
  sudo bash /vagrant/minikube/minikube.sh
fi

# https://docs.gitlab.com/charts/development/minikube/ Gitlab via minikube
# https://gitlab.com/gitlab-org/charts/gitlab
# https://docs.gitlab.com/ee/administration/troubleshooting/kubernetes_cheat_sheet.html
# https://docs.gitlab.com/runner/install/kubernetes.html

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ helm repo add gitlab https://charts.gitlab.io/"
echo -e '\e[38;5;198m'"++++ "
sudo --preserve-env=PATH -u vagrant helm repo add gitlab https://charts.gitlab.io/

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ helm repo update"
echo -e '\e[38;5;198m'"++++ "
sudo --preserve-env=PATH -u vagrant helm repo update

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ helm search repo gitlab"
echo -e '\e[38;5;198m'"++++ "
sudo --preserve-env=PATH -u vagrant helm search repo gitlab

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Launch Gitlab on minikube using Helm Charts"
echo -e '\e[38;5;198m'"++++ "

# BUG: https://gitlab.com/gitlab-org/charts/gitlab/-/issues/4205
# https://docs.gitlab.com/charts/charts/globals.html
# https://docs.gitlab.com/charts/charts/globals.html#configure-host-settings
# https://helm.sh/docs/helm/helm_upgrade/
# https://docs.gitlab.com/charts/installation/deployment.html
# https://docs.gitlab.com/charts/installation/command-line-options.html
# https://gitlab.com/gitlab-org/charts/gitlab/-/blob/master/doc/installation/command-line-options.md
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Helm install gitlab"
echo -e '\e[38;5;198m'"++++ "
sudo --preserve-env=PATH -u vagrant helm install --version $GITLAB_HELM_CHART_VERSION \
  --namespace default gitlab \
  --timeout 600s \
  --set global.edition=ce \
  --set global.hosts.https=false \
  --set global.hosts.domain=localhost \
  --set global.hosts.hostSuffix="" \
  --set global.hosts.externalIP=$(sudo --preserve-env=PATH -u vagrant minikube ip) \
  --set global.hosts.gitlab.name=localhost \
  --set gitlab-runner.install=false \
  --set gitlab-runner.gitlabUrl="localhost:5580" \
  --set registry.enabled=false \
  --set gitlab.webservice.registry.enabled=false \
  --set gitlab.sidekiq.registry.enabled=false \
  --set gitlab-runner.runners.privileged=true \
  --set redis.resources.requests.memory=128Mi \
  -f https://gitlab.com/gitlab-org/charts/gitlab/raw/master/examples/values-minikube-minimum.yaml gitlab/gitlab

# INFO: Other flags I have tried during this process
# --set global.hosts.domain=localhost \
# --set global.hosts.gitlab.name=localhost \
# --set global.hosts.gitlab.hostnameOverride=localhost \
# --set global.hosts.ssh=localhost \
# --set global.hosts.kas.name=localhost \
# --set global.hosts.minio.name=localhost \
# --set global.workhorse.host=localhost \
# --set global.webservice.serviceName=webservice-default \
# --set global.webservice.port=5580 \
# --set gitlab.webservice.service.workhorseExternalPort=5580 \
# --set global.hosts.shell.port=32022 \
# --set global.hosts.externalIP=$(sudo --preserve-env=PATH -u vagrant minikube ip) \
# --set global.hosts.gitlab.hostnameOverride=localhost \
# --set gitlab-runner.gitlabUrl=localhost:5580 \
# --set global.webservice.serviceName=localhost \
# --set global.workhorse.host=localhost \
# --set global.workhorse.serviceName=gitlab-webservice-default \
# --set global.hosts.gitlab.servicePort=5580 \
# --set global.workhorse.port=5580 \
# --set global.hosts.gitlab.name=localhost \
# --set global.hosts.gitlab.hostnameOverride=localhost \
# --set global.hosts.hostSuffix="" \

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Stretch your legs, get a coffee or a drink, ETA 10m.."
echo -e '\e[38;5;198m'"++++ Waiting for Gitlab to become available.."
echo -e '\e[38;5;198m'"++++ See Minikube Dashboard for details: http://localhost:10888"
echo -e '\e[38;5;198m'"++++ "

attempts=0
max_attempts=15
while ! ( sudo --preserve-env=PATH -u vagrant kubectl get po | grep gitlab-webservice | tr -s " " | cut -d " " -f3 | grep Running ) && (( $attempts < $max_attempts )); do
  attempts=$((attempts+1))
  sleep 60;
  echo -e '\e[38;5;198m'"++++ Waiting for Gitlab to become available, (${attempts}/${max_attempts}) sleep 60s"
  sudo --preserve-env=PATH -u vagrant kubectl get po | grep gitlab
  sudo --preserve-env=PATH -u vagrant kubectl get events | grep -e Memory -e OOM
done

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Waiting for Gitlab to stabalize, sleep 60s"
echo -e '\e[38;5;198m'"++++ "
sleep 30;
sudo --preserve-env=PATH -u vagrant kubectl get po | grep gitlab
sudo --preserve-env=PATH -u vagrant kubectl get events | grep -e Memory -e OOM

# https://gitlab.com/gitlab-org/charts/gitlab/-/issues/2572 Error 422
# https://stackoverflow.com/questions/67084554/how-to-kubectl-port-forward-gitlab-webservice
attempts=0
max_attempts=20
while ! ( sudo netstat -nlp | grep "0.0.0.0:5580" ) && (( $attempts < $max_attempts )); do
  attempts=$((attempts+1))
  sleep 60;
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ kubectl port-forward -n default service/gitlab-webservice-default 5580:8181 --address=\"0.0.0.0\", (${attempts}/${max_attempts}) sleep 60s"
  echo -e '\e[38;5;198m'"++++ "
  sudo --preserve-env=PATH -u vagrant kubectl port-forward -n default service/gitlab-webservice-default 5580:8181 --address="0.0.0.0" > /dev/null 2>&1 &
done

attempts=0
max_attempts=20
while ! ( sudo netstat -nlp | grep "0.0.0.0:80" ) && (( $attempts < $max_attempts )); do
  attempts=$((attempts+1))
  sleep 60;
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ kubectl port-forward -n default service/gitlab-webservice-default 80:8181 --address=\"0.0.0.0\", (${attempts}/${max_attempts}) sleep 60s"
  echo -e '\e[38;5;198m'"++++ "
  sudo --preserve-env=PATH -u vagrant kubectl port-forward -n default service/gitlab-webservice-default 80:8181 --address="0.0.0.0" > /dev/null 2>&1 &
done

attempts=0
max_attempts=20
while ! ( sudo netstat -nlp | grep "0.0.0.0:8181" ) && (( $attempts < $max_attempts )); do
  attempts=$((attempts+1))
  sleep 60;
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ kubectl port-forward -n default service/gitlab-webservice-default 8181:8181 --address=\"0.0.0.0\", (${attempts}/${max_attempts}) sleep 60s"
  echo -e '\e[38;5;198m'"++++ "
  sudo --preserve-env=PATH -u vagrant kubectl port-forward -n default service/gitlab-webservice-default 8181:8181 --address="0.0.0.0" > /dev/null 2>&1 &
done

# https://gitlab.com/gitlab-org/charts/gitlab/-/issues/2572 Error 422
# https://stackoverflow.com/questions/67084554/how-to-kubectl-port-forward-gitlab-webservice
attempts=0
max_attempts=20
while ! ( sudo netstat -nlp | grep 32022 ) && (( $attempts < $max_attempts )); do
  attempts=$((attempts+1))
  sleep 60;
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ kubectl port-forward -n default service/gitlab-gitlab-shell 32022:32022 --address=\"0.0.0.0\", (${attempts}/${max_attempts}) sleep 60s"
  echo -e '\e[38;5;198m'"++++ "
  sudo --preserve-env=PATH -u vagrant kubectl port-forward -n default service/gitlab-gitlab-shell 32022:32022 --address="0.0.0.0" > /dev/null 2>&1 &
done

attempts=0
max_attempts=30
while ! ( curl -s -w '%{http_code}' -o /dev/null "http://localhost:5580/users/sign_in" | grep 200) && (( $attempts < $max_attempts )); do
  attempts=$((attempts+1))
  sleep 60;
  echo -e '\e[38;5;198m'"++++ Waiting for Gitlab web interface to become ready, (${attempts}/${max_attempts}) sleep 60s"
  curl -s -w '%{http_code}' -o /dev/null "http://localhost:5580/users/sign_in"
done

# https://docs.gitlab.com/runner/install/linux-manually.html
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Installing Gitlab-Runner"
echo -e '\e[38;5;198m'"++++ "
curl -s https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq --allow-downgrades --assume-yes gitlab-runner=16.3.0 < /dev/null > /dev/null

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Gitlab CE http://localhost:5580 and login with Username: root and below password: "
sudo --preserve-env=PATH -u vagrant kubectl get secret gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Please login to Gitlab and create a project called test"
echo -e '\e[38;5;198m'"++++ Please follow the rest of the instructions here: http://localhost:3333/#/gitlab/README?id=you-are-here"
echo -e '\e[38;5;198m'"++++ "
