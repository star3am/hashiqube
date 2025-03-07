# Newrelic Kubernetes Monitoring

<div align="center">
  <p><strong>Monitor your Kubernetes clusters with Newrelic in a HashiQube DevOps lab environment</strong></p>
</div>

![Newrelic Logo](images/newrelic-logo.png?raw=true "Newrelic Logo")

## 🚀 Introduction

This lab provides hands-on experience with Newrelic Monitoring using Helm on Minikube. You'll learn how to set up comprehensive monitoring for your Kubernetes environment using Newrelic's powerful observability platform.

![Newrelic Kubernetes Monitoring](images/newrelic-kubernetes-monitoring.png?raw=true "Newrelic Kubernetes Monitoring")

## 🛠️ Provision

Choose one of the following methods to set up your environment:

<!-- tabs:start -->

### **Github Codespace**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash minikube/minikube.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docker,docsify,minikube
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash minikube/minikube.sh
```
<!-- tabs:end -->

After provisioning, you should be able to access the Minikube dashboard at: <http://localhost:10888>

![Minikube Dashboard](images/minikube.png?raw=true "Minikube Dashboard")

> 💡 For more detailed information on running Minikube on HashiQube, visit: [**Minikube**](minikube/#minikube)

## 📊 Newrelic Setup

### Getting Started with Newrelic

1. Head over to <http://www.newrelic.com> and create a free demo account
2. Log in to your Newrelic account

![Newrelic Logged in](images/01-newrelic-logged-in.png?raw=true "Newrelic Logged in")

3. Select your account and Kubernetes namespace for the integration

![Newrelic Account and Namespace](images/02-newrelic-select-account-and-namespace.png?raw=true "Newrelic Account and Namespace")

4. Choose the Newrelic features for your integration

![Newrelic Integration Features](images/03-newrelic-features.png?raw=true "Newrelic Integration Features")

## 🧩 Installation

Please visit <https://one.newrelic.com/launcher/k8s-cluster-explorer-nerdlet.cluster-explorer-launcher> and follow the steps there. At the end, you'll receive a Helm command similar to the one below.

![Newrelic Integration Install with Helm](images/04-newrelic-install-with-helm.png?raw=true "Newrelic Integration Install with Helm")

### Installation Steps

1. SSH into your HashiQube environment:

   ```bash
   vagrant ssh
   ```

2. Run the Helm command provided by Newrelic:

   ```bash
   helm repo add newrelic https://helm-charts.newrelic.com && helm repo update && \
   kubectl create namespace newrelic; 
   
   helm upgrade --install newrelic-bundle newrelic/nri-bundle \
   --set global.licenseKey=YOUR_NEWRELIC_LICENSE_KEY \
   --set global.cluster=minikube \
   --namespace=newrelic \
   --set newrelic-infrastructure.privileged=true \
   --set global.lowDataMode=true \
   --set ksm.enabled=true \
   --set kubeEvents.enabled=true \
   --set prometheus.enabled=true \
   --set logging.enabled=true \
   --set newrelic-pixie.enabled=true \
   --set newrelic-pixie.apiKey=YOUR_PIXIE_API_KEY \
   --set pixie-chart.enabled=true \
   --set pixie-chart.deployKey=YOUR_PIXIE_DEPLOY_KEY \
   --set pixie-chart.clusterName=minikube
   ```

> ⚠️ Remember to replace `YOUR_NEWRELIC_LICENSE_KEY`, `YOUR_PIXIE_API_KEY`, and `YOUR_PIXIE_DEPLOY_KEY` with your actual keys.

## 🔍 Verification

To verify that all Newrelic components are running properly:

```bash
kubectl get po,svc -n newrelic
```

Example output:

```bash
NAME                                                          READY   STATUS                       RESTARTS      AGE
pod/newrelic-bundle-kube-state-metrics-654df84864-9hvk8       1/1     Running                      0             19m
pod/newrelic-bundle-newrelic-logging-xfs98                    1/1     Running                      0             19m
pod/newrelic-bundle-newrelic-pixie-jxfcv                      0/1     CreateContainerConfigError   0             19m
pod/newrelic-bundle-nri-kube-events-6c65bbbc8f-mjrvt          2/2     Running                      0             19m
pod/newrelic-bundle-nri-metadata-injection-675dd8f8f7-m5vcg   1/1     Running                      0             19m
pod/newrelic-bundle-nri-prometheus-64b9696b7b-xl9kk           1/1     Running                      0             19m
pod/newrelic-bundle-nrk8s-controlplane-lsx5t                  2/2     Running                      1 (17m ago)   19m
pod/newrelic-bundle-nrk8s-ksm-5d598df8d-v8rdv                 2/2     Running                      0             19m
pod/newrelic-bundle-nrk8s-kubelet-9xb68                       2/2     Running                      0             19m

NAME                                             TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/newrelic-bundle-kube-state-metrics       ClusterIP   10.107.30.223   <none>        8080/TCP   19m
service/newrelic-bundle-nri-metadata-injection   ClusterIP   10.96.68.196    <none>        443/TCP    19m
```

## 📈 Viewing Monitoring Data

Within a few minutes, you'll be able to see your Kubernetes clusters in the Newrelic interface:

![Newrelic Kubernetes Integration Clusters](images/05-newrelic-kuibernetes-clusters.png?raw=true "Newrelic Kubernetes Integration Clusters")

You can then explore the data streaming from your cluster:

![Newrelic Kubernetes Summary 1](images/06-newrelic-summary-01.png?raw=true "Newrelic Kubernetes Summary 1")

![Newrelic Kubernetes Summary 2](images/06-newrelic-summary-02.png?raw=true "Newrelic Kubernetes Summary 2")

## ⚙️ Known Issues

### Pixie on ARM64 Architecture

There's a known issue when trying to run Pixie on ARM64 chipsets (like Apple M1). You may encounter the following error:

```bash
bash: line 225: /home/vagrant/bin/px: cannot execute binary file: Exec format error
```

This is due to compatibility issues with the ARM64 architecture. The Pixie binary is likely compiled for x86_64 architecture and won't run directly on ARM-based systems.

![Newrelic Pixie Integration](images/07-newrelic-pixie.png?raw=true "Newrelic Pixie Integration")

#### Attempted Installation

```bash
bash -c "$(curl -fsSL https://work.withpixie.ai/install.sh)"
```

#### Error Output

```bash
  ___  _       _
 | _ \(_)__ __(_) ___
 |  _/| |\ \ /| |/ -_)
 |_|  |_|/_\_\|_|\___|

==> Info:
Pixie gives engineers access to no-instrumentation, streaming &
unsampled auto-telemetry to debug performance issues in real-time,
More information at: https://www.pixielabs.ai.

# ... truncated output ...

==> Authenticating with Pixie Cloud:
bash: line 225: /home/vagrant/bin/px: cannot execute binary file: Exec format error

FAILED to authenticate with Pixie cloud. 
  You can try this step yourself by running px auth login.
  For help, please contact support@pixielabs.ai or join our community slack/github"

# ... truncated output ...
```

## 📚 Resources

- [Newrelic Kubernetes Integration Documentation](https://docs.newrelic.com/docs/kubernetes-pixie/kubernetes-integration/installation/kubernetes-integration-install-configure)
- [Minikube Documentation](https://kubernetes.io/docs/tasks/tools/install-minikube/)
- [Kubernetes Dashboard Documentation](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/)
- [Pixie Documentation](https://work.withpixie.ai/docs)

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')