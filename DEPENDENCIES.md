# HashiQube Component Dependencies

This document outlines the dependencies between different components in HashiQube. Understanding these dependencies will help you provision only the components you need and avoid compatibility issues.

## Core Components

These components form the foundation of HashiQube and are required by many other components:

| Component | Required By | Dependencies | Notes |
|-----------|-------------|--------------|-------|
| basetools | All components | None | Basic tools and utilities |
| docker | Most components | basetools | Container runtime |
| docsify | None | basetools | Documentation server |
| uptime-kuma | None | docker, basetools | Status monitoring |

## HashiCorp Stack

The core HashiCorp tools and their dependencies:

| Component | Required By | Dependencies | Notes |
|-----------|-------------|--------------|-------|
| vault | waypoint, boundary | basetools | Secrets management |
| consul | nomad | basetools | Service discovery |
| nomad | waypoint-nomad | basetools, consul | Workload orchestration |
| boundary | None | basetools, vault | Access management |
| terraform | None | basetools | Infrastructure as code |
| packer | None | basetools | Image building |
| sentinel | None | basetools | Policy as code |
| waypoint | None | basetools, vault, nomad or kubernetes | Application deployment |

## Database Components

Database services and their dependencies:

| Component | Required By | Dependencies | Notes |
|-----------|-------------|--------------|-------|
| mysql | None | basetools, docker | MySQL database |
| postgresql | None | basetools, docker | PostgreSQL database |
| mssql | None | basetools, docker | Microsoft SQL Server |

## CI/CD and DevOps Tools

Continuous integration, delivery, and DevOps components:

| Component | Required By | Dependencies | Notes |
|-----------|-------------|--------------|-------|
| jenkins | None | basetools, docker | CI/CD server |
| gitlab | None | basetools, docker | Git repository manager |
| ansible_local | None | basetools | Configuration management |
| ansible-tower | None | basetools, docker | Ansible management UI |
| vscode-server | None | basetools | Code editor |
| argocd | None | basetools, docker, minikube | GitOps for Kubernetes |

## Monitoring and Observability

Components for monitoring and observability:

| Component | Required By | Dependencies | Notes |
|-----------|-------------|--------------|-------|
| prometheus-grafana | None | basetools, docker | Metrics and dashboards |
| elasticsearch-kibana-cerebro | None | basetools, docker | Log management |
| trex | None | basetools, docker | Traffic generator |

## Container and Orchestration

Container management and orchestration tools:

| Component | Required By | Dependencies | Notes |
|-----------|-------------|--------------|-------|
| minikube | waypoint-kubernetes-minikube, argocd | basetools, docker | Local Kubernetes |
| portainer | None | basetools, docker | Container management UI |

## Other Components

Additional specialized components:

| Component | Required By | Dependencies | Notes |
|-----------|-------------|--------------|-------|
| ldap | None | basetools, docker | Directory service |
| localstack | None | basetools, docker | AWS service emulator |
| apache-airflow | None | basetools, docker | Workflow management |
| dbt | None | basetools | Data transformation |
| markdown-quiz-generator | None | basetools | Quiz generator |

## Dependency Graph

Below is a simplified dependency graph showing the relationships between key components:

```
basetools
├── docker
│   ├── uptime-kuma
│   ├── jenkins
│   ├── gitlab
│   ├── portainer
│   ├── prometheus-grafana
│   ├── elasticsearch-kibana-cerebro
│   ├── mysql/postgresql/mssql
│   ├── ldap
│   ├── localstack
│   ├── apache-airflow
│   └── minikube
│       ├── argocd
│       └── waypoint-kubernetes-minikube
├── docsify
├── vault
│   ├── boundary
│   └── waypoint
├── consul
│   └── nomad
│       └── waypoint-nomad
├── terraform
├── packer
├── sentinel
├── ansible_local
│   └── ansible-tower
├── vscode-server
└── dbt
```

## Provisioning Examples

Here are some common provisioning scenarios:

### Minimal HashiCorp Stack

```bash
vagrant up --provision-with basetools,docker,vault,consul,nomad
```

### Development Environment

```bash
vagrant up --provision-with basetools,docker,vault,consul,nomad,terraform,vscode-server,docsify
```

### CI/CD Pipeline

```bash
vagrant up --provision-with basetools,docker,vault,consul,jenkins,gitlab
```

### Database Development

```bash
vagrant up --provision-with basetools,docker,mysql,postgresql,vscode-server
```

### Kubernetes Development

```bash
vagrant up --provision-with basetools,docker,minikube,argocd,vault
```

### Monitoring Solution

```bash
vagrant up --provision-with basetools,docker,prometheus-grafana,elasticsearch-kibana-cerebro,uptime-kuma
```

## Resource Considerations

When provisioning multiple components, be mindful of resource usage. Here are some guidelines:

- **Low Resource Systems (4GB RAM)**: Limit to 3-4 core components
- **Medium Resource Systems (8GB RAM)**: Can run 5-7 components comfortably
- **High Resource Systems (16GB+ RAM)**: Can run most or all components

Components with high resource usage:
- GitLab
- Elasticsearch + Kibana
- Minikube
- MSSQL

## Troubleshooting Dependencies

If you encounter issues with component dependencies:

1. Check this document to ensure all required dependencies are provisioned
2. Run the health check script to verify component status:
   ```bash
   /vagrant/hashiqube/health_check.sh
   ```
3. Check component logs for specific errors:
   ```bash
   # For systemd services
   sudo journalctl -u [service-name]
   
   # For Docker containers
   docker logs [container-name]
   ```
4. Ensure your system has sufficient resources for all provisioned components
