#!/bin/bash
# Common architecture detection script for HashiQube components

# Improved architecture detection that works across different systems
detect_architecture() {
  # Try multiple methods to detect architecture
  local detected_arch=""
  
  # Method 1: Using lscpu (common on Linux)
  if command -v lscpu >/dev/null 2>&1; then
    detected_arch=$(lscpu | grep "Architecture" | awk '{print $NF}')
  fi
  
  # Method 2: Using uname (works on Linux, macOS, and some Unix systems)
  if [ -z "$detected_arch" ] && command -v uname >/dev/null 2>&1; then
    detected_arch=$(uname -m)
  fi
  
  # Method 3: Using arch command (some Unix systems)
  if [ -z "$detected_arch" ] && command -v arch >/dev/null 2>&1; then
    detected_arch=$(arch)
  fi
  
  # If we still don't have an architecture, default to x86_64
  if [ -z "$detected_arch" ]; then
    echo "Warning: Could not detect CPU architecture, defaulting to x86_64" >&2
    detected_arch="x86_64"
  fi
  
  # Map architecture to Hashicorp's naming convention
  case "$detected_arch" in
    x86_64*|amd64)
      echo "amd64"
      ;;
    aarch64*|arm64|armv8*)
      echo "arm64"
      ;;
    armv7*|armhf)
      echo "arm"
      ;;
    i386|i686|x86)
      echo "386"
      ;;
    *)
      echo "Warning: Unknown architecture '$detected_arch', defaulting to amd64" >&2
      echo "amd64"
      ;;
  esac
}

# If this script is sourced, just define the function
# If it's executed directly, output the architecture
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  ARCH=$(detect_architecture)
  echo "$ARCH"
fi
