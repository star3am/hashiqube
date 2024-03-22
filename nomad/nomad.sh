#!/bin/bash

VERSION=latest

function nomad-install() {

  if pgrep -x "consul" >/dev/null
  then
    echo "Consul is running"
  else
    echo -e '\e[38;5;198m'"++++ Ensure Consul is running.."
    sudo bash /vagrant/consul/consul.sh
  fi

  arch=$(lscpu | grep "Architecture" | awk '{print $NF}')
  if [[ $arch == x86_64* ]]; then
    ARCH="amd64"
  elif  [[ $arch == aarch64 ]]; then
    ARCH="arm64"
  fi
  echo -e '\e[38;5;198m'"CPU is $ARCH"

  sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes install -qq iproute2 curl unzip jq < /dev/null > /dev/null
  yes | sudo docker system prune -a
  yes | sudo docker system prune --volumes
  mkdir -p /etc/nomad
  cat <<EOF | sudo tee /etc/nomad/server.conf
data_dir  = "/var/lib/nomad"

bind_addr = "0.0.0.0" # the default

datacenter = "dc1"

advertise {
  # Defaults to the first private IP address.
  http = "10.9.99.10"
  rpc  = "10.9.99.10"
  serf = "10.9.99.10:5648" # non-default ports may be specified
}

server {
  enabled          = true
  bootstrap_expect = 1
}

client {
  enabled       = true
  # https://github.com/hashicorp/nomad/issues/1282
  network_speed = 100
  # https://developer.hashicorp.com/nomad/docs/configuration/client#cpu_total_compute
  # BUG: CPU fingerprint with Docker Desktop on Apple Silicon never really worked because the CPU speed is not made available anywhere, so its impossible for Nomad to detect it
  # If you run previous versions of Nomad you will notice that the fingerprinted capacity is always 1000MHz. This is a value we used to hardcode as a fallback but we dont anymore on 1.7.x (https://github.com/hashicorp/nomad/blob/release/1.6.x/client/fingerprint/cpu.go#L23) because its just wrong.
  # The only option for now is to pass their own hardcoded value using client.cpu_total_compute (https://developer.hashicorp.com/nomad/docs/configuration/client#cpu_total_compute)
  cpu_total_compute = 8000
  servers = ["10.9.99.10:4647"]
  # network_interface = "enp0s8"
  # https://www.nomadproject.io/docs/drivers/docker.html#volumes
  # https://github.com/hashicorp/nomad/issues/5562
  options = {
    "docker.volumes.enabled" = true
    "docker.auth.config"     = "/etc/docker/auth.json"
  }
  host_volume "waypoint" {
    path      = "/opt/nomad/data/volume/waypoint"
    read_only = false
  }
}

plugin "raw_exec" {
  config {
    enabled = true
  }
}

# https://developer.hashicorp.com/nomad/docs/configuration/telemetry
# https://developer.hashicorp.com/nomad/docs/configuration/telemetry#prometheus
# https://developer.hashicorp.com/nomad/docs/operations/monitoring-nomad
telemetry {
  collection_interval = "1s"
  disable_hostname = true
  prometheus_metrics = true
  publish_allocation_metrics = true
  publish_node_metrics = true
}

consul {
  address = "10.9.99.10:8500"
}
EOF
  # create a Nomad service file at /etc/systemd/system/nomad.service
  cat <<EOF | sudo tee /etc/systemd/system/nomad.service
[Unit]
Description=Nomad
Documentation=https://nomadproject.io/docs/
Wants=network-online.target
After=network-online.target

# When using Nomad with Consul it is not necessary to start Consul first. These
# lines start Consul before Nomad as an optimization to avoid Nomad logging
# that Consul is unavailable at startup.
#Wants=consul.service
#After=consul.service

[Service]
# EnvironmentFile=/etc/nomad.d/nomad.env
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/usr/local/bin/nomad agent -config=/etc/nomad/server.conf -dev-connect
KillMode=process
KillSignal=SIGINT
LimitNOFILE=65536
LimitNPROC=infinity
Restart=on-failure
RestartSec=2
LogsDirectory=nomad
StandardOutput=append:/var/log/nomad.log
StandardError=append:/var/log/nomad.log
StartLimitBurst=3

## Configure unit start rate limiting. Units which are started more than
## *burst* times within an *interval* time span are not permitted to start any
## more. Use StartLimitIntervalSec or StartLimitInterval (depending on
## systemd version) to configure the checking interval and StartLimitBurst
## to configure how many starts per interval are allowed. The values in the
## commented lines are defaults.

TasksMax=infinity
OOMScoreAdjust=-1000

[Install]
WantedBy=multi-user.target
EOF
  echo -e '\e[38;5;198m'"++++ Creating Waypoint host volume /opt/nomad/data/volume/waypoint"
  sudo mkdir -p /opt/nomad/data/volume/waypoint
  sudo chmod -R 777 /opt/nomad
  # check if nomad is installed, start and exit
  sudo rm -rf /usr/local/bin/nomad
  if [ -f /usr/local/bin/nomad ]; then
    echo -e '\e[38;5;198m'"++++ Nomad already installed at /usr/local/bin/nomad"
    echo -e '\e[38;5;198m'"++++ `/usr/local/bin/nomad version`"
    if [ -f /opt/cni/bin/bridge ]; then
      echo -e '\e[38;5;198m'"++++ cni-plugins already installed"
    else
      wget -q https://github.com/containernetworking/plugins/releases/download/v1.3.0/cni-plugins-linux-$ARCH-v1.3.0.tgz -O /tmp/cni-plugins.tgz
      mkdir -p /opt/cni/bin
      tar -C /opt/cni/bin -xzf /tmp/cni-plugins.tgz
      echo 1 > /proc/sys/net/bridge/bridge-nf-call-arptables
      echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables
      echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
    fi
    pkill nomad
    sleep 10
    pkill nomad
    pkill nomad
    touch /var/log/nomad.log
    sudo service nomad restart
    sh -c 'sudo tail -f /var/log/nomad.log | { sed "/node registration complete/ q" && kill $$ ;}'
    nomad server members
    nomad node status
  else
  # if nomad is not installed, download and install
    echo -e '\e[38;5;198m'"++++ Nomad not installed, installing.."
    if [[ $VERSION == "latest" ]]; then
      echo "Installing version: $VERSION"
      LATEST_URL=$(curl -sL https://releases.hashicorp.com/nomad/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep -v 'rc|beta' | egrep "linux.*$ARCH" | sort -V | tail -n1)
    else
      echo "Installing version: $VERSION"
      LATEST_URL=$(curl -sL https://releases.hashicorp.com/nomad/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep -v 'rc|beta' | egrep "linux.*$ARCH" | sort -V | grep $VERSION | tail -1)
    fi
    wget -q $LATEST_URL -O /tmp/nomad.zip
    mkdir -p /usr/local/bin
    (cd /usr/local/bin && unzip /tmp/nomad.zip)
    echo -e '\e[38;5;198m'"++++ Installed `/usr/local/bin/nomad version`"
    wget -q https://github.com/containernetworking/plugins/releases/download/v1.3.0/cni-plugins-linux-$ARCH-v1.3.0.tgz -O /tmp/cni-plugins.tgz
    mkdir -p /opt/cni/bin
    tar -C /opt/cni/bin -xzf /tmp/cni-plugins.tgz
    echo 1 > /proc/sys/net/bridge/bridge-nf-call-arptables
    echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables
    echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
    pkill nomad
    sleep 10
    pkill nomad
    pkill nomad
    touch /var/log/nomad.log
    sudo service nomad restart
    sh -c 'sudo tail -f /var/log/nomad.log | { sed "/node registration complete/ q" && kill $$ ;}'
    nomad server members
    nomad node status
  fi
  cd /vagrant/nomad/nomad/jobs;
  #nomad plan --address=http://localhost:4646 countdashboard.nomad
  #nomad run --address=http://localhost:4646 countdashboard.nomad
  #nomad plan --address=http://localhost:4646 countdashboardtest.nomad
  #nomad run --address=http://localhost:4646 countdashboardtest.nomad
  nomad plan --address=http://localhost:4646 fabio.nomad
  nomad run --address=http://localhost:4646 fabio.nomad
  nomad plan --address=http://localhost:4646 traefik.nomad
  nomad run --address=http://localhost:4646 traefik.nomad
  nomad plan --address=http://localhost:4646 traefik-whoami.nomad
  nomad run --address=http://localhost:4646 traefik-whoami.nomad
  # curl -v -H 'Host: fabio.service.consul' http://${VAGRANT_IP}:9999/
  echo -e '\e[38;5;198m'"++++ Nomad http://localhost:4646"
  echo -e '\e[38;5;198m'"++++ Nomad Documentation http://localhost:3333/#/nomad/README?id=nomad"
  echo -e '\e[38;5;198m'"++++ Fabio Dashboard http://localhost:9998"
  echo -e '\e[38;5;198m'"++++ Fabio Loadbalancer http://localhost:9998"
  echo -e '\e[38;5;198m'"++++ Fabio Documentation http://localhost:3333/#/nomad/README?id=fabio-load-balancer-for-nomad"
  echo -e '\e[38;5;198m'"++++ Treafik Dashboard http://localhost:8081"
  echo -e '\e[38;5;198m'"++++ Traefik Loadbalancer: http://localhost:8080"
  echo -e '\e[38;5;198m'"++++ Traefik Documentation: http://localhost:3333/#/nomad/README?id=traefik-load-balancer-for-nomad"
}

nomad-install
