#!/bin/bash
# Centralized configuration for HashiQube

# Source version information
if [ -f "$(dirname "$0")/versions.sh" ]; then
  source "$(dirname "$0")/versions.sh"
fi

# Source architecture detection
if [ -f "$(dirname "$0")/detect_arch.sh" ]; then
  source "$(dirname "$0")/detect_arch.sh"
fi

# Source error handling
if [ -f "$(dirname "$0")/error_handling.sh" ]; then
  source "$(dirname "$0")/error_handling.sh"
fi

# Set colors for output
MAGENTA='\e[38;5;198m'
GREEN='\e[32m'
RED='\e[31m'
YELLOW='\e[33m'
NC='\e[0m' # No Color

# Detect provider
if [ -z "$PROVIDER" ]; then
  if [ -f "/etc/environment" ]; then
    source /etc/environment
  fi
  
  if [ -z "$PROVIDER" ]; then
    # Try to detect provider
    if [ -d "/vagrant" ]; then
      if systemd-detect-virt | grep -q "docker"; then
        PROVIDER="docker"
      elif systemd-detect-virt | grep -q "oracle"; then
        PROVIDER="virtualbox"
      elif systemd-detect-virt | grep -q "microsoft"; then
        PROVIDER="hyperv"
      else
        PROVIDER="unknown"
      fi
    else
      PROVIDER="unknown"
    fi
  fi
fi

# Detect OS
if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS_NAME=$NAME
  OS_VERSION=$VERSION_ID
  OS_ID=$ID
else
  OS_NAME="Unknown"
  OS_VERSION="Unknown"
  OS_ID="unknown"
fi

# Detect memory and CPU
TOTAL_MEMORY=$(free -m | awk '/^Mem:/{print $2}')
TOTAL_CPU=$(nproc)

# Network configuration
NETWORK_INTERFACE=$(ip route | grep default | awk '{print $5}' | head -n 1)
IP_ADDRESS=$(ip -4 addr show $NETWORK_INTERFACE | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1)
HOSTNAME=$(hostname)

# HashiQube configuration
HASHIQUBE_DATA_DIR="/var/lib/hashiqube"
HASHIQUBE_CONFIG_DIR="/etc/hashiqube"
HASHIQUBE_LOG_DIR="/var/log/hashiqube"
HASHIQUBE_BACKUP_DIR="/vagrant/backups"

# Create directories if they don't exist
mkdir -p "$HASHIQUBE_DATA_DIR" "$HASHIQUBE_CONFIG_DIR" "$HASHIQUBE_LOG_DIR" "$HASHIQUBE_BACKUP_DIR" 2>/dev/null || true

# HashiCorp service configuration
VAULT_ADDR=${VAULT_ADDR:-"http://127.0.0.1:8200"}
CONSUL_HTTP_ADDR=${CONSUL_HTTP_ADDR:-"http://127.0.0.1:8500"}
NOMAD_ADDR=${NOMAD_ADDR:-"http://127.0.0.1:4646"}
BOUNDARY_ADDR=${BOUNDARY_ADDR:-"http://127.0.0.1:9200"}

# Docker configuration
DOCKER_REGISTRY=${DOCKER_REGISTRY:-"localhost:5002"}
DOCKER_REGISTRY_USER=${DOCKER_REGISTRY_USER:-"admin"}
DOCKER_REGISTRY_PASSWORD=${DOCKER_REGISTRY_PASSWORD:-$(openssl rand -base64 12)}
DOCKER_REGISTRY_EMAIL=${DOCKER_REGISTRY_EMAIL:-"admin@localhost"}

# Database configuration
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-$(openssl rand -base64 12)}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-$(openssl rand -base64 12)}
MSSQL_SA_PASSWORD=${MSSQL_SA_PASSWORD:-"P@ssw0rd1234"} # Must meet complexity requirements

# LDAP configuration
LDAP_ADMIN_PASSWORD=${LDAP_ADMIN_PASSWORD:-$(openssl rand -base64 12)}
LDAP_CONFIG_PASSWORD=${LDAP_CONFIG_PASSWORD:-$(openssl rand -base64 12)}

