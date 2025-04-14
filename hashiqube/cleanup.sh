#!/bin/bash
# Comprehensive cleanup script for HashiQube

# Set colors for output
MAGENTA='\e[38;5;198m'
GREEN='\e[32m'
RED='\e[31m'
YELLOW='\e[33m'
NC='\e[0m' # No Color

# Function to log messages
log() {
  local level=$1
  local message=$2
  local color=$MAGENTA
  
  case $level in
    "INFO") color=$GREEN ;;
    "ERROR") color=$RED ;;
    "WARNING") color=$YELLOW ;;
  esac
  
  echo -e "${color}[$level] $message${NC}"
}

# Function to confirm action
confirm() {
  local message=$1
  local default=${2:-n}
  
  local prompt
  if [ "$default" = "y" ]; then
    prompt="[Y/n]"
  else
    prompt="[y/N]"
  fi
  
  read -p "$message $prompt " response
  response=${response:-$default}
  
  if [[ $response =~ ^[Yy] ]]; then
    return 0
  else
    return 1
  fi
}

# Function to stop and remove Docker containers
cleanup_docker_containers() {
  log "INFO" "Cleaning up Docker containers..."
  
  # Get list of running containers
  local containers=$(docker ps -a --format "{{.Names}}" 2>/dev/null)
  
  if [ -z "$containers" ]; then
    log "INFO" "No Docker containers found"
    return 0
  fi
  
  log "INFO" "Found the following Docker containers:"
  docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Image}}" 2>/dev/null
  
  if confirm "Do you want to stop and remove all Docker containers?"; then
    log "INFO" "Stopping and removing all Docker containers..."
    docker stop $(docker ps -a -q) 2>/dev/null
    docker rm $(docker ps -a -q) 2>/dev/null
    log "INFO" "All Docker containers have been removed"
  else
    log "INFO" "Skipping Docker container cleanup"
  fi
}

# Function to clean up Docker volumes
cleanup_docker_volumes() {
  log "INFO" "Cleaning up Docker volumes..."
  
  # Get list of volumes
  local volumes=$(docker volume ls --format "{{.Name}}" 2>/dev/null)
  
  if [ -z "$volumes" ]; then
    log "INFO" "No Docker volumes found"
    return 0
  fi
  
  log "INFO" "Found the following Docker volumes:"
  docker volume ls --format "table {{.Name}}\t{{.Driver}}" 2>/dev/null
  
  if confirm "Do you want to remove all Docker volumes? This will DELETE ALL DATA stored in volumes!"; then
    log "WARNING" "Removing all Docker volumes..."
    docker volume rm $(docker volume ls -q) 2>/dev/null
    log "INFO" "All Docker volumes have been removed"
  else
    log "INFO" "Skipping Docker volume cleanup"
  fi
}

# Function to clean up Docker images
cleanup_docker_images() {
  log "INFO" "Cleaning up Docker images..."
  
  # Get list of images
  local images=$(docker images --format "{{.Repository}}:{{.Tag}}" 2>/dev/null)
  
  if [ -z "$images" ]; then
    log "INFO" "No Docker images found"
    return 0
  fi
  
  log "INFO" "Found the following Docker images:"
  docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" 2>/dev/null
  
  if confirm "Do you want to remove all Docker images?"; then
    log "INFO" "Removing all Docker images..."
    docker rmi $(docker images -q) --force 2>/dev/null
    log "INFO" "All Docker images have been removed"
  else
    log "INFO" "Skipping Docker image cleanup"
  fi
}

# Function to clean up Docker system
cleanup_docker_system() {
  log "INFO" "Cleaning up Docker system..."
  
  if confirm "Do you want to run Docker system prune?"; then
    log "INFO" "Running Docker system prune..."
    docker system prune -a -f --volumes 2>/dev/null
    log "INFO" "Docker system prune completed"
  else
    log "INFO" "Skipping Docker system prune"
  fi
}

# Function to stop HashiCorp services
stop_hashicorp_services() {
  log "INFO" "Stopping HashiCorp services..."
  
  local services=("vault" "consul" "nomad" "boundary")
  
  for service in "${services[@]}"; do
    if systemctl is-active --quiet $service 2>/dev/null; then
      log "INFO" "Stopping $service service..."
      systemctl stop $service 2>/dev/null
      log "INFO" "$service service stopped"
    else
      log "INFO" "$service service is not running"
    fi
  done
}

# Function to clean up HashiCorp data
cleanup_hashicorp_data() {
  log "INFO" "Cleaning up HashiCorp data..."
  
  local data_dirs=(
    "/var/lib/vault"
    "/var/lib/consul"
    "/var/lib/nomad"
    "/var/lib/boundary"
    "/etc/vault"
    "/etc/consul"
    "/etc/nomad"
    "/etc/boundary"
  )
  
  if confirm "Do you want to remove all HashiCorp data? This will DELETE ALL DATA!"; then
    log "WARNING" "Removing HashiCorp data directories..."
    
    for dir in "${data_dirs[@]}"; do
      if [ -d "$dir" ]; then
        log "INFO" "Removing $dir..."
        rm -rf "$dir" 2>/dev/null
        log "INFO" "$dir removed"
      else
        log "INFO" "$dir does not exist, skipping"
      fi
    done
    
    log "INFO" "All HashiCorp data has been removed"
  else
    log "INFO" "Skipping HashiCorp data cleanup"
  fi
}

