# Argo CD

<div align="center">
  <img src="images/argocd-logo.png" alt="Argo CD Logo" width="300px">
  <br><br>
  <p><strong>Declarative, GitOps continuous delivery for Kubernetes</strong></p>
</div>

## 🚀 Why Argo CD?

Application definitions, configurations, and environments should be declarative and version controlled. Application deployment and lifecycle management should be automated, auditable, and easy to understand.

<div align="center">
  <img src="images/argocd-ui.webp" alt="Argo CD UI" width="85%">
  <p><em>Argo CD user interface showing application deployments</em></p>
</div>

## 🔄 How It Works

Argo CD follows the GitOps pattern of using Git repositories as the source of truth for defining the desired application state. Kubernetes manifests can be specified in several ways:

- **Kustomize applications**
- **Helm charts**
- **Jsonnet files**
- **Plain directory of YAML/JSON manifests**
- **Any custom config management tool** configured as a config management plugin

Argo CD automates the deployment of the desired application states in the specified target environments. Application deployments can track updates to branches, tags, or be pinned to a specific version of manifests at a Git commit. See tracking strategies for additional details about the different tracking strategies available.

## 📋 Provision

<!-- tabs:start -->

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash minikube/minikube.sh
bash argocd/argocd.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docsify,docker,minikube,argocd
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash minikube/minikube.sh
bash argocd/argocd.sh
```

<!-- tabs:end -->

## 🛠️ Provisioner Script

The following script automates the Argo CD deployment on Minikube:

```bash
#!/bin/bash

# Print the commands that are run
set -x

# Stop execution if something fails
set -e

# Add Helm Repos
echo "+++ Adding helm repos +++"
helm repo add argo https://argoproj.github.io/argo-helm && helm repo update

# Install ArgoCD
echo "+++ Install argocd +++"
minikube kubectl -- create namespace argocd
helm install argocd argo/argo-cd \
   --set server.service.type=NodePort \
   --set server.service.nodePortHttp=30080 \
   --set server.extraArgs[0]="--insecure" \
   --namespace argocd

# Download ArgoCD CLI
echo "+++ Download ArgoCD CLI +++"
sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd

# Get initial admin password
echo "+++ Get initial admin password +++"
sleep 15
echo "ArgoCD admin password: "
minikube kubectl -- get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d

echo "+++ ArgoCD URL: http://localhost:30080 +++"
echo "+++ Username: admin, Password: Use the password from above +++"
```

## 🔗 Additional Resources

- [Argo CD Official Documentation](https://argo-cd.readthedocs.io/en/stable/operator-manual/installation/)
- [DevOpsCube: Setup Argo CD Using Helm](https://devopscube.com/setup-argo-cd-using-helm/)
- [Argo CD Best Practices](https://argo-cd.readthedocs.io/en/stable/user-guide/best_practices/)
- [GitOps with Argo CD](https://argo-cd.readthedocs.io/en/stable/user-guide/ci_integration/)

## 🚪 Access Information

After provisioning, you can access Argo CD at:

- **URL**: <http://localhost:30080>
- **Username**: admin
- **Password**: Retrieve using the command below:

```bash
minikube kubectl -- get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
```

## 📚 Key Features

- **Automated deployment** of applications to specified target environments
- **Multiple config management tools** support (Kustomize, Helm, Jsonnet, etc.)
- **Webhooks integration** for automated GitOps workflows
- **Web UI** for application management and visualization
- **Application health status** analysis
- **SSO Integration** with OIDC, OAuth2, LDAP, SAML 2.0, GitHub, GitLab, Microsoft, LinkedIn
- **Webhook integrations** (GitHub, BitBucket, GitLab)
- **PreSync, Sync, PostSync hooks** for complex application rollouts
- **Prometheus metrics** for monitoring
