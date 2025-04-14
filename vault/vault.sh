#!/bin/bash

# https://computingforgeeks.com/install-and-configure-vault-server-linux/
# https://www.vaultproject.io/

VERSION=latest

# Source the common architecture detection script
if [ -f /vagrant/hashiqube/detect_arch.sh ]; then
  source /vagrant/hashiqube/detect_arch.sh
  ARCH=$(detect_architecture)
  echo -e '\e[38;5;198m'"CPU architecture detected as $ARCH"
else
  echo -e '\e[38;5;198m'"Warning: Architecture detection script not found, defaulting to amd64"
  ARCH="amd64"
fi

sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes install -qq curl unzip jq < /dev/null > /dev/null

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Cleanup any Vault if found"
echo -e '\e[38;5;198m'"++++ "
sudo systemctl stop vault
sudo rm -rf /usr/local/bin/vault
sudo rm -rf /etc/vault
sudo rm -rf /var/lib/vault
sudo rm -rf /tmp/vault.zip

if [ -f /vagrant/vault/license.hclic ]; then
  # https://developer.hashicorp.com/vault/tutorials/enterprise/hashicorp-enterprise-license
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Found license.hclic Installing Enterprise Edition version: $VERSION"
  echo -e '\e[38;5;198m'"++++ "
  export VAULT_LICENSE_PATH=/vagrant/vault/license.hclic
  export VAULT_LICENSE=$(cat /vagrant/vault/license.hclic)
  if [[ $VERSION == "latest" ]]; then
    LATEST_URL=$(curl -sL https://releases.hashicorp.com/vault/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep 'ent' | egrep "linux.*$ARCH" | sort -V | tail -n 1)
  else
    LATEST_URL=$(curl -sL https://releases.hashicorp.com/vault/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep 'ent' | egrep "linux.*$ARCH" | sort -V | grep $VERSION | tail -1)
  fi
else
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Installing Community Edition version: $VERSION"
  echo -e '\e[38;5;198m'"++++ "
  if [[ $VERSION == "latest" ]]; then
    LATEST_URL=$(curl -sL https://releases.hashicorp.com/vault/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep -v 'rc|ent|beta' | egrep "linux.*$ARCH" | sort -V | tail -n 1)
  else
    LATEST_URL=$(curl -sL https://releases.hashicorp.com/vault/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep -v 'rc|ent|beta' | egrep "linux.*$ARCH" | sort -V | grep $VERSION | tail -1)
  fi
fi
wget -q $LATEST_URL -O /tmp/vault.zip

mkdir -p /usr/local/bin
(cd /usr/local/bin && unzip -o /tmp/vault.zip)
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Installed `/usr/local/bin/vault --version`"
echo -e '\e[38;5;198m'"++++ "

# create /var/log/vault.log
sudo touch /var/log/vault.log

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Enable Vault command autocompletion"
echo -e '\e[38;5;198m'"++++ "
vault -autocomplete-install
complete -C /usr/local/bin/vault vault

# create Vault data directories
sudo mkdir -p /etc/vault
sudo mkdir -p /var/lib/vault/data

# create user named vault
sudo useradd --system --home /etc/vault --shell /bin/false vault
sudo chown -R vault:vault /etc/vault /var/lib/vault/

# create a Vault service file at /etc/systemd/system/vault.service
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Create Vault Systemd service file"
echo -e '\e[38;5;198m'"++++ "
cat <<EOF | sudo tee /etc/systemd/system/vault.service
[Unit]
Description="HashiCorp Vault - A tool for managing secrets"
Documentation=https://www.vaultproject.io/docs/
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/vault/config.hcl

[Service]
User=vault
Group=vault
ProtectSystem=full
ProtectHome=read-only
PrivateTmp=yes
PrivateDevices=yes
SecureBits=keep-caps
AmbientCapabilities=CAP_IPC_LOCK
NoNewPrivileges=yes
ExecStart=/usr/local/bin/vault server -config=/etc/vault/config.hcl
ExecReload=/bin/kill --signal HUP
KillMode=process
KillSignal=SIGINT
Restart=on-failure
RestartSec=5
LogsDirectory=vault
StandardOutput=append:/var/log/vault.log
StandardError=append:/var/log/vault.log
TimeoutStopSec=30
StartLimitBurst=3
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Create Vault config file /etc/vault/config.hcl"
echo -e '\e[38;5;198m'"++++ "
# create Vault /etc/vault/config.hcl file
touch /etc/vault/config.hcl

# add basic configuration settings for Vault to /etc/vault/config.hcl file
# https://developer.hashicorp.com/vault/tutorials/raft/raft-storage#create-an-ha-cluster
cat <<EOF | sudo tee /etc/vault/config.hcl
ui = true
listener "tcp" {
  address         = "0.0.0.0:8200"
  cluster_address = "0.0.0.0:8201"
  tls_disable     = true
}
# https://developer.hashicorp.com/vault/tutorials/raft/raft-storage#create-an-ha-cluster
# seal "transit" {
#   address            = "http://0.0.0.0:8200"
#   # token is read from VAULT_TOKEN env
#   # token            = ""
#   disable_renewal    = "false"
#   key_name           = "unseal_key"
#   mount_path         = "transit/"
# }
storage "raft" {
  path    = "/var/lib/vault/data"
  node_id = "hashiqube0"
}
# use a file path as storage backend
# storage "file" {
#   path  = "/var/lib/vault/data"
# }
# use consul as storage backend
# storage "consul" {
#  address = "127.0.0.1:8500"
#  path    = "vault"
# }
# https://developer.hashicorp.com/vault/docs/configuration/telemetry
# https://developer.hashicorp.com/vault/docs/configuration/telemetry#prometheus
telemetry {
  disable_hostname = true
  prometheus_retention_time = "12h"
}
api_addr             = "http://10.9.99.10:8200"
max_lease_ttl        = "10h"
default_lease_ttl    = "10h"
cluster_name         = "hashiqube"
cluster_addr         = "http://10.9.99.10:8201"
raw_storage_endpoint = true
disable_cache        = true
disable_mlock        = true
disable_sealwrap     = true
disable_printable_check = true
EOF
if [ -f /vagrant/vault/license.hclic ]; then
  echo "license_path = \"/vagrant/vault/license.hclic\"" >> /etc/vault/config.hcl
fi

# start and enable vault service to start on system boot
sudo systemctl daemon-reload
sudo systemctl enable --now vault
sleep 20

# check vault status
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Check Vault Status"
echo -e '\e[38;5;198m'"++++ "
sudo systemctl status vault | cat

# initialize vault server
export VAULT_ADDR=http://127.0.0.1:8200
echo "export VAULT_ADDR=http://127.0.0.1:8200" >> ~/.bashrc

# start initialization with the default options by running the command below
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Initialize Vault"
echo -e '\e[38;5;198m'"++++ "
# Create a secure directory for Vault credentials with restricted permissions
sudo mkdir -p /etc/vault/secure
sudo chmod 700 /etc/vault/secure

# Initialize Vault and store credentials in a secure location
sudo rm -rf /etc/vault/secure/init.file
vault operator init > /etc/vault/secure/init.file
sudo chmod 600 /etc/vault/secure/init.file

# Create a symbolic link for backward compatibility
sudo ln -sf /etc/vault/secure/init.file /etc/vault/init.file

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Auto unseal vault"
echo -e '\e[38;5;198m'"++++ "
for i in $(cat /etc/vault/secure/init.file | grep Unseal | cut -d " " -f4 | head -n 3); do vault operator unseal $i; done
vault status

# Create a temporary token with limited TTL instead of using the root token
VAULT_ROOT_TOKEN=$(grep 'Initial Root Token' /etc/vault/secure/init.file | cut -d ':' -f2 | tr -d ' ')
export VAULT_TOKEN=${VAULT_ROOT_TOKEN}

# Create a policy for basic operations
cat <<EOF | vault policy write hashiqube-policy -
path "secret/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOF

# Create a token with the policy and limited TTL
TEMP_TOKEN_INFO=$(vault token create -policy=hashiqube-policy -ttl=24h -format=json)
VAULT_TOKEN=$(echo $TEMP_TOKEN_INFO | jq -r '.auth.client_token')
grep -q "${VAULT_TOKEN}" /etc/environment
if [ $? -eq 1 ]; then
  echo "VAULT_TOKEN=${VAULT_TOKEN}" >> /etc/environment
else
  sed -i "s/VAULT_TOKEN=.*/VAULT_TOKEN=${VAULT_TOKEN}/g" /etc/environment
fi
grep -q "VAULT_ADDR=http://127.0.0.1:8200" /etc/environment
if [ $? -eq 1 ]; then
  echo "VAULT_ADDR=http://127.0.0.1:8200" >> /etc/environment
else
  sed -i "s%VAULT_ADDR=.*%VAULT_ADDR=http://127.0.0.1:8200%g" /etc/environment
fi

export VAULT_TOKEN=${VAULT_TOKEN}

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Vault status"
echo -e '\e[38;5;198m'"++++ "
vault status

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Vault Credentials Info"
echo -e '\e[38;5;198m'"++++ "
echo "Vault credentials are stored securely in /etc/vault/secure/init.file"
echo "A temporary token with limited privileges has been created for daily use."
if [ -f /vagrant/vault/license.hclic ]; then
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Vault License Inspect"
  echo -e '\e[38;5;198m'"++++ "
  vault license inspect /vagrant/vault/license.hclic
fi

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Access Vault"
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Vault Temporary Token: ${VAULT_TOKEN}"
echo -e '\e[38;5;198m'"++++ Vault http://localhost:8200/ui and enter the token displayed above"
echo -e '\e[38;5;198m'"++++ Vault Documentation http://localhost:3333/#/vault/README?id=vault"

# TODO: FIXME
# https://www.vaultproject.io/docs/secrets/ssh/signed-ssh-certificates
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Lets use Vault for Signed SSH Certificates"
echo -e '\e[38;5;198m'"++++ "
echo -e "\n"

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ vault secrets enable -path=ssh-client-signer ssh"
echo -e '\e[38;5;198m'"++++ "
vault secrets enable -path=ssh-client-signer ssh

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ vault write ssh-client-signer/config/ca generate_signing_key=true"
echo -e '\e[38;5;198m'"++++ "
vault write ssh-client-signer/config/ca generate_signing_key=true

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ vault read -field=public_key ssh-client-signer/config/ca > /etc/ssh/trusted-user-ca-keys.pem"
echo -e '\e[38;5;198m'"++++ "
vault read -field=public_key ssh-client-signer/config/ca | sudo tee /etc/ssh/trusted-user-ca-keys.pem

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Add TrustedUserCAKeys /etc/ssh/trusted-user-ca-keys.pem to /etc/ssh/sshd_config and reload SSH"
echo -e '\e[38;5;198m'"++++ "
grep -q "TrustedUserCAKeys /etc/ssh/trusted-user-ca-keys.pem" /etc/ssh/sshd_config
if [ $? -eq 1 ]; then
  echo "TrustedUserCAKeys /etc/ssh/trusted-user-ca-keys.pem" | sudo tee -a /etc/ssh/sshd_config
else
  sudo sed -i "s/TrustedUserCAKeys \/etc\/ssh\/trusted-user-ca-keys.pe/TrustedUserCAKeys \/etc\/ssh\/trusted-user-ca-keys.pe/g" /etc/ssh/sshd_config
fi

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Restart SSH"
echo -e '\e[38;5;198m'"++++ "
# Configure SSH to allow password authentication
grep -q "PasswordAuthentication yes" /etc/ssh/sshd_config
if [ $? -eq 1 ]; then
  sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
fi
sudo systemctl reload ssh

# Set a default password for the ubuntu user
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Setting default password for ubuntu user"
echo -e '\e[38;5;198m'"++++ "
echo "ubuntu:vagrant" | sudo chpasswd

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Create a named Vault role for signing client keys"
echo -e '\e[38;5;198m'"++++ "
vault write ssh-client-signer/roles/my-role -<<EOH
{
  "allow_user_certificates": true,
  "allowed_users": "*",
  "allowed_extensions": "permit-pty,permit-port-forwarding",
  "default_extensions": [
    {
      "permit-pty": ""
    }
  ],
  "key_type": "ca",
  "default_user": "ubuntu",
  "ttl": "30m0s"
}
EOH

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Generate the SSH public key for user ubuntu"
echo -e '\e[38;5;198m'"++++ "
sudo -H -u ubuntu ssh-keygen -q -t rsa -N '' <<< ""$'\n'"y" 2>&1 >/dev/null

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Ask Vault to sign this created public key"
echo -e '\e[38;5;198m'"++++ "

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ vault write ssh-client-signer/sign/my-role public_key=@/home/ubuntu/.ssh/id_rsa.pub"
echo -e '\e[38;5;198m'"++++ "
sudo -H -u ubuntu vault write ssh-client-signer/sign/my-role public_key=@/home/ubuntu/.ssh/id_rsa.pub
sudo -H -u ubuntu vault write -field=signed_key ssh-client-signer/sign/my-role public_key=@/home/ubuntu/.ssh/id_rsa.pub | sudo -H -u ubuntu tee /home/ubuntu/.ssh/id_rsa-cert.pub

# Fix permissions on the SSH certificate file
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Fix permissions on SSH certificate files"
echo -e '\e[38;5;198m'"++++ "
sudo chmod 600 /home/ubuntu/.ssh/id_rsa-cert.pub
sudo chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa-cert.pub

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ View enabled extensions, principals, and metadata of the signed key"
echo -e '\e[38;5;198m'"++++ ssh-keygen -Lf /home/ubuntu/~/.ssh/id_rsa-cert.pub"
echo -e '\e[38;5;198m'"++++ "
sudo -H -u ubuntu ssh-keygen -Lf /home/ubuntu/.ssh/id_rsa-cert.pub

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ SSH to localhost using the signed key"
echo -e '\e[38;5;198m'"++++ sudo -H -u ubuntu ssh -v -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /home/ubuntu/.ssh/id_rsa-cert.pub -i /home/ubuntu/.ssh/id_rsa ubuntu@localhost"
echo -e '\e[38;5;198m'"++++ "
# Try SSH with certificate first
sudo -H -u ubuntu ssh -v -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /home/ubuntu/.ssh/id_rsa-cert.pub -i /home/ubuntu/.ssh/id_rsa ubuntu@localhost || true
SSH_RESULT=$?
echo "SSH exit code: $SSH_RESULT"

# If certificate-based SSH fails, inform about password-based login
if [ $SSH_RESULT -ne 0 ]; then
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Certificate-based SSH failed. You can use password-based login with:"
  echo -e '\e[38;5;198m'"++++ Username: ubuntu"
  echo -e '\e[38;5;198m'"++++ Password: vagrant"
  echo -e '\e[38;5;198m'"++++ "
fi

# https://www.vaultproject.io/docs/secrets/ssh/dynamic-ssh-keys
#sudo apt-get -y install pwgen
#sudo useradd -m -p $(openssl passwd -1 $(pwgen)) -s /bin/bash ubuntu
#echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu
#vault secrets enable ssh
#sudo -H -u ubuntu vault write ssh/keys/vault_key key=@/home/ubuntu/.ssh/id_rsa
#vault write ssh/roles/dynamic_key_role key_type=dynamic key=vault_key admin_user=ubuntu default_user=ubuntu cidr_list=0.0.0.0/0

#echo -e '\e[38;5;198m'"++++ Please run the following on your local computer"
#echo -e '\e[38;5;198m'"++++ export VAULT_TOKEN=$(grep 'Initial Root Token' /etc/vault/init.file | cut -d ':' -f2 | tr -d ' ')"
#echo -e '\e[38;5;198m'"++++ export VAULT_ADDR=http://10.9.99.10:8200"
#echo -e '\e[38;5;198m'"++++ vagrant ssh -c \"vault write ssh/creds/dynamic_key_role ip=10.9.99.10\""

# check vault status
# vault status

# replace “s.BOKlKvEAxyn5OS0LvfhzvBur” with your Initial Root Token stored in the /etc/vault/init.file file
# export VAULT_TOKEN="s.RcW0LuNIyCoTLWxrDPtUDkCw"

# enable approle authentication
# vault auth enable approle
# Success! Enabled approle auth method at: approle/

# same command can be used for other Authentication methods, e.g

# vault auth enable kubernetes
# Success! Enabled kubernetes auth method at: kubernetes/

# vault auth enable userpass
# Success! Enabled userpass auth method at: userpass/

# vault auth enable ldap
# Success! Enabled ldap auth method at: ldap/

# list all Authentication methods using the command
# vault auth list

# get secret engine path:
# vault secrets list

# write a secret to your kv secret engine.
# vault kv put secret/databases/db1 username=DBAdmin
# Success! Data written to: secret/databases/db1

# vault kv put secret/databases/db1 password=StrongPassword
# Success! Data written to: secret/databases/db1

# you can even use single line command to write multiple data.
# vault kv put secret/databases/db1 username=DBAdmin password=StrongPassword
# Success! Data written to: secret/databases/db1

# to get a secret, use vault get command.
# vault kv get secret/databases/db1

# get data in json format:
# vault kv get -format=json secret/databases/db1

# to print only the value of a given field, use:
# vault kv get -field=username  secret/databases/db1

# to delete a Secret, use:
# vault kv delete secret/databases/db1
# Success! Data deleted (if it existed) at: secret/databases/db1

# vault kv get secret/databases/db1
# No value found at secret/databases/db1
