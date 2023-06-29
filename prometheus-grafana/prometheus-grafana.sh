#!/bin/bash

# https://prometheus.io/docs/visualization/grafana/#using
# https://blog.marcnuri.com/prometheus-grafana-setup-minikube

cd ~/
# Determine CPU Architecture
arch=$(lscpu | grep "Architecture" | awk '{print $NF}')
if [[ $arch == x86_64* ]]; then
  ARCH="amd64"
elif  [[ $arch == aarch64 ]]; then
  ARCH="arm64"
fi
echo -e '\e[38;5;198m'"CPU is $ARCH"

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Cleanup"
echo -e '\e[38;5;198m'"++++ "
sudo docker stop grafana prometheus
sudo docker rm grafana prometheus
yes | sudo docker system prune -a
yes | sudo docker system prune --volumes
for i in $(ps aux | grep kubectl | grep -ve sudo -ve grep -ve bin | grep -e grafana -e prometheus -e alertmanager | tr -s " " | cut -d " " -f2); do kill -9 $i; done
sudo --preserve-env=PATH -u vagrant helm uninstall prometheus
sudo --preserve-env=PATH -u vagrant helm uninstall grafana

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ helm version"
echo -e '\e[38;5;198m'"++++ "
sudo --preserve-env=PATH -u vagrant helm version

# https://helm.sh/docs/intro/quickstart/#initialize-a-helm-chart-repository
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Helm add Prometheus repo"
echo -e '\e[38;5;198m'"++++ helm repo add prometheus-community https://prometheus-community.github.io/helm-charts"
echo -e '\e[38;5;198m'"++++ "
sudo --preserve-env=PATH -u vagrant helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ helm repo update"
echo -e '\e[38;5;198m'"++++ "
sudo --preserve-env=PATH -u vagrant helm repo update
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ helm search repo prometheus-community"
echo -e '\e[38;5;198m'"++++ "
sudo --preserve-env=PATH -u vagrant helm search repo prometheus-community
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ helm install prometheus prometheus-community/prometheus"
echo -e '\e[38;5;198m'"++++ "
sudo --preserve-env=PATH -u vagrant helm install prometheus prometheus-community/prometheus

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Helm add Grafana repo"
echo -e '\e[38;5;198m'"++++ helm repo add grafana https://grafana.github.io/helm-charts"
echo -e '\e[38;5;198m'"++++ "
sudo --preserve-env=PATH -u vagrant helm repo add grafana https://grafana.github.io/helm-charts
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ helm repo update"
echo -e '\e[38;5;198m'"++++ "
sudo --preserve-env=PATH -u vagrant helm repo update
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ helm search repo grafana"
echo -e '\e[38;5;198m'"++++ "
sudo --preserve-env=PATH -u vagrant helm search repo grafana
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ helm install grafana grafana/grafana"
echo -e '\e[38;5;198m'"++++ "
sudo --preserve-env=PATH -u vagrant helm install grafana grafana/grafana

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Waiting for Prometheus and Alertmanager and Grafana to become available.."
echo -e '\e[38;5;198m'"++++ See Minikube Dashboard for details: http://localhost:10888"
echo -e '\e[38;5;198m'"++++ "

attempts=0
max_attempts=15
while ! ( sudo --preserve-env=PATH -u vagrant kubectl get po | grep prometheus | tr -s " " | cut -d " " -f3 | grep Running ) && (( $attempts < $max_attempts )); do
  attempts=$((attempts+1))
  sleep 60;
  echo -e '\e[38;5;198m'"++++ Waiting for Prometheus to become available, (${attempts}/${max_attempts}) sleep 60s"
  sudo --preserve-env=PATH -u vagrant kubectl get po
  sudo --preserve-env=PATH -u vagrant kubectl get events | grep -e Memory -e OOM
done

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Waiting for Prometheus to stabalize, sleep 30s"
echo -e '\e[38;5;198m'"++++ "
sleep 30;
sudo --preserve-env=PATH -u vagrant kubectl get po
sudo --preserve-env=PATH -u vagrant kubectl get events | grep -e Memory -e OOM

# https://gitlab.com/gitlab-org/charts/gitlab/-/issues/2572 Error 422
echo -e '\e[38;5;198m'"The easiest way to access this service is to let kubectl to forward the port:"
echo -e '\e[38;5;198m'"kubectl port-forward service/prometheus-server 9090:9090"
# https://stackoverflow.com/questions/67084554/how-to-kubectl-port-forward-gitlab-webservice
# https://github.com/kubernetes/kubernetes/issues/44371

attempts=0
max_attempts=20
while ! ( sudo netstat -nlp | grep 9090 ) && (( $attempts < $max_attempts )); do
  attempts=$((attempts+1))
  sleep 60;
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ kubectl port-forward -n default prometheus-server 9090 --address=\"0.0.0.0\", (${attempts}/${max_attempts}) sleep 60s"
  echo -e '\e[38;5;198m'"++++ "
  sudo --preserve-env=PATH -u vagrant kubectl port-forward --namespace default $(sudo --preserve-env=PATH -u vagrant kubectl get po -n default | grep prometheus-server | tr -s " " | cut -d " " -f1) 9090 --address="0.0.0.0" > /dev/null 2>&1 &
done

attempts=0
max_attempts=20
while ! ( sudo netstat -nlp | grep 9093 ) && (( $attempts < $max_attempts )); do
  attempts=$((attempts+1))
  sleep 60;
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ kubectl port-forward -n default prometheus-alertmanager 9093 --address=\"0.0.0.0\", (${attempts}/${max_attempts}) sleep 60s"
  echo -e '\e[38;5;198m'"++++ "
  sudo --preserve-env=PATH -u vagrant kubectl port-forward --namespace default $(sudo --preserve-env=PATH -u vagrant kubectl get po -n default | grep prometheus-alertmanager | tr -s " " | cut -d " " -f1) 9093 --address="0.0.0.0" > /dev/null 2>&1 &
done

attempts=0
max_attempts=20
while ! ( sudo netstat -nlp | grep 3000 ) && (( $attempts < $max_attempts )); do
  attempts=$((attempts+1))
  sleep 60;
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ kubectl port-forward -n default grafana 3000 --address=\"0.0.0.0\", (${attempts}/${max_attempts}) sleep 60s"
  echo -e '\e[38;5;198m'"++++ "
  sudo --preserve-env=PATH -u vagrant kubectl port-forward --namespace default $(sudo --preserve-env=PATH -u vagrant kubectl get po -n default | grep grafana | tr -s " " | cut -d " " -f1) 3000 --address="0.0.0.0" > /dev/null 2>&1 &
done

ps aux | grep kubectl | grep -ve sudo -ve grep -ve bin

# https://github.com/grafana/grafana/issues/29296
echo -e '\e[38;5;198m'"++++ Prometheus http://localhost:9090"
echo -e '\e[38;5;198m'"++++ Alertmanager http://localhost:9093"
echo -e '\e[38;5;198m'"++++ Grafana http://localhost:3000 and login with Username: admin Password:"
sudo --preserve-env=PATH -u vagrant kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
echo -e '\e[38;5;198m'"++++ You should now be able to access Prometheus http://localhost:9090 \
and Grafana http://localhost:3000 Please login to Grafana and add Prometheus (http://10.9.99.10:9090) as a Datasource, next \
please click on the + symbol in Grafana and import 6417 dashboard."
