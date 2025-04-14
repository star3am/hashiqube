#!/bin/bash
# Central version management for HashiQube components

# Set colors for output
MAGENTA='\e[38;5;198m'
NC='\e[0m' # No Color

# Function to get the latest version of a HashiCorp product
get_latest_hashicorp_version() {
  local product=$1
  local exclude_pattern=${2:-"rc|beta|alpha"}
  
  curl -s https://releases.hashicorp.com/${product}/index.json | \
    jq -r '.versions | keys[] | select(test("'"${exclude_pattern}"'") | not)' | \
    sort -V | \
    tail -n 1
}

# Function to get a specific version or latest if not specified
get_version() {
  local component=$1
  local specified_version=$2
  local default_version=$3
  
  if [ -n "$specified_version" ] && [ "$specified_version" != "latest" ]; then
    echo "$specified_version"
  elif [ "$specified_version" = "latest" ]; then
    case "$component" in
      vault|consul|nomad|terraform|packer|boundary|waypoint)
        get_latest_hashicorp_version "$component"
        ;;
      *)
        echo "$default_version"
        ;;
    esac
  else
    echo "$default_version"
  fi
}

# HashiCorp product versions
# Override by setting environment variables like VAULT_VERSION=1.8.0
VAULT_VERSION=$(get_version "vault" "${VAULT_VERSION:-latest}" "1.15.2")
CONSUL_VERSION=$(get_version "consul" "${CONSUL_VERSION:-latest}" "1.16.2")
NOMAD_VERSION=$(get_version "nomad" "${NOMAD_VERSION:-latest}" "1.6.3")
TERRAFORM_VERSION=$(get_version "terraform" "${TERRAFORM_VERSION:-latest}" "1.5.7")
PACKER_VERSION=$(get_version "packer" "${PACKER_VERSION:-latest}" "1.9.4")
BOUNDARY_VERSION=$(get_version "boundary" "${BOUNDARY_VERSION:-latest}" "0.14.0")
WAYPOINT_VERSION=$(get_version "waypoint" "${WAYPOINT_VERSION:-latest}" "0.11.4")
SENTINEL_VERSION="${SENTINEL_VERSION:-0.22.1}"

# Database versions
MYSQL_VERSION="${MYSQL_VERSION:-8.0}"
POSTGRESQL_VERSION="${POSTGRESQL_VERSION:-15}"
MSSQL_VERSION="${MSSQL_VERSION:-2022-latest}"

# Container and orchestration versions
DOCKER_VERSION="${DOCKER_VERSION:-24.0.5}"
DOCKER_COMPOSE_VERSION="${DOCKER_COMPOSE_VERSION:-2.20.3}"
MINIKUBE_VERSION="${MINIKUBE_VERSION:-v1.31.2}"
KUBECTL_VERSION="${KUBECTL_VERSION:-v1.28.2}"
HELM_VERSION="${HELM_VERSION:-v3.13.0}"
ARGOCD_VERSION="${ARGOCD_VERSION:-v2.8.0}"

# Monitoring and observability versions
PROMETHEUS_VERSION="${PROMETHEUS_VERSION:-v2.46.0}"
GRAFANA_VERSION="${GRAFANA_VERSION:-10.1.2}"
ELASTICSEARCH_VERSION="${ELASTICSEARCH_VERSION:-8.10.2}"
KIBANA_VERSION="${KIBANA_VERSION:-8.10.2}"
UPTIME_KUMA_VERSION="${UPTIME_KUMA_VERSION:-1.23.2}"

# CI/CD and DevOps tool versions
JENKINS_VERSION="${JENKINS_VERSION:-lts-jdk17}"
GITLAB_VERSION="${GITLAB_VERSION:-16.4.1-ce.0}"
ANSIBLE_VERSION="${ANSIBLE_VERSION:-8.5.0}"
ANSIBLE_TOWER_VERSION="${ANSIBLE_TOWER_VERSION:-latest}"
VSCODE_SERVER_VERSION="${VSCODE_SERVER_VERSION:-latest}"

# Other component versions
DOCSIFY_VERSION="${DOCSIFY_VERSION:-4.13.0}"
LDAP_VERSION="${LDAP_VERSION:-2.6.3}"
LOCALSTACK_VERSION="${LOCALSTACK_VERSION:-2.3.0}"
APACHE_AIRFLOW_VERSION="${APACHE_AIRFLOW_VERSION:-2.7.1}"
DBT_VERSION="${DBT_VERSION:-1.6.1}"

