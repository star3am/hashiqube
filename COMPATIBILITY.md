# HashiQube Compatibility Matrix

This document provides detailed information about HashiQube's compatibility with different operating systems, architectures, and virtualization providers.

## Operating System Compatibility

| Host OS | VirtualBox | Docker | Hyper-V | Podman | Notes |
|---------|------------|--------|---------|--------|-------|
| Ubuntu 20.04+ | ✅ Full | ✅ Full | ❌ N/A | ✅ Full | Recommended for best experience |
| Debian 10+ | ✅ Full | ✅ Full | ❌ N/A | ✅ Full | |
| Fedora | ✅ Full | ✅ Full | ❌ N/A | ✅ Full | |
| CentOS/RHEL 8+ | ✅ Full | ✅ Full | ❌ N/A | ✅ Full | |
| macOS (Intel) | ✅ Full | ✅ Full | ❌ N/A | ✅ Full | |
| macOS (Apple Silicon) | ❌ No | ✅ Full | ❌ N/A | ✅ Full | Use Docker provider only |
| Windows 10/11 | ✅ Full | ⚠️ Limited | ✅ Full | ❌ No | Docker provider doesn't work well on Windows |
| Windows + WSL2 | ✅ Full | ⚠️ Limited | ❌ N/A | ✅ Full | Docker provider has limitations in WSL2 |

## Architecture Compatibility

| Architecture | Support Level | Notes |
|--------------|--------------|-------|
| x86_64 (AMD64) | ✅ Full | Primary development platform |
| ARM64 (Apple Silicon) | ✅ Full | Use Docker provider only |
| ARM32 | ⚠️ Limited | Some components may not work |
| i386 | ❌ No | Not supported |

## Provider-Specific Limitations

### VirtualBox Provider

- **Pros**: Works on most platforms, good performance, mature
- **Cons**: Not available for Apple Silicon Macs, requires kernel modules
- **Requirements**: 
  - At least 4GB RAM (10GB recommended)
  - 20GB free disk space
  - VT-x/AMD-V virtualization support enabled in BIOS

### Docker Provider

- **Pros**: Lightweight, works on Apple Silicon Macs
- **Cons**: Limited functionality on Windows, some systemd services may not work properly
- **Requirements**:
  - Docker Desktop installed and running
  - At least 4GB RAM allocated to Docker
  - 10GB free disk space

### Hyper-V Provider

- **Pros**: Native Windows virtualization, good performance
- **Cons**: Windows-only, requires Windows Pro/Enterprise
- **Requirements**:
  - Windows 10/11 Pro or Enterprise
  - Hyper-V feature enabled
  - At least 4GB RAM (10GB recommended)
  - 20GB free disk space

### Podman Provider

- **Pros**: Daemonless alternative to Docker, rootless containers
- **Cons**: Less tested, may have compatibility issues with some components
- **Requirements**:
  - Podman installed and configured
  - At least 4GB RAM
  - 10GB free disk space

## Component Compatibility Matrix

| Component | VirtualBox | Docker | Hyper-V | Podman | Notes |
|-----------|------------|--------|---------|--------|-------|
| Vault | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| Consul | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| Nomad | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| Docker Registry | ✅ Full | ✅ Full | ✅ Full | ⚠️ Limited | |
| Kubernetes/Minikube | ✅ Full | ⚠️ Limited | ✅ Full | ⚠️ Limited | Nested virtualization issues with Docker |
| Waypoint | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| Boundary | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| Terraform | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| Packer | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| Sentinel | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| Uptime Kuma | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| Docsify | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| LDAP | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| MySQL | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| PostgreSQL | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| MSSQL | ✅ Full | ✅ Full | ✅ Full | ⚠️ Limited | |
| Jenkins | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| Apache Airflow | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| Ansible Tower | ✅ Full | ✅ Full | ✅ Full | ⚠️ Limited | |
| Prometheus/Grafana | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| ELK Stack | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| Portainer | ✅ Full | ✅ Full | ✅ Full | ⚠️ Limited | |
| GitLab | ✅ Full | ✅ Full | ✅ Full | ⚠️ Limited | High resource usage |
| VS Code Server | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| DBT | ✅ Full | ✅ Full | ✅ Full | ✅ Full | |
| ArgoCD | ✅ Full | ⚠️ Limited | ✅ Full | ⚠️ Limited | Requires Kubernetes |

## Resource Requirements

### Minimum Requirements

- **CPU**: 2 cores
- **RAM**: 4GB
- **Disk**: 20GB free space
- **Network**: Internet connection for downloading components

### Recommended Requirements

- **CPU**: 4+ cores
- **RAM**: 8GB+ (16GB for running multiple components)
- **Disk**: 50GB+ free space
- **Network**: Broadband internet connection

### Component-Specific Requirements

| Component | CPU | RAM | Disk | Notes |
|-----------|-----|-----|------|-------|
| Base System | 1 core | 2GB | 10GB | |
| Vault + Consul + Nomad | 2 cores | 4GB | 5GB | Core HashiCorp stack |
| Kubernetes/Minikube | 2 cores | 4GB | 10GB | |
| ELK Stack | 2 cores | 4GB | 10GB | |
| GitLab | 2 cores | 4GB | 10GB | Resource intensive |
| Jenkins | 1 core | 2GB | 5GB | |
| Multiple Components | 4+ cores | 8GB+ | 30GB+ | When running several components together |

## Workarounds for Known Issues

### Docker Provider on Windows

The Docker provider has limitations on Windows due to how Docker Desktop implements virtualization. Consider these alternatives:

1. Use VirtualBox provider instead
2. Use Hyper-V provider if you have Windows Pro/Enterprise
3. Use WSL2 with VirtualBox provider

### Apple Silicon Macs

VirtualBox is not available for Apple Silicon Macs. Use the Docker provider instead:

```bash
vagrant up --provider=docker
```

### Port Conflicts

If you encounter port conflicts, HashiQube now implements dynamic port allocation. The actual ports used will be displayed in the welcome message after provisioning.

### Resource Limitations

If your system has limited resources:

1. Provision only the components you need:
   ```bash
   vagrant up --provision-with basetools,docker,vault,consul,nomad
   ```

2. Adjust the memory allocation in the Vagrantfile (now done automatically with adaptive resource allocation)

## Getting Help

If you encounter compatibility issues not covered in this document:

1. Check the [GitHub Issues](https://github.com/star3am/hashiqube/issues) for similar problems
2. Join the [HashiCorp Discussion Forum](https://discuss.hashicorp.com/)
3. Create a new issue with detailed information about your environment
