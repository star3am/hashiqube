#!/bin/bash
# HashiQube One-Command Setup Script
# This script initializes all core HashiQube services in the correct order

# Set colors for output
MAGENTA='\e[38;5;198m'
GREEN='\e[32m'
RED='\e[31m'
YELLOW='\e[33m'
NC='\e[0m' # No Color

# Function to print section headers
print_header() {
  echo -e "${MAGENTA}=========================================${NC}"
  echo -e "${MAGENTA}  $1${NC}"
  echo -e "${MAGENTA}=========================================${NC}"
  echo ""
}

# Function to run a command with error handling
run_command() {
  local command=$1
  local description=$2

  echo -e "${YELLOW}Starting: ${description}...${NC}"

  if eval "$command"; then
    echo -e "${GREEN}✓ Completed: ${description}${NC}"
    echo ""
    return 0
  else
    echo -e "${RED}✗ Failed: ${description}${NC}"
    echo -e "${RED}Command failed: ${command}${NC}"
    echo ""
    return 1
  fi
}

# Main setup function
main() {
  print_header "HashiQube Setup - Starting Initialization"

  # Step 1: Install base tools
  run_command "bash hashiqube/basetools.sh" "Installing base tools" || return 1

  # Step 2: Install Docker daemon
  run_command "bash docker/docker.sh" "Setting up Docker daemon" || return 1

  # Step 3: Install and start Consul
  run_command "bash consul/consul.sh" "Setting up Consul" || return 1

  # Step 4: Install and start Nomad
  run_command "bash nomad/nomad.sh" "Setting up Nomad" || return 1

  # Step 5: Install and start Vault
  run_command "bash vault/vault.sh" "Setting up Vault" || return 1

  # Step 6: Install and start Boundary
  run_command "bash boundary/boundary.sh" "Setting up Boundary" || return 1

  # Step 7: Install and start Docsify for documentation
  run_command "bash docsify/docsify.sh" "Setting up documentation" || return 1

  # Step 8: Install and start Uptime Kuma for monitoring
  run_command "bash uptime-kuma/uptime-kuma.sh" "Setting up monitoring" || return 1

  print_header "HashiQube Setup - Initialization Complete"

  # Print access information
  echo -e "${MAGENTA}HashiQube has been successfully initialized!${NC}"
  echo -e "${MAGENTA}You can access the following services:${NC}"
  echo -e "${MAGENTA}- Documentation: http://localhost:3333${NC}"
  echo -e "${MAGENTA}- Status Dashboard: http://localhost:3001${NC}"
  echo -e "${MAGENTA}- Vault: http://localhost:8200${NC}"
  echo -e "${MAGENTA}- Consul: http://localhost:8500${NC}"
  echo -e "${MAGENTA}- Nomad: http://localhost:4646${NC}"
  echo -e "${MAGENTA}- Boundary: http://localhost:9200${NC}"
  echo ""
  echo -e "${MAGENTA}Default credentials:${NC}"
  echo -e "${MAGENTA}- Ubuntu user: ubuntu / vagrant${NC}"
  echo -e "${MAGENTA}- Vault token: Check /etc/vault/secure/init.file or use the temporary token displayed during setup${NC}"
  echo ""
  echo -e "${YELLOW}Note: Some services may take a few moments to fully initialize.${NC}"
}

# Run the main function
main