# Function to print system information
print_system_info() {
  echo -e "${MAGENTA}HashiQube System Information${NC}"
  echo -e "${MAGENTA}===========================${NC}"
  echo -e "${MAGENTA}Provider:${NC} $PROVIDER"
  echo -e "${MAGENTA}OS:${NC} $OS_NAME $OS_VERSION ($OS_ID)"
  echo -e "${MAGENTA}Architecture:${NC} $(detect_architecture)"
  echo -e "${MAGENTA}Memory:${NC} $TOTAL_MEMORY MB"
  echo -e "${MAGENTA}CPU:${NC} $TOTAL_CPU cores"
  echo -e "${MAGENTA}Hostname:${NC} $HOSTNAME"
  echo -e "${MAGENTA}IP Address:${NC} $IP_ADDRESS"
  echo -e "${MAGENTA}Network Interface:${NC} $NETWORK_INTERFACE"
}

# Function to print configuration
print_config() {
  echo -e "${MAGENTA}HashiQube Configuration${NC}"
  echo -e "${MAGENTA}=======================${NC}"
  echo -e "${MAGENTA}Data Directory:${NC} $HASHIQUBE_DATA_DIR"
  echo -e "${MAGENTA}Config Directory:${NC} $HASHIQUBE_CONFIG_DIR"
  echo -e "${MAGENTA}Log Directory:${NC} $HASHIQUBE_LOG_DIR"
  echo -e "${MAGENTA}Backup Directory:${NC} $HASHIQUBE_BACKUP_DIR"
  echo -e "${MAGENTA}Vault Address:${NC} $VAULT_ADDR"
  echo -e "${MAGENTA}Consul Address:${NC} $CONSUL_HTTP_ADDR"
  echo -e "${MAGENTA}Nomad Address:${NC} $NOMAD_ADDR"
  echo -e "${MAGENTA}Boundary Address:${NC} $BOUNDARY_ADDR"
  echo -e "${MAGENTA}Docker Registry:${NC} $DOCKER_REGISTRY"
}

# Function to save configuration to file
save_config() {
  local config_file="$HASHIQUBE_CONFIG_DIR/hashiqube.conf"
  
  echo "# HashiQube Configuration" > "$config_file"
  echo "# Generated on $(date)" >> "$config_file"
  echo "" >> "$config_file"
  echo "# System Information" >> "$config_file"
  echo "PROVIDER=\"$PROVIDER\"" >> "$config_file"
  echo "OS_NAME=\"$OS_NAME\"" >> "$config_file"
  echo "OS_VERSION=\"$OS_VERSION\"" >> "$config_file"
  echo "OS_ID=\"$OS_ID\"" >> "$config_file"
  echo "ARCH=\"$(detect_architecture)\"" >> "$config_file"
  echo "TOTAL_MEMORY=\"$TOTAL_MEMORY\"" >> "$config_file"
  echo "TOTAL_CPU=\"$TOTAL_CPU\"" >> "$config_file"
  echo "HOSTNAME=\"$HOSTNAME\"" >> "$config_file"
  echo "IP_ADDRESS=\"$IP_ADDRESS\"" >> "$config_file"
  echo "NETWORK_INTERFACE=\"$NETWORK_INTERFACE\"" >> "$config_file"
  echo "" >> "$config_file"
  echo "# HashiQube Directories" >> "$config_file"
  echo "HASHIQUBE_DATA_DIR=\"$HASHIQUBE_DATA_DIR\"" >> "$config_file"
  echo "HASHIQUBE_CONFIG_DIR=\"$HASHIQUBE_CONFIG_DIR\"" >> "$config_file"
  echo "HASHIQUBE_LOG_DIR=\"$HASHIQUBE_LOG_DIR\"" >> "$config_file"
  echo "HASHIQUBE_BACKUP_DIR=\"$HASHIQUBE_BACKUP_DIR\"" >> "$config_file"
  echo "" >> "$config_file"
  echo "# HashiCorp Service Addresses" >> "$config_file"
  echo "VAULT_ADDR=\"$VAULT_ADDR\"" >> "$config_file"
  echo "CONSUL_HTTP_ADDR=\"$CONSUL_HTTP_ADDR\"" >> "$config_file"
  echo "NOMAD_ADDR=\"$NOMAD_ADDR\"" >> "$config_file"
  echo "BOUNDARY_ADDR=\"$BOUNDARY_ADDR\"" >> "$config_file"
  echo "" >> "$config_file"
  echo "# Docker Configuration" >> "$config_file"
  echo "DOCKER_REGISTRY=\"$DOCKER_REGISTRY\"" >> "$config_file"
  echo "DOCKER_REGISTRY_USER=\"$DOCKER_REGISTRY_USER\"" >> "$config_file"
  echo "DOCKER_REGISTRY_PASSWORD=\"$DOCKER_REGISTRY_PASSWORD\"" >> "$config_file"
  echo "DOCKER_REGISTRY_EMAIL=\"$DOCKER_REGISTRY_EMAIL\"" >> "$config_file"
  echo "" >> "$config_file"
  echo "# Database Configuration" >> "$config_file"
  echo "MYSQL_ROOT_PASSWORD=\"$MYSQL_ROOT_PASSWORD\"" >> "$config_file"
  echo "POSTGRES_PASSWORD=\"$POSTGRES_PASSWORD\"" >> "$config_file"
  echo "MSSQL_SA_PASSWORD=\"$MSSQL_SA_PASSWORD\"" >> "$config_file"
  echo "" >> "$config_file"
  echo "# LDAP Configuration" >> "$config_file"
  echo "LDAP_ADMIN_PASSWORD=\"$LDAP_ADMIN_PASSWORD\"" >> "$config_file"
  echo "LDAP_CONFIG_PASSWORD=\"$LDAP_CONFIG_PASSWORD\"" >> "$config_file"
  
  chmod 600 "$config_file"
  echo -e "${GREEN}Configuration saved to $config_file${NC}"
}

