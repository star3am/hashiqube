#!/bin/bash
# Health check script for HashiQube services

# Set colors for output
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
MAGENTA='\e[38;5;198m'
NC='\e[0m' # No Color

# Function to check if a service is running
check_service() {
  local service_name=$1
  local check_command=$2
  local expected_output=$3
  
  echo -e "${MAGENTA}Checking $service_name...${NC}"
  
  # Run the check command
  local result
  result=$(eval "$check_command" 2>/dev/null)
  local exit_code=$?
  
  if [ $exit_code -eq 0 ]; then
    if [ -z "$expected_output" ] || echo "$result" | grep -q "$expected_output"; then
      echo -e "${GREEN}✓ $service_name is running correctly${NC}"
      return 0
    else
      echo -e "${YELLOW}⚠ $service_name is running but may not be functioning correctly${NC}"
      echo -e "${YELLOW}  Expected: $expected_output${NC}"
      echo -e "${YELLOW}  Got: $result${NC}"
      return 2
    fi
  else
    echo -e "${RED}✗ $service_name is not running${NC}"
    return 1
  fi
}

# Function to check if a port is open
check_port() {
  local service_name=$1
  local host=$2
  local port=$3
  
  echo -e "${MAGENTA}Checking $service_name on $host:$port...${NC}"
  
  # Check if the port is open
  if nc -z -w 5 "$host" "$port" >/dev/null 2>&1; then
    echo -e "${GREEN}✓ $service_name port $port is open${NC}"
    return 0
  else
    echo -e "${RED}✗ $service_name port $port is not accessible${NC}"
    return 1
  fi
}

# Function to check HTTP endpoint
check_http() {
  local service_name=$1
  local url=$2
  local expected_status=${3:-200}
  local expected_content=$4
  
  echo -e "${MAGENTA}Checking $service_name HTTP endpoint $url...${NC}"
  
  # Check if curl is installed
  if ! command -v curl >/dev/null 2>&1; then
    echo -e "${RED}✗ curl is not installed, cannot check HTTP endpoints${NC}"
    return 1
  fi
  
  # Check the HTTP endpoint
  local response
  local status_code
  
  response=$(curl -s -o /dev/null -w "%{http_code}" "$url" 2>/dev/null)
  status_code=$?
  
  if [ $status_code -eq 0 ]; then
    if [ "$response" -eq "$expected_status" ]; then
      if [ -z "$expected_content" ]; then
        echo -e "${GREEN}✓ $service_name HTTP endpoint is accessible (status $response)${NC}"
        return 0
      else
        local content
        content=$(curl -s "$url" 2>/dev/null)
        if echo "$content" | grep -q "$expected_content"; then
          echo -e "${GREEN}✓ $service_name HTTP endpoint is accessible and contains expected content${NC}"
          return 0
        else
          echo -e "${YELLOW}⚠ $service_name HTTP endpoint is accessible but does not contain expected content${NC}"
          return 2
        fi
      fi
    else
      echo -e "${YELLOW}⚠ $service_name HTTP endpoint returned unexpected status code: $response (expected $expected_status)${NC}"
      return 2
    fi
  else
    echo -e "${RED}✗ $service_name HTTP endpoint is not accessible${NC}"
    return 1
  fi
}

# Main health check function
run_health_checks() {
  echo -e "${MAGENTA}==== HashiQube Health Check ====${NC}"
  echo -e "${MAGENTA}Running health checks for critical services...${NC}"
  echo ""
  
  local failed=0
  local warnings=0
  
  # Check Vault
  if systemctl is-active --quiet vault; then
    check_port "Vault" "127.0.0.1" "8200"
    [ $? -ne 0 ] && failed=$((failed+1))
    
    if [ -n "$VAULT_ADDR" ] && [ -n "$VAULT_TOKEN" ]; then
      check_service "Vault API" "vault status" "Initialized"
      local result=$?
      [ $result -eq 1 ] && failed=$((failed+1))
      [ $result -eq 2 ] && warnings=$((warnings+1))
    else
      echo -e "${YELLOW}⚠ Vault environment variables not set, skipping API check${NC}"
      warnings=$((warnings+1))
    fi
  else
    echo -e "${RED}✗ Vault service is not running${NC}"
    failed=$((failed+1))
  fi
  
  echo ""
  
  # Check Consul
  if systemctl is-active --quiet consul; then
    check_port "Consul" "127.0.0.1" "8500"
    [ $? -ne 0 ] && failed=$((failed+1))
    
    check_http "Consul" "http://127.0.0.1:8500/v1/status/leader"
    local result=$?
    [ $result -eq 1 ] && failed=$((failed+1))
    [ $result -eq 2 ] && warnings=$((warnings+1))
  else
    echo -e "${RED}✗ Consul service is not running${NC}"
    failed=$((failed+1))
  fi
  
  echo ""
  
  # Check Nomad
  if systemctl is-active --quiet nomad; then
    check_port "Nomad" "127.0.0.1" "4646"
    [ $? -ne 0 ] && failed=$((failed+1))
    
    check_http "Nomad" "http://127.0.0.1:4646/v1/status/leader"
    local result=$?
    [ $result -eq 1 ] && failed=$((failed+1))
    [ $result -eq 2 ] && warnings=$((warnings+1))
  else
    echo -e "${RED}✗ Nomad service is not running${NC}"
    failed=$((failed+1))
  fi
  
  echo ""
  
  # Check Docker
  if command -v docker >/dev/null 2>&1; then
    check_service "Docker" "docker info" "Server Version"
    local result=$?
    [ $result -eq 1 ] && failed=$((failed+1))
    [ $result -eq 2 ] && warnings=$((warnings+1))
  else
    echo -e "${RED}✗ Docker is not installed${NC}"
    failed=$((failed+1))
  fi
  
  echo ""
  
  # Check Docker Registry if running
  if docker ps | grep -q registry; then
    check_port "Docker Registry" "127.0.0.1" "5002"
    [ $? -ne 0 ] && failed=$((failed+1))
  else
    echo -e "${YELLOW}⚠ Docker Registry container is not running, skipping check${NC}"
    warnings=$((warnings+1))
  fi
  
  echo ""
  
  # Check Uptime Kuma if running
  if docker ps | grep -q uptime-kuma; then
    check_port "Uptime Kuma" "127.0.0.1" "3001"
    [ $? -ne 0 ] && failed=$((failed+1))
  else
    echo -e "${YELLOW}⚠ Uptime Kuma container is not running, skipping check${NC}"
    warnings=$((warnings+1))
  fi
  
  echo ""
  
  # Summary
  echo -e "${MAGENTA}==== Health Check Summary ====${NC}"
  if [ $failed -eq 0 ] && [ $warnings -eq 0 ]; then
    echo -e "${GREEN}All services are running correctly!${NC}"
  elif [ $failed -eq 0 ]; then
    echo -e "${YELLOW}All critical services are running, but there are $warnings warning(s)${NC}"
  else
    echo -e "${RED}$failed service(s) failed health checks${NC}"
    if [ $warnings -gt 0 ]; then
      echo -e "${YELLOW}$warnings service(s) have warnings${NC}"
    fi
  fi
}

# Run the health checks
run_health_checks
