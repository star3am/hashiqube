#!/bin/bash
# Backup script for HashiQube critical data

# Set colors for output
MAGENTA='\e[38;5;198m'
GREEN='\e[32m'
RED='\e[31m'
YELLOW='\e[33m'
NC='\e[0m' # No Color

# Default backup directory
BACKUP_DIR="/vagrant/backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="${BACKUP_DIR}/hashiqube_backup_${TIMESTAMP}.tar.gz"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

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

# Function to backup a directory
backup_directory() {
  local dir=$1
  local name=$2
  
  if [ -d "$dir" ]; then
    log "INFO" "Backing up $name from $dir"
    tar -czf "${BACKUP_DIR}/${name}_${TIMESTAMP}.tar.gz" -C "$(dirname "$dir")" "$(basename "$dir")" 2>/dev/null
    if [ $? -eq 0 ]; then
      log "INFO" "Successfully backed up $name"
    else
      log "ERROR" "Failed to backup $name"
    fi
  else
    log "WARNING" "Directory $dir for $name does not exist, skipping"
  fi
}

# Function to backup Docker volumes
backup_docker_volume() {
  local volume=$1
  local name=$2
  
  if docker volume inspect "$volume" >/dev/null 2>&1; then
    log "INFO" "Backing up Docker volume $volume"
    
    # Create a temporary container to access the volume
    docker run --rm -v "${volume}:/data" -v "${BACKUP_DIR}:/backup" \
      ubuntu tar -czf "/backup/${name}_${TIMESTAMP}.tar.gz" -C /data . 2>/dev/null
    
    if [ $? -eq 0 ]; then
      log "INFO" "Successfully backed up Docker volume $volume"
    else
      log "ERROR" "Failed to backup Docker volume $volume"
    fi
  else
    log "WARNING" "Docker volume $volume does not exist, skipping"
  fi
}

# Function to backup a file
backup_file() {
  local file=$1
  local name=$2
  
  if [ -f "$file" ]; then
    log "INFO" "Backing up $name from $file"
    cp "$file" "${BACKUP_DIR}/${name}_${TIMESTAMP}.backup"
    if [ $? -eq 0 ]; then
      log "INFO" "Successfully backed up $name"
    else
      log "ERROR" "Failed to backup $name"
    fi
  else
    log "WARNING" "File $file for $name does not exist, skipping"
  fi
}

# Main backup function
run_backup() {
  log "INFO" "Starting HashiQube backup to $BACKUP_DIR"
  
  # Backup Vault data
  backup_directory "/etc/vault" "vault_config"
  backup_directory "/var/lib/vault" "vault_data"
  backup_file "/etc/vault/secure/init.file" "vault_credentials"
  
  # Backup Consul data
  backup_directory "/etc/consul" "consul_config"
  backup_directory "/var/lib/consul" "consul_data"
  
  # Backup Nomad data
  backup_directory "/etc/nomad" "nomad_config"
  backup_directory "/var/lib/nomad" "nomad_data"
  
  # Backup Docker volumes
  if command -v docker >/dev/null 2>&1; then
    # Get list of hashiqube-related volumes
    for volume in $(docker volume ls --format "{{.Name}}" | grep -E 'hashiqube|docker_data|rancher_data|run_data'); do
      backup_docker_volume "$volume" "docker_volume_${volume}"
    done
  else
    log "WARNING" "Docker not installed, skipping Docker volume backups"
  fi
  
  # Backup environment variables
  backup_file "/etc/environment" "environment_vars"
  
  # Create a single archive with all backups
  log "INFO" "Creating consolidated backup archive"
  tar -czf "$BACKUP_FILE" -C "$BACKUP_DIR" --exclude="*.tar.gz" . 2>/dev/null
  
  if [ $? -eq 0 ]; then
    log "INFO" "Successfully created consolidated backup at $BACKUP_FILE"
    # Clean up individual backup files
    find "$BACKUP_DIR" -maxdepth 1 -type f -name "*_${TIMESTAMP}.*" -not -name "hashiqube_backup_*.tar.gz" -delete
  else
    log "ERROR" "Failed to create consolidated backup"
  fi
  
  log "INFO" "Backup completed"
}

# Run the backup
run_backup
