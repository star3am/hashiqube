#!/bin/bash
# https://www.nomadproject.io/guides/integrations/consul-connect/index.html

VERSION=1.17.3

arch=$(lscpu | grep "Architecture" | awk '{print $NF}')
if [[ $arch == x86_64* ]]; then
  ARCH="amd64"
elif  [[ $arch == aarch64 ]]; then
  ARCH="arm64"
fi
echo -e '\e[38;5;198m'"CPU is $ARCH"

sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes install -qq curl unzip jq < /dev/null > /dev/null

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Cleanup any Consul if found"
echo -e '\e[38;5;198m'"++++ "
sudo systemctl stop consul
sudo rm -rf /etc/consul
sudo rm -rf /etc/consul.d
sudo rm -rf /var/lib/consul
sudo rm -rf /tmp/consul.zip

if [ -f /vagrant/consul/license.hclic ]; then
  # https://developer.hashicorp.com/consul/tutorials/enterprise/hashicorp-enterprise-license
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Found license.hclic Installing Enterprise Edition version: $VERSION"
  echo -e '\e[38;5;198m'"++++ "
  export CONSUL_LICENSE_PATH=/vagrant/consul/license.hclic
  export CONSUL_LICENSE=$(cat /vagrant/consul/license.hclic)
  if [[ $VERSION == "latest" ]]; then
    LATEST_URL=$(curl -sL https://releases.hashicorp.com/consul/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep 'ent' | egrep "linux.*$ARCH" | sort -V | tail -n 1)
  else
    LATEST_URL=$(curl -sL https://releases.hashicorp.com/consul/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep 'ent' | egrep "linux.*$ARCH" | sort -V | grep $VERSION | tail -1)
  fi
else
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Installing Community Edition version: $VERSION"
  echo -e '\e[38;5;198m'"++++ "
  if [[ $VERSION == "latest" ]]; then
    LATEST_URL=$(curl -sL https://releases.hashicorp.com/consul/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep -v 'rc|ent|beta' | egrep "linux.*$ARCH" | sort -V | tail -n 1)
  else
    LATEST_URL=$(curl -sL https://releases.hashicorp.com/consul/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep -v 'rc|ent|beta' | egrep "linux.*$ARCH" | sort -V | grep $VERSION | tail -1)
  fi
fi
wget -q $LATEST_URL -O /tmp/consul.zip

mkdir -p /usr/local/bin
(cd /usr/local/bin && unzip -o /tmp/consul.zip)
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Installed `/usr/local/bin/consul --version`"
echo -e '\e[38;5;198m'"++++ "

# create /var/log/consul.log
sudo touch /var/log/consul.log

# create Consul data directories
sudo mkdir -p /etc/consul
sudo mkdir -p /etc/consul.d

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Create Consul Systemd service file"
echo -e '\e[38;5;198m'"++++ "
# create a Consul service file at /etc/systemd/system/consul.service
cat <<EOF | sudo tee /etc/systemd/system/consul.service
[Unit]
Description=Consul
Documentation=https://www.consul.io/docs/
Wants=network-online.target
After=network-online.target

[Service]
# EnvironmentFile=/etc/consul.d/consul.env
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/usr/local/bin/consul agent -dev -client="0.0.0.0" -bind="0.0.0.0" -enable-script-checks -config-file=/etc/consul/server.hcl -config-dir=/etc/consul.d
KillMode=process
KillSignal=SIGINT
LimitNOFILE=65536
LimitNPROC=infinity
Restart=on-failure
RestartSec=2
LogsDirectory=consul
StandardOutput=append:/var/log/consul.log
StandardError=append:/var/log/consul.log
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

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Create Consul config file /etc/consul/server.hcl"
echo -e '\e[38;5;198m'"++++ "
cat <<EOF | sudo tee /etc/consul/server.hcl
primary_datacenter = "dc1"
client_addr = "0.0.0.0"
bind_addr = "0.0.0.0"
advertise_addr = "10.9.99.10"
data_dir = "/var/lib/consul"
datacenter = "dc1"
disable_host_node_id = true
disable_update_check = true
leave_on_terminate = true
log_level = "INFO"
server = true
ports = {
  grpc  = 8502
  dns   = 8600
  http  = 8500
  https = 8501
}
connect {
  enabled = true
  # enable_mesh_gateway_wan_federation = true
}
enable_central_service_config = true
protocol = 3
raft_protocol = 3
recursors = [
  "8.8.8.8",
  "8.8.4.4",
]
server_name = "hashiqube0.service.consul"
ui_config {
  enabled = true
}
# https://lvinsf.medium.com/monitor-consul-using-prometheus-and-grafana-1f2354cc002f
# https://grafana.com/grafana/dashboards/13396-consul-server-monitoring/
# https://developer.hashicorp.com/consul/docs/agent/telemetry
telemetry {
  prometheus_retention_time = "24h"
  disable_hostname = true
}
EOF
if [ -f /vagrant/consul/license.hclic ]; then
  echo "license_path = \"/vagrant/consul/license.hclic\"" >> /etc/consul/server.hcl
fi

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Create Consul Service config files"
echo -e '\e[38;5;198m'"++++ "
cat <<EOF | sudo tee /etc/consul.d/vault.json
{"service":
{"name": "vault",
"tags": ["urlprefix-vault.service.consul/"],
"address": "10.9.99.10",
"port": 8200
}}
EOF
cat <<EOF | sudo tee /etc/consul.d/docsify.json
{"service":
{"name": "docsify",
"tags": ["urlprefix-docsify.service.consul/"],
"address": "10.9.99.10",
"port": 3333
}}
EOF
cat <<EOF | sudo tee /etc/consul.d/hashiqube.json
{"service":
{"name": "hashiqube0",
"tags": ["urlprefix-hashiqube0.service.consul/"],
"address": "10.9.99.10",
"port": 22
}}
EOF

# start and enable consul service to start on system boot
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Start Consul Service"
echo -e '\e[38;5;198m'"++++ "
sudo systemctl daemon-reload
sudo service consul start
sh -c 'sudo tail -f /var/log/consul.log | { sed "/agent: Synced/ q" && kill $$ ;}'
sleep 20
consul members
consul info

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Adding Consul KV data for Fabio Load Balancer Routes"
echo -e '\e[38;5;198m'"++++ "
consul kv put fabio/config/vault1 "route add vault vault.service.consul:9999/ http://10.9.99.10:8200"
consul kv put fabio/config/vault2 "route add vault fabio.service.consul:9999/vault http://10.9.99.10:8200 opts \"strip=/vault\""
consul kv put fabio/config/nomad "route add nomad nomad.service.consul:9999/ http://10.9.99.10:4646"
consul kv put fabio/config/consul "route add consul consul.service.consul:9999/ http://10.9.99.10:8500"
consul kv put fabio/config/apache2 "route add apache2 fabio.service.consul:9999/apache2 http://10.9.99.10:8889 opts \"strip=/apache2\""
consul kv put fabio/config/countdashtest1 "route add countdashtest fabio.service.consul:9999/countdashtest http://10.9.99.10:9022/ opts \"strip=/countdashtest\""
consul kv put fabio/config/docsify "route add docsify docsify.service.consul:9999/ http://10.9.99.10:3333"

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Install DNSMasq"
echo -e '\e[38;5;198m'"++++ "
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
sleep 10;
sudo apt-get install -y -qq dnsmasq < /dev/null > /dev/null

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Adding DNSMasq config for Consul for DNS lookups"
echo -e '\e[38;5;198m'"++++ "
# https://learn.hashicorp.com/tutorials/consul/dns-forwarding#dnsmasq-setup
cat <<EOF | sudo tee /etc/dnsmasq.d/10-consul
# Enable forward lookup of the 'consul' domain:
server=/consul/10.9.99.10#8600

# Uncomment and modify as appropriate to enable reverse DNS lookups for
# common netblocks found in RFC 1918, 5735, and 6598:
#rev-server=0.0.0.0/8,127.0.0.1#8600
#rev-server=10.0.0.0/8,127.0.0.1#8600
#rev-server=100.64.0.0/10,127.0.0.1#8600
#rev-server=127.0.0.1/8,127.0.0.1#8600
#rev-server=169.254.0.0/16,127.0.0.1#8600
#rev-server=172.16.0.0/12,127.0.0.1#8600
#rev-server=192.168.0.0/16,127.0.0.1#8600
#rev-server=224.0.0.0/4,127.0.0.1#8600
#rev-server=240.0.0.0/4,127.0.0.1#8600
EOF
sudo systemctl restart dnsmasq

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Set /etc/resolv.conf configuration"
echo -e '\e[38;5;198m'"++++ "
cat <<EOF | sudo tee /etc/resolv.conf
nameserver 10.9.99.10
nameserver 8.8.8.8
EOF

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Access Consul"
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Consul http://localhost:8500"
echo -e '\e[38;5;198m'"++++ Consul Documentation http://localhost:3333/#/hashicorp/README?id=consul"