# Function to clean up temporary files
cleanup_temp_files() {
  log "INFO" "Cleaning up temporary files..."
  
  local temp_dirs=(
    "/tmp/hashiqube*"
    "/tmp/vagrant*"
    "/tmp/terraform*"
    "/tmp/packer*"
    "/tmp/consul*"
    "/tmp/nomad*"
    "/tmp/vault*"
    "/tmp/boundary*"
  )
  
  if confirm "Do you want to remove temporary files?"; then
    log "INFO" "Removing temporary files..."
    
    for dir in "${temp_dirs[@]}"; do
      log "INFO" "Removing $dir..."
      rm -rf $dir 2>/dev/null
    done
    
    log "INFO" "Temporary files have been removed"
  else
    log "INFO" "Skipping temporary file cleanup"
  fi
}

# Function to clean up logs
cleanup_logs() {
  log "INFO" "Cleaning up log files..."
  
  local log_files=(
    "/var/log/hashiqube*"
    "/var/log/vault*"
    "/var/log/consul*"
    "/var/log/nomad*"
    "/var/log/boundary*"
  )
  
  if confirm "Do you want to remove log files?"; then
    log "INFO" "Removing log files..."
    
    for file in "${log_files[@]}"; do
      log "INFO" "Removing $file..."
      rm -f $file 2>/dev/null
    done
    
    log "INFO" "Log files have been removed"
  else
    log "INFO" "Skipping log file cleanup"
  fi
}

# Function to clean up network configurations
cleanup_network() {
  log "INFO" "Cleaning up network configurations..."
  
  # Check for any HashiQube-related iptables rules
  local iptables_rules=$(iptables -S | grep -i "hashiqube\|vagrant\|vbox" 2>/dev/null)
  
  if [ -n "$iptables_rules" ]; then
    log "INFO" "Found HashiQube-related iptables rules"
    
    if confirm "Do you want to remove HashiQube-related iptables rules?"; then
      log "INFO" "Removing iptables rules..."
      
      # This is a simplified approach - in a real script, you'd need more careful handling
      iptables -S | grep -i "hashiqube\|vagrant\|vbox" | sed 's/^-A/iptables -D/' | bash 2>/dev/null
      
      log "INFO" "Iptables rules have been removed"
    else
      log "INFO" "Skipping iptables rule cleanup"
    fi
  else
    log "INFO" "No HashiQube-related iptables rules found"
  fi
}

# Main cleanup function
main() {
  echo -e "${MAGENTA}HashiQube Cleanup Utility${NC}"
  echo -e "${MAGENTA}=========================${NC}"
  echo ""
  
  log "WARNING" "This utility will help you clean up HashiQube resources"
  log "WARNING" "Some operations will DELETE DATA PERMANENTLY"
  echo ""
  
  if ! confirm "Do you want to proceed with cleanup?"; then
    log "INFO" "Cleanup cancelled"
    exit 0
  fi
  
  echo ""
  
  # Determine what to clean up
  local cleanup_all=false
  local cleanup_docker=false
  local cleanup_hashicorp=false
  local cleanup_temp=false
  local cleanup_network=false
  
  if confirm "Do you want to clean up everything?"; then
    cleanup_all=true
  else
    if confirm "Do you want to clean up Docker resources?"; then
      cleanup_docker=true
    fi
    
    if confirm "Do you want to clean up HashiCorp services and data?"; then
      cleanup_hashicorp=true
    fi
    
    if confirm "Do you want to clean up temporary files and logs?"; then
      cleanup_temp=true
    fi
    
    if confirm "Do you want to clean up network configurations?"; then
      cleanup_network=true
    fi
  fi
  
  echo ""
  
  # Perform cleanup based on selections
  if [ "$cleanup_all" = true ] || [ "$cleanup_docker" = true ]; then
    cleanup_docker_containers
    cleanup_docker_volumes
    cleanup_docker_images
    cleanup_docker_system
  fi
  
  if [ "$cleanup_all" = true ] || [ "$cleanup_hashicorp" = true ]; then
    stop_hashicorp_services
    cleanup_hashicorp_data
  fi
  
  if [ "$cleanup_all" = true ] || [ "$cleanup_temp" = true ]; then
    cleanup_temp_files
    cleanup_logs
  fi
  
  if [ "$cleanup_all" = true ] || [ "$cleanup_network" = true ]; then
    cleanup_network
  fi
  
  echo ""
  log "INFO" "Cleanup completed"
  
  if confirm "Do you want to reboot the system to ensure all changes take effect?"; then
    log "INFO" "Rebooting system..."
    reboot
  else
    log "INFO" "Skipping reboot"
  fi
}

# Run the main function
main
