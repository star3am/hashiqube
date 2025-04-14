#!/bin/bash
# Common error handling library for HashiQube installation scripts

# Set colors for output
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
MAGENTA='\e[38;5;198m'
NC='\e[0m' # No Color

# Log file for errors
ERROR_LOG="/var/log/hashiqube_install.log"

# Make sure the log file exists and is writable
touch "$ERROR_LOG" 2>/dev/null || true
chmod 644 "$ERROR_LOG" 2>/dev/null || true

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
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $message" >> "$ERROR_LOG"
}

# Function to handle errors
handle_error() {
  local exit_code=$1
  local error_message=$2
  local recovery_command=$3
  
  if [ $exit_code -ne 0 ]; then
    log "ERROR" "$error_message (Exit code: $exit_code)"
    
    if [ -n "$recovery_command" ]; then
      log "INFO" "Attempting recovery..."
      eval "$recovery_command"
      if [ $? -eq 0 ]; then
        log "INFO" "Recovery successful"
      else
        log "ERROR" "Recovery failed"
      fi
    fi
    
    return 1
  fi
  
  return 0
}

# Function to run a command with error handling
run_with_retry() {
  local command=$1
  local error_message=$2
  local recovery_command=$3
  local max_retries=${4:-3}
  local retry_delay=${5:-5}
  
  local retries=0
  local exit_code=0
  
  while [ $retries -lt $max_retries ]; do
    log "INFO" "Running command: $command"
    eval "$command"
    exit_code=$?
    
    if [ $exit_code -eq 0 ]; then
      log "INFO" "Command succeeded"
      return 0
    else
      retries=$((retries+1))
      log "WARNING" "$error_message (Exit code: $exit_code, Retry $retries/$max_retries)"
      
      if [ -n "$recovery_command" ]; then
        log "INFO" "Attempting recovery before retry..."
        eval "$recovery_command"
      fi
      
      if [ $retries -lt $max_retries ]; then
        log "INFO" "Waiting $retry_delay seconds before retry..."
        sleep $retry_delay
      fi
    fi
  done
  
  log "ERROR" "Command failed after $max_retries retries: $command"
  return 1
}

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to check if a service is running
service_is_running() {
  local service_name=$1
  
  if command_exists systemctl; then
    systemctl is-active --quiet "$service_name"
    return $?
  elif command_exists service; then
    service "$service_name" status >/dev/null 2>&1
    return $?
  else
    ps aux | grep -v grep | grep -q "$service_name"
    return $?
  fi
}

# Function to check if a port is in use
port_is_in_use() {
  local port=$1
  
  if command_exists netstat; then
    netstat -tuln | grep -q ":$port "
    return $?
  elif command_exists ss; then
    ss -tuln | grep -q ":$port "
    return $?
  elif command_exists lsof; then
    lsof -i ":$port" >/dev/null 2>&1
    return $?
  else
    # Fallback to a basic check using /dev/tcp
    (echo > /dev/tcp/127.0.0.1/$port) >/dev/null 2>&1
    return $?
  fi
}

# Function to wait for a service to be ready
wait_for_service() {
  local service_name=$1
  local check_command=$2
  local timeout=${3:-60}
  local interval=${4:-5}
  
  log "INFO" "Waiting for $service_name to be ready (timeout: ${timeout}s)..."
  
  local elapsed=0
  while [ $elapsed -lt $timeout ]; do
    if eval "$check_command" >/dev/null 2>&1; then
      log "INFO" "$service_name is ready"
      return 0
    fi
    
    sleep $interval
    elapsed=$((elapsed+interval))
    log "INFO" "Still waiting for $service_name... (${elapsed}s/${timeout}s)"
  done
  
  log "ERROR" "Timeout waiting for $service_name to be ready"
  return 1
}

# Function to create a backup before making changes
backup_before_change() {
  local file=$1
  local backup_dir=${2:-"/tmp/hashiqube_backups"}
  
  mkdir -p "$backup_dir"
  
  if [ -f "$file" ]; then
    local backup_file="${backup_dir}/$(basename "$file").$(date +%Y%m%d%H%M%S).bak"
    cp "$file" "$backup_file"
    log "INFO" "Created backup of $file at $backup_file"
    echo "$backup_file"
  else
    log "WARNING" "File $file does not exist, no backup created"
    echo ""
  fi
}

# Function to restore from backup
restore_from_backup() {
  local backup_file=$1
  local original_file=$2
  
  if [ -f "$backup_file" ]; then
    cp "$backup_file" "$original_file"
    log "INFO" "Restored $original_file from backup $backup_file"
    return 0
  else
    log "ERROR" "Backup file $backup_file does not exist, cannot restore"
    return 1
  fi
}

# If this script is sourced, just define the functions
# If it's executed directly, show usage
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo -e "${MAGENTA}HashiQube Error Handling Library${NC}"
  echo -e "${MAGENTA}This script is meant to be sourced by other scripts, not executed directly.${NC}"
  echo -e "${MAGENTA}Usage: source $(basename "$0")${NC}"
fi
