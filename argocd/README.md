# Argocd

![Argocd Logo](images/argocd-logo.png?raw=true "Argocd Logo")

Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes.

## Why Argo CD?

Application definitions, configurations, and environments should be declarative and version controlled. Application deployment and lifecycle management should be automated, auditable, and easy to understand.

![Argocd UI](images/argocd-ui.webp?raw=true "Argocd UI")

## How it works? 

Argo CD follows the GitOps pattern of using Git repositories as the source of truth for defining the desired application state. Kubernetes manifests can be specified in several ways:

- kustomize applications
- helm charts
- jsonnet files
- Plain directory of YAML/json manifests
- Any custom config management tool configured as a config management plugin

Argo CD automates the deployment of the desired application states in the specified target environments. Application deployments can track updates to branches, tags, or pinned to a specific version of manifests at a Git commit. See tracking strategies for additional details about the different tracking strategies available.

## Get started

`vagrant up --provision-with basetools,docsify,docker,minikube,argocd`

```log
...
==> hashiqube0: Running provisioner: argocd (shell)...
    hashiqube0: Running: /var/folders/_6/ryd81jzj43n40qjtl4s293cm0000gn/T/vagrant-shell20240516-87542-6d58v.sh
    hashiqube0: CPU is arm64
    hashiqube0: ++++
    hashiqube0: ++++ Ensure Docker Daemon is running (Dependency)
    hashiqube0: ++++
    hashiqube0: ++++ Docker is running
    hashiqube0: ++++
    hashiqube0: ++++ Ensure Minikube is running (Dependency)
    hashiqube0: ++++
    hashiqube0: Minikube is running
    hashiqube0: ++++
    hashiqube0: ++++ Create Argocd Namespace
    hashiqube0: ++++
    hashiqube0: namespace/argocd created
    hashiqube0: ++++
    hashiqube0: ++++ Install Argocd using kubectl
    hashiqube0: ++++
    hashiqube0: customresourcedefinition.apiextensions.k8s.io/applications.argoproj.io created
    hashiqube0: customresourcedefinition.apiextensions.k8s.io/applicationsets.argoproj.io created
    hashiqube0: customresourcedefinition.apiextensions.k8s.io/appprojects.argoproj.io created
    hashiqube0: serviceaccount/argocd-application-controller created
    hashiqube0: serviceaccount/argocd-applicationset-controller created
    hashiqube0: serviceaccount/argocd-dex-server created
    hashiqube0: serviceaccount/argocd-notifications-controller created
    hashiqube0: serviceaccount/argocd-redis created
    hashiqube0: serviceaccount/argocd-repo-server created
    hashiqube0: serviceaccount/argocd-server created
    hashiqube0: role.rbac.authorization.k8s.io/argocd-application-controller created
    hashiqube0: role.rbac.authorization.k8s.io/argocd-applicationset-controller created
    hashiqube0: role.rbac.authorization.k8s.io/argocd-dex-server created
    hashiqube0: role.rbac.authorization.k8s.io/argocd-notifications-controller created
    hashiqube0: role.rbac.authorization.k8s.io/argocd-server created
    hashiqube0: clusterrole.rbac.authorization.k8s.io/argocd-application-controller created
    hashiqube0: clusterrole.rbac.authorization.k8s.io/argocd-applicationset-controller created
    hashiqube0: clusterrole.rbac.authorization.k8s.io/argocd-server created
    hashiqube0: rolebinding.rbac.authorization.k8s.io/argocd-application-controller created
    hashiqube0: rolebinding.rbac.authorization.k8s.io/argocd-applicationset-controller created
    hashiqube0: rolebinding.rbac.authorization.k8s.io/argocd-dex-server created
    hashiqube0: rolebinding.rbac.authorization.k8s.io/argocd-notifications-controller created
    hashiqube0: rolebinding.rbac.authorization.k8s.io/argocd-server created
    hashiqube0: clusterrolebinding.rbac.authorization.k8s.io/argocd-application-controller created
    hashiqube0: clusterrolebinding.rbac.authorization.k8s.io/argocd-applicationset-controller created
    hashiqube0: clusterrolebinding.rbac.authorization.k8s.io/argocd-server created
    hashiqube0: configmap/argocd-cm created
    hashiqube0: configmap/argocd-cmd-params-cm created
    hashiqube0: configmap/argocd-gpg-keys-cm created
    hashiqube0: configmap/argocd-notifications-cm created
    hashiqube0: configmap/argocd-rbac-cm created
    hashiqube0: configmap/argocd-ssh-known-hosts-cm created
    hashiqube0: configmap/argocd-tls-certs-cm created
    hashiqube0: secret/argocd-notifications-secret created
    hashiqube0: secret/argocd-secret created
    hashiqube0: service/argocd-applicationset-controller created
    hashiqube0: service/argocd-dex-server created
    hashiqube0: service/argocd-metrics created
    hashiqube0: service/argocd-notifications-controller-metrics created
    hashiqube0: service/argocd-redis created
    hashiqube0: service/argocd-repo-server created
    hashiqube0: service/argocd-server created
    hashiqube0: service/argocd-server-metrics created
    hashiqube0: deployment.apps/argocd-applicationset-controller created
    hashiqube0: deployment.apps/argocd-dex-server created
    hashiqube0: deployment.apps/argocd-notifications-controller created
    hashiqube0: deployment.apps/argocd-redis created
    hashiqube0: deployment.apps/argocd-repo-server created
    hashiqube0: deployment.apps/argocd-server created
    hashiqube0: statefulset.apps/argocd-application-controller created
    hashiqube0: networkpolicy.networking.k8s.io/argocd-application-controller-network-policy created
    hashiqube0: networkpolicy.networking.k8s.io/argocd-applicationset-controller-network-policy created
    hashiqube0: networkpolicy.networking.k8s.io/argocd-dex-server-network-policy created
    hashiqube0: networkpolicy.networking.k8s.io/argocd-notifications-controller-network-policy created
    hashiqube0: networkpolicy.networking.k8s.io/argocd-redis-network-policy created
    hashiqube0: networkpolicy.networking.k8s.io/argocd-repo-server-network-policy created
    hashiqube0: networkpolicy.networking.k8s.io/argocd-server-network-policy created
    hashiqube0: ++++
    hashiqube0: ++++ Waiting for Argocd Server to become available, (1/20) sleep 60s
    hashiqube0: ++++
    hashiqube0: NAME                                                   READY   STATUS            RESTARTS   AGE
    hashiqube0: pod/argocd-application-controller-0                    1/1     Running           0          61s
    hashiqube0: pod/argocd-applicationset-controller-c4fd6dcdb-vcj58   1/1     Running           0          62s
    hashiqube0: pod/argocd-dex-server-869bdc7dcb-h2c4l                 0/1     PodInitializing   0          62s
    hashiqube0: pod/argocd-notifications-controller-6bbd5dd8d-7trfr    1/1     Running           0          62s
    hashiqube0: pod/argocd-redis-79c9bd545b-2rntm                      1/1     Running           0          62s
    hashiqube0: pod/argocd-repo-server-f965fdfcf-r2hc4                 1/1     Running           0          62s
    hashiqube0: pod/argocd-server-94c995fcb-p5r8s                      1/1     Running           0          62s
    hashiqube0: 
    hashiqube0: NAME                                              TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
    hashiqube0: service/argocd-applicationset-controller          ClusterIP   10.110.147.174   <none>        7000/TCP,8080/TCP            62s
    hashiqube0: service/argocd-dex-server                         ClusterIP   10.103.19.31     <none>        5556/TCP,5557/TCP,5558/TCP   62s
    hashiqube0: service/argocd-metrics                            ClusterIP   10.110.160.2     <none>        8082/TCP                     62s
    hashiqube0: service/argocd-notifications-controller-metrics   ClusterIP   10.103.106.161   <none>        9001/TCP                     62s
    hashiqube0: service/argocd-redis                              ClusterIP   10.98.131.184    <none>        6379/TCP                     62s
    hashiqube0: service/argocd-repo-server                        ClusterIP   10.105.48.221    <none>        8081/TCP,8084/TCP            62s
    hashiqube0: service/argocd-server                             ClusterIP   10.111.209.124   <none>        80/TCP,443/TCP               62s
    hashiqube0: service/argocd-server-metrics                     ClusterIP   10.106.168.193   <none>        8083/TCP                     62s
    hashiqube0: 7m21s       Normal   NodeHasSufficientMemory   node/minikube                          Node minikube status is now: NodeHasSufficientMemory
    hashiqube0: Running
    hashiqube0: ++++
    hashiqube0: ++++ Change the argocd-server service type to NodePort
    hashiqube0: ++++
    hashiqube0: service/argocd-server patched
    hashiqube0: ++++
    hashiqube0: ++++ Get argocd-initial-admin-secret
    hashiqube0: ++++
    hashiqube0: ++++ Argocd Admin Password: -FSZUP98JO50x5re
    hashiqube0: ++++
    hashiqube0: ++++ kubectl port-forward -n argocd service/argocd-server 18043:80 --address="0.0.0.0"
    hashiqube0: ++++
    hashiqube0: ++++
    hashiqube0: ++++ kubectl port-forward -n argocd service/argocd-server 18043:80 --address="0.0.0.0", (1/20) sleep 60s
    hashiqube0: ++++
    hashiqube0: ++++
    hashiqube0: ++++ kubectl port-forward -n argocd service/argocd-server 18043:80 --address="0.0.0.0", (2/20) sleep 60s
    hashiqube0: ++++
    hashiqube0: tcp        0      0 0.0.0.0:18043           0.0.0.0:*               LISTEN      22218/kubectl
    hashiqube0: ++++
    hashiqube0: ++++ Access Argocd
    hashiqube0: ++++
    hashiqube0: ++++ Argocd Server started at http://localhost:18043
    hashiqube0: ++++ Login with admin:-FSZUP98JO50x5re
    hashiqube0: ++++ Argocd Documentation http://localhost:3333/#/argocd/README?id=argocd
```

## Links 

- https://argo-cd.readthedocs.io/en/stable/operator-manual/installation/
- https://devopscube.com/setup-argo-cd-using-helm/

## Argocd Vagrant Provisioner

`argocd.sh`

[filename](argocd.sh ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')