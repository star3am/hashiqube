#!/bin/bash
# https://github.com/k3s-io/k3s/tree/master?tab=readme-ov-file#quick-start---install-script

function k3s-install() {
  # Determine CPU Architecture
  arch=$(lscpu | grep "Architecture" | awk '{print $NF}')
  if [[ $arch == x86_64* ]]; then
    ARCH="amd64"
  elif  [[ $arch == aarch64 ]]; then
    ARCH="arm64"
  fi
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ CPU is $ARCH"
  echo -e '\e[38;5;198m'"++++ "
  
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
  echo -e '\e[38;5;198m'"++++ Delete Minikube if exists"
  echo -e '\e[38;5;198m'"++++ "
  for mkd in $(ps aux | grep -e dashboard -e kubectl | grep -v grep | grep -v nomad | tr -s " " | cut -d " " -f2); do bash -c "sudo kill -9 $mkd || true"; done
  sleep 10;
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Check minikube proccesses if exists"
  echo -e '\e[38;5;198m'"++++ "
  bash -c "ps aux | grep -e dashboard -e kubectl || true"
  sleep 5;

  sudo --preserve-env=PATH -u vagrant minikube delete --all --purge || true
  sleep 30;
  sudo rm -rf /home/vagrant/.kube
  sudo rm -rf /home/vagrant/.minikube
  # BUG: https://github.com/kubernetes/minikube/issues/7511 - gave me lots of issues
  sudo rm -rf /var/lib/docker/volumes/minikube

  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Delete K3s"
  echo -e '\e[38;5;198m'"++++ "
  sudo bash /usr/local/bin/k3s-uninstall.sh || true

  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Installing K3s"
  echo -e '\e[38;5;198m'"++++ "
  curl -sfL https://get.k3s.io | sh -

  # https://docs.k3s.io/cluster-access#accessing-the-cluster-from-outside-with-kubectl
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Configure K3s Cluster access to user ubuntu"
  echo -e '\e[38;5;198m'"++++ "
  # Set kube config for root
  sudo mkdir -p /root/.kube
  sudo cp /etc/rancher/k3s/k3s.yaml /root/.kube/config
  # Set kube config for user ubuntu
  mkdir -p /home/vagrant/.kube
  sudo cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
  sudo chown -R vagrant:vagrant /home/vagrant/.kube

  # https://helm.sh/docs/intro/install/#from-script
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Installing Helm"
  echo -e '\e[38;5;198m'"++++ "
  cd /tmp
  sudo curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
  sudo chmod 700 get_helm.sh
  sudo /tmp/get_helm.sh

  # https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Installing Kubernetes dashboard"
  echo -e '\e[38;5;198m'"++++ "
  helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
  helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
  attempts=0
  max_attempts=50 # for slow connections, pods takes longer to download and initialize
  while ! ( sudo netstat -nlp | grep 8001 ) && (( $attempts < $max_attempts )); do
    attempts=$((attempts+1))
    sleep 10;
    echo -e '\e[38;5;198m'"++++ "
    echo -e '\e[38;5;198m'"++++ kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8001:443 --address=\"0.0.0.0\", (${attempts}/${max_attempts}) sleep 10s"
    echo -e '\e[38;5;198m'"++++ "
    kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8001:443 --address="0.0.0.0" > /dev/null 2>&1 &
  done

  # https://github.com/komodorio/helm-dashboard
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Installing Helm Dashboard"
  echo -e '\e[38;5;198m'"++++ "
  helm plugin install https://github.com/komodorio/helm-dashboard.git

  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Running Helm Dashboard"
  echo -e '\e[38;5;198m'"++++ "
  helm dashboard --bind=0.0.0.0 --port 8002 --no-browser --no-analytics > /dev/null 2>&1 &

  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Create ServiceAccount and ClusterRoleBinding"
  echo -e '\e[38;5;198m'"++++ "
  kubectl apply -f /vagrant/k3s/dashboard-adminuser.yaml
  kubectl apply -f /vagrant/k3s/dashboard-rolebind.yaml

  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Get admin-user token"
  echo -e '\e[38;5;198m'"++++ "
  kubectl -n kube-system create token admin-user --duration=8760h

  if [[ $CODESPACES == true ]]; then
    KUBERNETES_DASHBOARD_URL="https://${CODESPACE_NAME}-8001.app.github.dev"
    HELM_DASHBOARD_URL="https://${CODESPACE_NAME}-8002.app.github.dev"
  else
    KUBERNETES_DASHBOARD_URL="https://localhost:8001"
    HELM_DASHBOARD_URL="http://localhost:8002"
  fi
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Kubernetes Dashboard: ${KUBERNETES_DASHBOARD_URL} using the token above"
  echo -e '\e[38;5;198m'"++++ Helm Dashboard: ${HELM_DASHBOARD_URL}"
  echo -e '\e[38;5;198m'"++++ "

  # echo -e '\e[38;5;198m'"++++ "
  # echo -e '\e[38;5;198m'"++++ Debug"
  # echo -e '\e[38;5;198m'"++++ "
  # k3s check-config
}

k3s-install