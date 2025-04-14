# HashiQube Platform-Specific Guide

This guide provides detailed instructions for running HashiQube on different platforms and troubleshooting common platform-specific issues.

## Apple Silicon (M1/M2) Macs

Apple Silicon Macs require special consideration as VirtualBox is not available for ARM architecture.

### Recommended Setup

1. **Use Docker Provider**:
   ```bash
   vagrant up --provision-with basetools --provider docker
   ```

2. **Memory Allocation**:
   Docker Desktop for Mac has memory limits. Ensure you've allocated enough memory in Docker Desktop preferences (at least 8GB recommended).

3. **Performance Tips**:
   - Use named volumes instead of tmpfs for better persistence
   - Limit the number of components you provision to conserve resources

### Known Issues

- Some components may not have ARM-compatible versions
- Nested virtualization (for Minikube) may have performance issues

## Windows

Windows has multiple options for running HashiQube, each with different considerations.

### Option 1: VirtualBox (Recommended)

1. **Install VirtualBox** from [virtualbox.org](https://www.virtualbox.org/)

2. **Run HashiQube with VirtualBox provider**:
   ```bash
   vagrant up --provider=virtualbox
   ```

3. **Troubleshooting**:
   - If you encounter "VT-x is not available" errors, enable virtualization in BIOS
   - For port conflicts, HashiQube now uses dynamic port allocation

### Option 2: Hyper-V (Windows Pro/Enterprise only)

1. **Enable Hyper-V** in Windows Features

2. **Run HashiQube with Hyper-V provider**:
   ```bash
   vagrant up --provider=hyperv
   ```

3. **Notes**:
   - Requires administrative privileges
   - May require network configuration for proper connectivity

### Option 3: WSL2 + Docker

This option has limitations and is not fully supported.

1. **Install WSL2 and Docker Desktop** with WSL2 backend

2. **Known Issues**:
   - Systemd in Docker containers under WSL2 has compatibility problems
   - Port forwarding can be complex between WSL2 and Windows host
   - File system performance may be degraded for shared folders

3. **Workaround**:
   - Exit WSL2 and run HashiQube directly from Windows command prompt using VirtualBox

## Linux

Linux provides the most flexible environment for running HashiQube.

### Recommended Setup

1. **Docker Provider** (fastest startup, lowest overhead):
   ```bash
   vagrant up --provider=docker
   ```

2. **VirtualBox Provider** (best compatibility):
   ```bash
   vagrant up --provider=virtualbox
   ```

3. **Podman Provider** (rootless containers):
   ```bash
   vagrant up --provider=podman
   ```

### Performance Optimization

- For systems with limited RAM, use adaptive resource allocation (now built-in)
- For faster provisioning, use SSD storage for VM images
- Consider using a dedicated partition for VM storage

## Troubleshooting Common Platform Issues

### Port Conflicts

HashiQube now implements dynamic port allocation, but you may still encounter conflicts:

1. **Check for port usage**:
   ```bash
   # On Windows
   netstat -ano | findstr "PORT_NUMBER"
   
   # On macOS/Linux
   lsof -i :PORT_NUMBER
   ```

2. **Manually specify alternative ports**:
   ```bash
   HASHIQUBE_VAULT_PORT=8201 vagrant up
   ```

### SSH Connection Issues

1. **Windows Path Too Long**:
   - Move HashiQube to a shorter path (e.g., C:\hashiqube)
   - Or enable long path support in Windows

2. **SSH Key Permissions**:
   - On Linux/macOS, ensure SSH keys have correct permissions (chmod 600)
   - On Windows, check that SSH agent is running

### Disk Space Issues

1. **Check available space**:
   ```bash
   # On Windows
   dir C:\Users\USERNAME\.vagrant.d
   
   # On macOS/Linux
   du -sh ~/.vagrant.d
   ```

2. **Clean up old boxes**:
   ```bash
   vagrant box prune
   ```

### Memory/CPU Issues

1. **Adjust resource allocation**:
   HashiQube now automatically detects and adapts to your system resources

2. **Provision only needed components**:
   ```bash
   vagrant up --provision-with basetools,docker,vault,consul,nomad
   ```

## Getting Help

If you encounter platform-specific issues not covered in this guide:

1. Check the [GitHub Issues](https://github.com/star3am/hashiqube/issues) for similar problems
2. Run the health check script to diagnose issues:
   ```bash
   /vagrant/hashiqube/health_check.sh
   ```
3. Create a new issue with detailed information about your environment
