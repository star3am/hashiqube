# HashiQube Development Guide

## Command Reference
- Start all services: `vagrant up --provision`
- Start specific services: `vagrant up --provision-with basetools,docker,vault,consul,nomad`
- Docker compose: `docker-compose up -d`
- Check VM status: `vagrant status`
- Container status: `docker ps`
- Access documentation: http://localhost:3333

## Resource Requirements
- Docker Desktop: Allocate at least 8GB RAM
- Minimum 10GB disk space
- 4GB RAM minimum, 8GB+ recommended

## Code Style Guidelines
- Shell scripts: Use ANSI color codes for output formatting
- Infrastructure as Code: Follow HashiCorp HCL style conventions
- Modular design: Each service should have its own directory and README
- Documentation: Keep service documentation up-to-date in README files
- Error handling: Capture and display meaningful error messages
- Naming conventions: Use lowercase with hyphens for directories and files

## Testing
- Test individual components before integration
- Verify documentation accuracy when adding new features
- Test across multiple platforms (Linux, macOS, Windows) when possible