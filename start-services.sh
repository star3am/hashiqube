#!/bin/bash
# Script to start Docsify and Uptime Kuma services

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

# Main function
main() {
  print_header "Starting HashiQube Services"

  # Start Docsify for documentation
  run_command "cd /vagrant && bash docsify/docsify.sh" "Setting up documentation" || return 1

  # Start Uptime Kuma for monitoring
  run_command "cd /vagrant && bash uptime-kuma/uptime-kuma.sh" "Setting up monitoring" || return 1

  print_header "HashiQube Services Started"

  # Print access information
  echo -e "${MAGENTA}You can access the following services:${NC}"
  echo -e "${MAGENTA}- Documentation: http://localhost:3333${NC}"
  echo -e "${MAGENTA}- Status Dashboard: http://localhost:3001${NC}"
  echo ""
}

# Run the main function
main
