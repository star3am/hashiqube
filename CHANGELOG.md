# Changelog

## [Unreleased] - Major Improvements and Bug Fixes

This update addresses all issues identified in the HASHIQUBE_ISSUES.md document, significantly improving security, error handling, data persistence, resource management, architecture compatibility, and documentation.

### Security Improvements

- **Credential Management**
  - Replaced hardcoded credentials in docker/docker.sh with environment variables and secure defaults
  - Improved Vault root token security by:
    - Storing credentials in a secure location (/etc/vault/secure) with restricted permissions
    - Creating temporary tokens with limited TTL and specific policies instead of using the root token
    - Limiting exposure of sensitive information in logs and terminal output
  - Removed default credentials from welcome messages, replacing with instructions to set up credentials at first login
  - Updated Dockerfile to generate unique SSH keys instead of using standard Vagrant public keys

### Error Handling and Resilience

- **Container Management**
  - Added container existence checks in docker/docker.sh and uptime-kuma/uptime-kuma.sh to prevent errors when stopping non-existent containers
  - Improved error messages with more context and troubleshooting guidance

- **Common Error Handling Library**
  - Created hashiqube/error_handling.sh with standardized functions for:
    - Consistent error logging and formatting
    - Retry mechanisms with exponential backoff
    - Recovery procedures for common failure scenarios
    - Service and port availability checking
    - Backup and restore functionality for critical operations

- **Health Monitoring**
  - Added hashiqube/health_check.sh to verify service status and diagnose issues
  - Implemented comprehensive checks for all critical services
  - Added color-coded output for easy identification of issues

### Data Persistence

- **Docker Volumes**
  - Replaced tmpfs mounts with named volumes in docker-compose.yml for persistent data storage
  - Added volume definitions with appropriate drivers
  - Ensured data survives container restarts and rebuilds

- **Backup System**
  - Created hashiqube/backup.sh for backing up critical data
  - Implemented backup for Vault, Consul, Nomad, and other service data
  - Added backup rotation and compression

### Resource Management

- **Dynamic Port Allocation**
  - Implemented dynamic port allocation with fallbacks in Vagrantfile to prevent port conflicts
  - Added port availability detection and automatic alternative port selection
  - Updated welcome message to display actual ports being used
  - Set environment variables for component-specific ports

- **Adaptive Resource Allocation**
  - Added system resource detection for memory and CPU
  - Implemented adaptive resource allocation for VirtualBox and Hyper-V providers
  - Set reasonable minimum and maximum resource limits
  - Added safeguards to prevent excessive resource allocation

### Architecture and Platform Compatibility

- **Architecture Detection**
  - Improved architecture detection in vault/vault.sh with multiple detection methods
  - Created hashiqube/detect_arch.sh as a common architecture detection script
  - Added support for x86_64, ARM64, ARM32, and i386 architectures
  - Implemented fallbacks for unknown architectures

- **Platform-Specific Guidance**
  - Created PLATFORM_GUIDE.md with detailed instructions for different platforms
  - Added workarounds for Windows/WSL2 Docker provider limitations
  - Improved documentation for Apple Silicon Macs
  - Added platform-specific troubleshooting guidance

### Configuration Management

- **Centralized Configuration**
  - Created hashiqube/config.sh as a central configuration system
  - Implemented environment detection and auto-configuration
  - Added secure storage of sensitive configuration values
  - Created configuration export and import functionality

- **Version Management**
  - Created hashiqube/versions.sh for centralized version control
  - Added automatic latest version detection for HashiCorp products
  - Implemented version override capability through environment variables
  - Added version compatibility checking

### Cleanup and Maintenance

- **Resource Cleanup**
  - Created hashiqube/cleanup.sh for comprehensive resource cleanup
  - Implemented safe cleanup procedures with confirmation prompts
  - Added selective cleanup options for different resource types
  - Ensured cleanup script is idempotent and safe to run multiple times

### Documentation

- **Compatibility Documentation**
  - Created COMPATIBILITY.md with detailed platform and component compatibility information
  - Added system requirements for different deployment scenarios
  - Documented known limitations and workarounds

- **Dependency Documentation**
  - Created DEPENDENCIES.md outlining dependencies between components
  - Added provisioning examples for common scenarios
  - Documented resource requirements for different component combinations

- **README Updates**
  - Updated README.md to reference new documentation and tools
  - Improved Table of Contents with links to new sections
  - Added information about utility tools

### Code Organization

- **Common Libraries**
  - Created reusable libraries for common functions
  - Improved code sharing between components
  - Reduced duplication and inconsistencies

- **Standardized Structure**
  - Implemented consistent error handling across scripts
  - Standardized logging and output formatting
  - Added proper exit code handling

### User Experience Improvements

- **Streamlined Setup Process**
  - Created a one-command setup script (setup.sh) that initializes all services
  - Simplified Docker Compose setup instructions
  - Added clear output with progress indicators during setup
  - Improved error handling and recovery during setup

## How to Use the New Features

### Streamlined Setup

- **Docker Compose Setup**:
  ```bash
  # Start the container
  docker compose up -d

  # Run the one-command setup script
  docker compose exec hashiqube /vagrant/setup.sh
  ```

### Utility Tools

- **Health Check**: Run `/vagrant/hashiqube/health_check.sh` to verify service status
- **Backup Tool**: Run `/vagrant/hashiqube/backup.sh` to backup critical data
- **Cleanup Tool**: Run `/vagrant/hashiqube/cleanup.sh` to clean up resources
- **Configuration**: Run `/vagrant/hashiqube/config.sh` to view and manage configuration

### Documentation Resources

- **Compatibility Matrix**: See [COMPATIBILITY.md](COMPATIBILITY.md) for detailed information about platform and component compatibility
- **Platform-Specific Guide**: See [PLATFORM_GUIDE.md](PLATFORM_GUIDE.md) for detailed instructions for different platforms
- **Component Dependencies**: See [DEPENDENCIES.md](DEPENDENCIES.md) for information about dependencies between components