# Export all versions as environment variables
export_versions() {
  # HashiCorp products
  export VAULT_VERSION
  export CONSUL_VERSION
  export NOMAD_VERSION
  export TERRAFORM_VERSION
  export PACKER_VERSION
  export BOUNDARY_VERSION
  export WAYPOINT_VERSION
  export SENTINEL_VERSION
  
  # Databases
  export MYSQL_VERSION
  export POSTGRESQL_VERSION
  export MSSQL_VERSION
  
  # Container and orchestration
  export DOCKER_VERSION
  export DOCKER_COMPOSE_VERSION
  export MINIKUBE_VERSION
  export KUBECTL_VERSION
  export HELM_VERSION
  export ARGOCD_VERSION
  
  # Monitoring and observability
  export PROMETHEUS_VERSION
  export GRAFANA_VERSION
  export ELASTICSEARCH_VERSION
  export KIBANA_VERSION
  export UPTIME_KUMA_VERSION
  
  # CI/CD and DevOps tools
  export JENKINS_VERSION
  export GITLAB_VERSION
  export ANSIBLE_VERSION
  export ANSIBLE_TOWER_VERSION
  export VSCODE_SERVER_VERSION
  
  # Other components
  export DOCSIFY_VERSION
  export LDAP_VERSION
  export LOCALSTACK_VERSION
  export APACHE_AIRFLOW_VERSION
  export DBT_VERSION
}

# Print versions
print_versions() {
  echo -e "${MAGENTA}HashiQube Component Versions${NC}"
  echo -e "${MAGENTA}===========================${NC}"
  
  echo -e "${MAGENTA}HashiCorp Products:${NC}"
  echo "Vault:     $VAULT_VERSION"
  echo "Consul:    $CONSUL_VERSION"
  echo "Nomad:     $NOMAD_VERSION"
  echo "Terraform: $TERRAFORM_VERSION"
  echo "Packer:    $PACKER_VERSION"
  echo "Boundary:  $BOUNDARY_VERSION"
  echo "Waypoint:  $WAYPOINT_VERSION"
  echo "Sentinel:  $SENTINEL_VERSION"
  
  echo -e "\n${MAGENTA}Databases:${NC}"
  echo "MySQL:      $MYSQL_VERSION"
  echo "PostgreSQL: $POSTGRESQL_VERSION"
  echo "MSSQL:      $MSSQL_VERSION"
  
  echo -e "\n${MAGENTA}Container and Orchestration:${NC}"
  echo "Docker:        $DOCKER_VERSION"
  echo "Docker Compose: $DOCKER_COMPOSE_VERSION"
  echo "Minikube:      $MINIKUBE_VERSION"
  echo "Kubectl:       $KUBECTL_VERSION"
  echo "Helm:          $HELM_VERSION"
  echo "ArgoCD:        $ARGOCD_VERSION"
  
  echo -e "\n${MAGENTA}Monitoring and Observability:${NC}"
  echo "Prometheus:    $PROMETHEUS_VERSION"
  echo "Grafana:       $GRAFANA_VERSION"
  echo "Elasticsearch: $ELASTICSEARCH_VERSION"
  echo "Kibana:        $KIBANA_VERSION"
  echo "Uptime Kuma:   $UPTIME_KUMA_VERSION"
  
  echo -e "\n${MAGENTA}CI/CD and DevOps Tools:${NC}"
  echo "Jenkins:       $JENKINS_VERSION"
  echo "GitLab:        $GITLAB_VERSION"
  echo "Ansible:       $ANSIBLE_VERSION"
  echo "Ansible Tower: $ANSIBLE_TOWER_VERSION"
  echo "VS Code Server: $VSCODE_SERVER_VERSION"
  
  echo -e "\n${MAGENTA}Other Components:${NC}"
  echo "Docsify:       $DOCSIFY_VERSION"
  echo "LDAP:          $LDAP_VERSION"
  echo "LocalStack:    $LOCALSTACK_VERSION"
  echo "Apache Airflow: $APACHE_AIRFLOW_VERSION"
  echo "DBT:           $DBT_VERSION"
}

# Export all versions
export_versions

# If this script is sourced, just define the variables and functions
# If it's executed directly, print the versions
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  print_versions
fi
