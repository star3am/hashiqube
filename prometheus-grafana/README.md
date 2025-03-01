# Prometheus and Grafana

<div align="center">
  <p><strong>Comprehensive monitoring and visualization for your entire infrastructure</strong></p>
</div>

## 🚀 Introduction

In this HashiQube DevOps lab, you will get hands-on experience with Grafana and Prometheus. Together, they provide a powerful monitoring and alerting solution for your infrastructure.

## 📊 Monitoring Components

### Grafana

![Grafana Logo](images/grafana-logo.png?raw=true "Grafana Logo")

[Grafana](https://grafana.com/) is a multi-platform open source analytics and interactive visualization web application. It provides charts, graphs, and alerts for the web when connected to supported data sources.

### Prometheus

![Prometheus Logo](images/prometheus-logo.png?raw=true "Prometheus Logo")

Prometheus is an open source monitoring system for which Grafana provides out-of-the-box support. It collects metrics from configured targets at given intervals, evaluates rule expressions, displays the results, and can trigger alerts when specified conditions are observed.

## 🛠️ Provision

In order to provision Prometheus and Grafana, you need basetools, docker, and minikube as dependencies.

> 💡 We enable Vault, Consul and Nomad, because we monitor these with Prometheus. We also enable Minikube because we host Grafana and Prometheus on Minikube and deploy them using Helm.

Choose one of the following methods to set up your environment:

<!-- tabs:start -->

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash vault/vault.sh
bash consul/consul.sh
bash nomad/nomad.sh
bash minikube/minikube.sh
bash prometheus-grafana/prometheus-grafana.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docker,docsify,vault,consul,nomad,minikube,prometheus-grafana
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash vault/vault.sh
bash consul/consul.sh
bash nomad/nomad.sh
bash minikube/minikube.sh
bash prometheus-grafana/prometheus-grafana.sh
```
<!-- tabs:end -->

## 🔍 Accessing Monitoring Tools

After provisioning, you can access the interfaces at:

- **Prometheus**: <http://localhost:9090>
- **Alertmanager**: <http://localhost:9093>
- **Grafana**: <http://localhost:3000>
  - Username: `admin`
  - Password: Look for the password displayed in the terminal output

Look at the Minikube dashboard for progress updates and check the terminal output for details:

```bash
...
hashiqube0.service.consul: ++++ Waiting for Prometheus to stabalize, sleep 30s
hashiqube0.service.consul: NAME                                            READY   STATUS    RESTARTS   AGE
hashiqube0.service.consul: grafana-557fc9455c-67h4s                        1/1     Running   0          90s
hashiqube0.service.consul: hello-minikube-7bc9d7884c-fks85                 1/1     Running   0          3m36s
hashiqube0.service.consul: prometheus-alertmanager-76b7444fc5-8b2sq        2/2     Running   0          100s
hashiqube0.service.consul: prometheus-kube-state-metrics-748fc7f64-hxcvj   1/1     Running   0          100s
hashiqube0.service.consul: prometheus-node-exporter-xm6fw                  1/1     Running   0          100s
hashiqube0.service.consul: prometheus-pushgateway-5f478b75f7-j9tpj         1/1     Running   0          100s
hashiqube0.service.consul: prometheus-server-8c96d4966-bv24c               1/2     Running   0          100s
...
hashiqube0.service.consul: ++++ Prometheus http://localhost:9090
hashiqube0.service.consul: ++++ Grafana http://localhost:3000 and login with Username: admin Password:
hashiqube0.service.consul: N6as3Odq7bprqVdvWV5iFmwhOLs8QvutCJb8f2lS
```

![Minikube Dashboard Pods](images/minikube-dashboard-pods.png?raw=true "Minikube Dashboard Pods")

## 🔄 Prometheus Targets

You can open the Prometheus web interface and look at Status -> Targets to verify that all monitored services are properly configured:

![Prometheus Targets](images/prometheus.png?raw=true "Prometheus Targets")

## 📈 Grafana Configuration

> 💡 The Grafana datasource is configured automatically during the provisioning step in the grafana-values.yaml file.

```yaml
[filename](grafana-values.yaml ':include :type=code')
```

To access Grafana, go to <http://localhost:3000> and log in with:

- Username: `admin`
- Password: The token displayed in the terminal output

![Grafana Login](images/grafana.png?raw=true "Grafana Login")

## 📊 Monitoring HashiCorp Products

### Monitoring Vault

HashiCorp Vault is configured with telemetry for Prometheus monitoring:

```hcl
# https://developer.hashicorp.com/vault/docs/configuration/telemetry
# https://developer.hashicorp.com/vault/docs/configuration/telemetry#prometheus
telemetry {
  disable_hostname = true
  prometheus_retention_time = "12h"
}
```

The Prometheus values file is configured to scrape Vault metrics:

```yaml
[filename](prometheus-values.yaml ':include :type=code')
```

You should see the Vault target in Prometheus web interface at <http://localhost:9090/targets>:

![Prometheus Vault Target](images/prometheus-targets-vault.png?raw=true "Prometheus Vault Target")

To view the Vault dashboard in Grafana:

1. Navigate to Grafana
2. Click on the + symbol in the top menu
3. Select "Import Dashboard"
4. Enter Dashboard ID: `12904`
5. Click "Load"

![Grafana HashiCorp Vault Dashboard](images/grafana-hashicorp-vault-dashboard.png?raw=true "Grafana HashiCorp Vault Dashboard")

### Monitoring Nomad

HashiCorp Nomad is configured with telemetry for Prometheus monitoring:

```hcl
# https://developer.hashicorp.com/nomad/docs/configuration/telemetry
telemetry {
  collection_interval = "1s"
  disable_hostname = true
  prometheus_metrics = true
  publish_allocation_metrics = true
  publish_node_metrics = true
}
```

To view the Nomad dashboard in Grafana:

1. Navigate to Grafana
2. Click on the + symbol in the top menu
3. Select "Import Dashboard"
4. Enter Dashboard ID: `12787`
5. Click "Load"

![Grafana HashiCorp Nomad Dashboard](images/grafana-hashicorp-nomad-dashboard.png?raw=true "Grafana HashiCorp Nomad Dashboard")

### Monitoring Consul

HashiCorp Consul is configured with telemetry for Prometheus monitoring:

```hcl
# https://developer.hashicorp.com/consul/docs/agent/telemetry
telemetry {
  prometheus_retention_time = "24h"
  disable_hostname = true
}
```

To view the Consul dashboard in Grafana:

1. Navigate to Grafana
2. Click on the + symbol in the top menu
3. Select "Import Dashboard"
4. Enter Dashboard ID: `10642`
5. Click "Load"

![Grafana HashiCorp Consul Dashboard](images/grafana-hashicorp-consul-dashboard.png?raw=true "Grafana HashiCorp Consul Dashboard")

### Monitoring Docker

Docker is configured to expose metrics for Prometheus:

```json
{
  "metrics-addr": "0.0.0.0:9323",
  "experimental": true,
  "storage-driver": "overlay2",
  "insecure-registries": ["10.9.99.10:5001", "10.9.99.10:5002", "localhost:5001", "localhost:5002"]
}
```

To view the Docker dashboard in Grafana:

1. Navigate to Grafana
2. Click on the + symbol in the top menu
3. Select "Import Dashboard"
4. Enter Dashboard ID: `10619`
5. Click "Load"

![Grafana Docker Dashboard](images/grafana-docker-dashboard.png?raw=true "Grafana Docker Dashboard")

## ⚙️ Prometheus Grafana Provisioner

The provisioning script handles the installation and configuration of Prometheus and Grafana:

```bash
[filename](prometheus-grafana.sh ':include :type=code')
```

## 📚 Resources

- [Prometheus Documentation](https://prometheus.io/docs/introduction/overview/)
- [Grafana Documentation](https://grafana.com/docs/)
- [HashiCorp Vault Telemetry](https://developer.hashicorp.com/vault/docs/configuration/telemetry)
- [HashiCorp Nomad Telemetry](https://developer.hashicorp.com/nomad/docs/configuration/telemetry)
- [HashiCorp Consul Telemetry](https://developer.hashicorp.com/consul/docs/agent/telemetry)
- [Docker Prometheus Metrics](https://docs.docker.com/config/daemon/prometheus/)
