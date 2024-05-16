#!/bin/bash
# https://argo-cd.readthedocs.io/en/stable/operator-manual/installation/
# https://devopscube.com/setup-argo-cd-using-helm/

arch=$(lscpu | grep "Architecture" | awk '{print $NF}')
if [[ $arch == x86_64* ]]; then
  ARCH="amd64"
elif  [[ $arch == aarch64 ]]; then
  ARCH="arm64"
fi
echo -e '\e[38;5;198m'"CPU is $ARCH"

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Ensure Docker Daemon is running (Dependency)"
echo -e '\e[38;5;198m'"++++ "
if pgrep -x "dockerd" >/dev/null
then
  echo -e '\e[38;5;198m'"++++ Docker is running"
else
  echo -e '\e[38;5;198m'"++++ Ensure Docker is running.."
  sudo bash /vagrant/docker/docker.sh
fi

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Ensure Minikube is running (Dependency)"
echo -e '\e[38;5;198m'"++++ "
if pgrep -x "minikube" >/dev/null
then
  echo "Minikube is running"
else
  echo -e '\e[38;5;198m'"Minikube is not running, launching"
  sudo bash /vagrant/minikube/minikube.sh
fi

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Create Argocd Namespace"
echo -e '\e[38;5;198m'"++++ "
sudo --preserve-env=PATH -u vagrant kubectl create namespace argocd

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Install Argocd using kubectl"
echo -e '\e[38;5;198m'"++++ "
sudo --preserve-env=PATH -u vagrant kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

attempts=0
max_attempts=20
while ! ( sudo --preserve-env=PATH -u vagrant kubectl get pods --namespace argocd | grep argocd-server | tr -s " " | cut -d " " -f3 | grep Running ) && (( $attempts < $max_attempts )); do
  attempts=$((attempts+1))
  sleep 60;
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Waiting for Argocd Server to become available, (${attempts}/${max_attempts}) sleep 60s"
  echo -e '\e[38;5;198m'"++++ "
  sudo --preserve-env=PATH -u vagrant kubectl get po,svc --namespace argocd
  sudo --preserve-env=PATH -u vagrant kubectl get events | grep -e Memory -e OOM
done

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Change the argocd-server service type to NodePort"
echo -e '\e[38;5;198m'"++++ "
sudo --preserve-env=PATH -u vagrant kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Get argocd-initial-admin-secret"
echo -e '\e[38;5;198m'"++++ "
export ARGOCD_PASSWORD=$(sudo --preserve-env=PATH -u vagrant kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)
echo -e '\e[38;5;198m'"++++ Argocd Admin Password: $ARGOCD_PASSWORD"

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ kubectl port-forward -n argocd service/argocd-server 18043:80 --address=\"0.0.0.0\""
echo -e '\e[38;5;198m'"++++ "
attempts=0
max_attempts=20
while ! ( sudo netstat -nlp | grep "0.0.0.0:18043" ) && (( $attempts < $max_attempts )); do
  attempts=$((attempts+1))
  sleep 60;
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ kubectl port-forward -n argocd service/argocd-server 18043:80 --address=\"0.0.0.0\", (${attempts}/${max_attempts}) sleep 60s"
  echo -e '\e[38;5;198m'"++++ "
  sudo --preserve-env=PATH -u vagrant kubectl port-forward -n argocd service/argocd-server 18043:80 --address="0.0.0.0" > /dev/null 2>&1 &
done

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Access Argocd"
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Argocd Server started at http://localhost:18043"
echo -e '\e[38;5;198m'"++++ Login with admin:$ARGOCD_PASSWORD"
echo -e '\e[38;5;198m'"++++ Argocd Documentation http://localhost:3333/#/argocd/README?id=argocd"

# TODO: read token and test login
# boundary authenticate password -login-name=admin -password password -auth-method-id=ampw_1234567890 -addr=http://127.0.0.1:19200
