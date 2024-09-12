#!/bin/bash
# https://learn.hashicorp.com/tutorials/boundary/getting-started-install
# https://learn.hashicorp.com/tutorials/boundary/getting-started-dev
# https://developer.hashicorp.com/boundary/docs/commands/dev

VERSION=latest

arch=$(lscpu | grep "Architecture" | awk '{print $NF}')
if [[ $arch == x86_64* ]]; then
  ARCH="amd64"
elif  [[ $arch == aarch64 ]]; then
  ARCH="arm64"
fi
echo -e '\e[38;5;198m'"CPU is $ARCH"

sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes install -qq curl unzip jq < /dev/null > /dev/null

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Cleanup any Boundary if found"
echo -e '\e[38;5;198m'"++++ "
docker stop $(docker ps | tr -s " " | grep postgres | cut -d " " -f1)
yes | sudo docker system prune -a
yes | sudo docker system prune --volumes
sudo systemctl stop boundary
sudo rm -rf /usr/local/bin/boundary
sudo rm -rf /etc/boundary
sudo rm -rf /var/lib/boundary
sudo rm -rf /tmp/boundary.zip
sudo rm -rf /var/log/boundary.log

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

if [ -f /vagrant/boundary/license.hclic ]; then
  # https://developer.hashicorp.com/boundary/tutorials/enterprise/hashicorp-enterprise-license
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Found license.hclic Installing Enterprise Edition version: $VERSION"
  echo -e '\e[38;5;198m'"++++ "
  export BOUNDARY_LICENSE_PATH=/vagrant/boundary/license.hclic
  export BOUNDARY_LICENSE=$(cat /vagrant/boundary/license.hclic)
  if [[ $VERSION == "latest" ]]; then
    LATEST_URL=$(curl -sL https://releases.hashicorp.com/boundary/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep 'ent' | egrep "linux.*$ARCH" | sort -V | tail -n 1)
  else
    LATEST_URL=$(curl -sL https://releases.hashicorp.com/boundary/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep 'ent' | egrep "linux.*$ARCH" | sort -V | grep $VERSION | tail -1)
  fi
else
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Installing Community Edition version: $VERSION"
  echo -e '\e[38;5;198m'"++++ "
  if [[ $VERSION == "latest" ]]; then
    LATEST_URL=$(curl -sL https://releases.hashicorp.com/boundary/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep -v 'rc|ent|beta' | egrep "linux.*$ARCH" | sort -V | tail -n 1)
  else
    LATEST_URL=$(curl -sL https://releases.hashicorp.com/boundary/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep -v 'rc|ent|beta' | egrep "linux.*$ARCH" | sort -V | grep $VERSION | tail -1)
  fi
fi
wget -q $LATEST_URL -O /tmp/boundary.zip

mkdir -p /usr/local/bin
(cd /usr/local/bin && unzip -o /tmp/boundary.zip)
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Installed `/usr/local/bin/boundary -version`"
echo -e '\e[38;5;198m'"++++ "

# create boundary data directories
sudo mkdir -p /etc/boundary
sudo mkdir -p /var/lib/boundary

# create /var/log/boundary.log
sudo touch /var/log/boundary.log
sudo touch /etc/boundary/boundary.env

# create user named boundary
sudo useradd --system --home /etc/boundary --shell /bin/false boundary
sudo chown -R boundary:boundary /etc/boundary /var/lib/boundary

# give boundary permission to docker daemon
# Error creating dev database container: unable to start dev database with dialect postgres: could not start resource: dial unix /var/run/docker.sock: connect: permission denied
sudo usermod -aG docker boundary

# https://developer.hashicorp.com/boundary/docs/install-boundary/systemd
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Create Boundary Systemd service file"
echo -e '\e[38;5;198m'"++++ "
cat <<EOF | sudo tee /etc/systemd/system/boundary.service
[Unit]
Description=Boundary
Documentation=https://www.boundaryproject.io/docs/
Wants=network-online.target
After=network-online.target

[Service]
EnvironmentFile=/etc/boundary/boundary.env
ExecReload=/bin/kill -HUP $MAINPID
# https://developer.hashicorp.com/boundary/docs/commands/dev
ExecStart=/usr/local/bin/boundary dev -api-listen-address 0.0.0.0:19200 -ops-listen-address 0.0.0.0 -controller-public-cluster-address 0.0.0.0 -proxy-listen-address 0.0.0.0:9202 -cluster-listen-address 0.0.0.0:9201 -worker-public-address 0.0.0.0 -log-level debug
KillMode=process
KillSignal=SIGINT
LimitNOFILE=65536
# User=boundary
# Group=boundary
LimitMEMLOCK=infinity
Restart=on-failure
RestartSec=2
Capabilities=CAP_IPC_LOCK+ep
CapabilityBoundingSet=CAP_SYSLOG CAP_IPC_LOCK
StandardOutput=append:/var/log/boundary.log
StandardError=append:/var/log/boundary.log

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

# https://developer.hashicorp.com/boundary/docs/configuration/controller#complete-configuration-example
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Create Boundary config file /etc/boundary/server.conf"
echo -e '\e[38;5;198m'"++++ "
cat <<EOF | sudo tee /etc/boundary/server.conf
# Disable memory lock: https://www.man7.org/linux/man-pages/man2/mlock.2.html
disable_mlock = true

# Controller configuration block
controller {
  # This name attr must be unique across all controller instances if running in HA mode
  name = "hashiqube-controller-1"
  description = "A controller for Hashiqube demo!"

  database {
    url = "postgresql://boundary:PASSWORD@127.0.0.1:5432/boundary"
  }

  # After receiving a shutdown signal, Boundary will wait 10s before initiating the shutdown process.
  graceful_shutdown_wait_duration = "10s"
}

listener "tcp" {
  purpose = "api"
  address = "0.0.0.0:19200"
}
EOF
# https://developer.hashicorp.com/boundary/docs/enterprise/licensing
# BUG: https://developer.hashicorp.com/vault/tutorials/enterprise/hashicorp-enterprise-license#read-from-a-file-optional specify license_path while
# https://developer.hashicorp.com/boundary/docs/enterprise/licensing specify license
if [ -f /vagrant/boundary/license.hclic ]; then
  sed -i -e 's;graceful_shutdown_wait_duration = "10s";graceful_shutdown_wait_duration = "10s"\n  license = "file:///vagrant/boundary/license.hclic";' /etc/boundary/server.conf
  echo BOUNDARY_LICENSE=$(cat /vagrant/boundary/license.hclic) | sudo tee /etc/boundary/boundary.env
fi

# create /var/log/boundary.log
sudo touch /var/log/boundary.log

# start and enable boundary service to start on system boot
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Start Boundary Service"
echo -e '\e[38;5;198m'"++++ "
sudo systemctl daemon-reload
sudo service boundary start
sh -c 'sudo tail -f /var/log/boundary.log | { sed "/Boundary server started/ q" && kill $$ ;}'

if [ -f /vagrant/boundary/license.hclic ]; then
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Boundary License Inspect"
  echo -e '\e[38;5;198m'"++++ "
  boundary -version
fi

# https://developer.hashicorp.com/boundary/docs/commands
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Set Boundary Environment Variables"
echo -e '\e[38;5;198m'"++++ "
export BOUNDARY_PASSWORD=password
export BOUNDARY_ADDR=http://localhost:19200

# https://developer.hashicorp.com/boundary/tutorials/community-administration/community-manage-targets
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Athenticating Boundary client"
echo -e '\e[38;5;198m'"++++ "
boundary authenticate password -addr=http://127.0.0.1:19200 -login-name=admin -password=env://BOUNDARY_PASSWORD -keyring-type=none > /etc/boundary/auth.info

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Set Boundary Token ENV variable"
echo -e '\e[38;5;198m'"++++ "
export BOUNDARY_TOKEN=$(cat /etc/boundary/auth.info | tail -n 1)

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ List Boundary targets"
echo -e '\e[38;5;198m'"++++ "
boundary targets list -recursive -token env://BOUNDARY_TOKEN

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Print Boundary ENV variables"
echo -e '\e[38;5;198m'"++++ "
for i in $(env | grep BOUNDARY); do echo "export $i"; done

# echo -e '\e[38;5;198m'"++++ "
# echo -e '\e[38;5;198m'"++++ DEBUG: Test Boundary target"
# echo -e '\e[38;5;198m'"++++ "
# boundary connect ssh -target-id ttcp_g4twnnFCNk -token env://BOUNDARY_TOKEN -username vagrant

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Access Boundary"
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Boundary Server started at http://localhost:19200"
echo -e '\e[38;5;198m'"++++ Login with admin:password"
echo -e '\e[38;5;198m'"++++ Boundary Documentation http://localhost:3333/#/hashicorp/README?id=boundary"
