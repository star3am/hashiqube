# HashiCorp Boundary

<div align="center">
  <img src="images/boundary-logo.png" alt="HashiCorp Boundary Logo" width="300px">
  <br><br>
  <p><strong>Secure access to applications and infrastructure based on user identity</strong></p>
</div>

## 🚀 About

In this HashiQube DevOps lab, you'll get hands-on experience with HashiCorp Boundary, an identity-based secure access management solution.

Boundary is designed to grant access to critical systems using the principle of least privilege, solving challenges organizations encounter when users need to securely access applications and machines. Traditional products that grant access to systems are cumbersome, painful to maintain, or are black boxes lacking extensible APIs.

Boundary allows authenticated and authorized users to access secure systems in private networks without granting access to the larger network where those systems reside.

## 📰 Latest News

- [Boundary 0.12 introduces multi-hop sessions and SSH certificate injection](https://www.hashicorp.com/blog/boundary-0-12-introduces-multi-hop-sessions-and-ssh-certificate-injection)
- [Boundary 0.10 Expands Credential Management and Admin UI IAM Workflows](https://www.hashicorp.com/blog/boundary-0-10-expands-credential-management-and-admin-ui-iam-workflows)
- [HashiCorp Boundary 0.8 Expands Health and Events Observability](https://www.hashicorp.com/blog/hashicorp-boundary-0-8-expands-health-and-events-observability)

## 🎬 Introduction

<div align="center">
  <a href="https://www.youtube.com/watch?v=tUMe7EsXYBQ">
    <img src="images/maxresdefault.jpeg" alt="Introduction to HashiCorp Boundary" width="85%">
  </a>
  <p><em>Click the image to watch an introduction to HashiCorp Boundary by Armon Dadgar, HashiCorp Co-Founder and CTO</em></p>
</div>

## 🔍 How It Works

<div align="center">
  <img src="images/boundary-how-it-works.png" alt="Hashicorp Boundary Architecture" width="85%">
  <p><em>Boundary architecture and workflow</em></p>
</div>

## 🖥️ User Interface

<div align="center">
  <img src="images/boundary-login-page.png" alt="Hashicorp Boundary Login Page" width="85%">
  <p><em>Boundary login page</em></p>
</div>

<div align="center">
  <img src="images/boundary-logged-in-page.png" alt="Hashicorp Boundary Dashboard" width="85%">
  <p><em>Boundary dashboard after login</em></p>
</div>

## 📋 Provision

<!-- tabs:start -->

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash boundary/boundary.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docsify,boundary
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docsify/docsify.sh
bash boundary/boundary.sh
```

<!-- tabs:end -->

## 🔑 Access Information

After provisioning, you can access Boundary at:

- **URL**: <http://localhost:9200>
- **Username**: admin
- **Password**: password

## 🛠️ Key Features

- **Identity-based access control** for users, services, and systems
- **Dynamic host catalogs** that automatically discover and register available targets
- **Just-in-time credential injection** for sessions
- **Multi-hop sessions** for secure access to remote networks
- **Fine-grained authorization** with role-based access control
- **Observability** through health checks and events monitoring
- **API-driven architecture** for automation and integration

## 🧩 Boundary Architecture Components

- **Controllers** - Manage the Boundary control plane
- **Workers** - Handle connections from clients to targets
- **Targets** - Resources that clients connect to through Boundary
- **Auth Methods** - Ways users can authenticate to Boundary
- **Projects** - Organizational units for targets
- **Host Catalogs** - Collections of hosts that can be used as targets
- **Sessions** - Active connections between clients and targets

## 📜 Provisioner Script

The script below automates the setup of Boundary in your HashiQube environment:

```bash
#!/bin/bash

# Print the commands that are run
set -x

# Stop execution if something fails
set -e

# This script provisions HashiCorp Boundary

# Get IP for Hashiqube
HOSTIP=$(hostname -I | awk '{print $2}')
if [[ -z "$HOSTIP" ]]; then
  HOSTIP=$(hostname -I | awk '{print $1}')
fi

# Check if Vault is installed
if [[ -z $(which boundary) ]]; then
  echo "Installing Boundary..."
  curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
  apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  apt-get update && apt-get install -y boundary
fi

# Clean up 
echo "Cleaning up..."
# Kill any running boundary process
if [[ $(pgrep -f "/usr/bin/boundary") ]]; then
  pkill -f "^/usr/bin/boundary"
fi

# Check if boundary directory exists and remove it
if [[ -d "/etc/boundary.d" ]]; then
  rm -rf /etc/boundary.d
fi

# Create boundary directory
mkdir -p /etc/boundary.d

# Create boundary config file
echo "Creating boundary config..."
cat <<EOF > /etc/boundary.d/controller.hcl
# Disable memory lock: https://www.man7.org/linux/man-pages/man2/mlock.2.html
disable_mlock = true

# Controller configuration
controller {
  # This name attr must be unique across all controller instances if running in HA mode
  name = "demo-controller-1"
  description = "A controller for a demo!"

  # Database URL for postgres. This can be a direct "postgres://"
  # URL, or it can be "file://" to read the contents of a file to
  # supply the url, or "env://" to name an environment variable
  # that contains the URL.
  database {
    url = "postgres://postgres:hashiqube@localhost:5432/postgres?sslmode=disable"
  }
}

# API listener configuration block
listener "tcp" {
  # Should be the address of the NIC that the controller server will be reached on
  address = "${HOSTIP}:9200"
  # The purpose of this listener block
  purpose = "api"

  tls_disable = true

  # Uncomment to enable CORS for the Admin UI. Be sure to set the allowed origin(s)
  # to appropriate values.
  #cors_enabled = true
  #cors_allowed_origins = ["https://yourcorp.yourdomain.com", "serve://boundary"]
}

# Data-plane listener configuration block (used for worker coordination)
listener "tcp" {
  # Should be the IP of the NIC that worker hosts will connect to
  address = "${HOSTIP}:9201"
  # The purpose of this listener
  purpose = "cluster"
  tls_disable = true
}

# Root KMS configuration block: this is the root key for Boundary
# Use a production KMS such as AWS KMS in production installs
kms "aead" {
  purpose = "root"
  aead_type = "aes-gcm"
  key = "sP1fnF6Xz+ldq8OZ0LnrrTmayr3cZIr0PWCB1n6DevE="
  key_id = "global_root"
}

# Worker authorization KMS
# Use a production KMS such as AWS KMS for production installs
# This key is the same key used in the worker configuration
kms "aead" {
  purpose = "worker-auth"
  aead_type = "aes-gcm"
  key = "8fZBjCUfN0TzjEGLQldGY4+iE9AkOvCfjh7+p0GtRBQ="
  key_id = "global_worker-auth"
}

# Recovery KMS block: configures the recovery key for Boundary
# Use a production KMS such as AWS KMS for production installs
kms "aead" {
  purpose = "recovery"
  aead_type = "aes-gcm"
  key = "8fZBjCUfN0TzjEGLQldGY4+iE9AkOvCfjh7+p0GtRBQ="
  key_id = "global_recovery"
}
EOF

# Create worker config file
echo "Creating worker config..."
cat <<EOF > /etc/boundary.d/worker.hcl
# Disable memory lock: https://www.man7.org/linux/man-pages/man2/mlock.2.html
disable_mlock = true

# Worker name
worker {
  # Worker name and description
  name = "demo-worker-1"
  description = "A default worker created for demonstration"

  # This section allows the worker to register with the Boundary controller on startup
  controllers = ["${HOSTIP}:9201"]

  # Tags for the worker
  tags {
    type   = ["dev", "worker"]
    region = ["local"]
  }
}

# this block configures the events system
events {
  audit_enabled       = true
  sysevents_enabled   = true
  observations_enable = true
  sampling_enabled    = true
}

# Worker authorization KMS block
# Use a production KMS such as AWS KMS for production installs
# This key is the same key used in the controller configuration
kms "aead" {
  purpose = "worker-auth"
  aead_type = "aes-gcm"
  key = "8fZBjCUfN0TzjEGLQldGY4+iE9AkOvCfjh7+p0GtRBQ="
  key_id = "global_worker-auth"
}
EOF

# Create boundary systemd service file
echo "Creating boundary systemd service..."
cat <<EOF > /etc/systemd/system/boundary-controller.service
[Unit]
Description=Boundary Controller Service
Documentation=https://www.boundaryproject.io/
After=network.target postgresql.service

[Service]
ExecStart=/usr/bin/boundary server -config=/etc/boundary.d/controller.hcl
ExecReload=/bin/kill -HUP \$MAINPID
KillSignal=SIGINT
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

# Create boundary worker systemd service file
echo "Creating boundary worker systemd service..."
cat <<EOF > /etc/systemd/system/boundary-worker.service
[Unit]
Description=Boundary Worker Service
Documentation=https://www.boundaryproject.io/
After=network.target boundary-controller.service

[Service]
ExecStart=/usr/bin/boundary server -config=/etc/boundary.d/worker.hcl
ExecReload=/bin/kill -HUP \$MAINPID
KillSignal=SIGINT
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

# Install Postgres if not installed
echo "Installing Postgres if not installed..."
if [[ -z $(which psql) ]]; then
  apt-get update && apt-get install -y postgresql postgresql-contrib
  # Start Postgres
  systemctl start postgresql
  
  # Create boundary database
  sudo -u postgres psql -c "CREATE USER postgres WITH PASSWORD 'hashiqube';"
  sudo -u postgres psql -c "CREATE DATABASE boundary;"
  sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE boundary TO postgres;"
fi

# Enable and start boundary services
echo "Starting boundary services..."
systemctl daemon-reload
systemctl enable boundary-controller
systemctl start boundary-controller
systemctl enable boundary-worker
systemctl start boundary-worker

# Wait for boundary to start
echo "Waiting for boundary to start..."
sleep 10

# Initialize Boundary
echo "Initializing boundary..."
boundary dev --api-listen-address="127.0.0.1:9200" &
DEV_PID=$!

# Wait for dev mode to start
sleep 5

# Kill dev mode
kill $DEV_PID

# Login to boundary
echo "Logging in to boundary..."
boundary authenticate password \
  -auth-method-id=ampw_1234567890 \
  -login-name=admin \
  -password=password \
  -keyring-type=none \
  -format=json

echo "Boundary is now running!"
echo "Access the UI at http://${HOSTIP}:9200"
echo "Login with admin / password"
```

## 🔗 Additional Resources

- [Boundary Official Website](https://www.boundaryproject.io/)
- [Boundary Documentation](https://www.boundaryproject.io/docs)
- [Boundary GitHub Repository](https://github.com/hashicorp/boundary)
- [Boundary Tutorials](https://learn.hashicorp.com/boundary)
- [Boundary CLI Reference](https://www.boundaryproject.io/docs/api-clients/cli)