# Function to load configuration from file
load_config() {
  local config_file="$HASHIQUBE_CONFIG_DIR/hashiqube.conf"
  
  if [ -f "$config_file" ]; then
    source "$config_file"
    echo -e "${GREEN}Configuration loaded from $config_file${NC}"
  else
    echo -e "${YELLOW}Configuration file $config_file not found${NC}"
    echo -e "${YELLOW}Using default configuration${NC}"
  fi
}

# Export all variables
export_config() {
  # System Information
  export PROVIDER
  export OS_NAME
  export OS_VERSION
  export OS_ID
  export ARCH
  export TOTAL_MEMORY
  export TOTAL_CPU
  export HOSTNAME
  export IP_ADDRESS
  export NETWORK_INTERFACE
  
  # HashiQube Directories
  export HASHIQUBE_DATA_DIR
  export HASHIQUBE_CONFIG_DIR
  export HASHIQUBE_LOG_DIR
  export HASHIQUBE_BACKUP_DIR
  
  # HashiCorp Service Addresses
  export VAULT_ADDR
  export CONSUL_HTTP_ADDR
  export NOMAD_ADDR
  export BOUNDARY_ADDR
  
  # Docker Configuration
  export DOCKER_REGISTRY
  export DOCKER_REGISTRY_USER
  export DOCKER_REGISTRY_PASSWORD
  export DOCKER_REGISTRY_EMAIL
  
  # Database Configuration
  export MYSQL_ROOT_PASSWORD
  export POSTGRES_PASSWORD
  export MSSQL_SA_PASSWORD
  
  # LDAP Configuration
  export LDAP_ADMIN_PASSWORD
  export LDAP_CONFIG_PASSWORD
}

# If this script is sourced, just define the variables and functions
# If it's executed directly, print the configuration
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  # Try to load existing configuration
  load_config
  
  # Print system information and configuration
  print_system_info
  echo ""
  print_config
  
  # Save configuration if it doesn't exist
  if [ ! -f "$HASHIQUBE_CONFIG_DIR/hashiqube.conf" ]; then
    echo ""
    echo -e "${YELLOW}No configuration file found. Creating one...${NC}"
    save_config
  fi
  
  # Export configuration
  export_config
fi
