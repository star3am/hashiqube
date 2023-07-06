# Minikube

https://minikube.sigs.k8s.io/docs/start/

![Minikube Logo](images/minikube-logo.png?raw=true "Minikube Logo")

This page shows you how to install Minikube, a tool that runs a single-node Kubernetes cluster in a virtual machine on your personal computer.
https://kubernetes.io/docs/tasks/tools/install-minikube/
https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/

## Minikube usage

You should have done `vagrant up --provision` This sets up the base Virtual machine, with some default applications.
Now please do,
`vagrant up --provision-with basetools,docker,docsify,minikube`
```log
Bringing machine 'user.local.dev' up with 'virtualbox' provider...
==> user.local.dev: Checking if box 'ubuntu/xenial64' version '20190918.0.0' is up to date...
==> user.local.dev: A newer version of the box 'ubuntu/xenial64' for provider 'virtualbox' is
==> user.local.dev: available! You currently have version '20190918.0.0'. The latest is version
==> user.local.dev: '20191204.0.0'. Run `vagrant box update` to update.
==> user.local.dev: [vagrant-hostsupdater] Checking for host entries
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: Running provisioner: minikube (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20191212-33841-85girj.sh
    user.local.dev: Minicube found at /home/vagrant/minikube
    user.local.dev: * Uninstalling Kubernetes v1.17.0 using kubeadm ...
    user.local.dev: * Deleting "minikube" in none ...
    user.local.dev: * The "minikube" cluster has been deleted.
    user.local.dev: * Trying to delete invalid profile minikube
    user.local.dev: * Successfully deleted profile "minikube"
    user.local.dev: * minikube v1.6.1 on Ubuntu 16.04 (vbox/amd64)
    user.local.dev: * Selecting 'none' driver from user configuration (alternates: [])
    user.local.dev: * Running on localhost (CPUs=2, Memory=3951MB, Disk=9861MB) ...
    user.local.dev: * OS release is Ubuntu 16.04.6 LTS
    user.local.dev: * Preparing Kubernetes v1.17.0 on Docker '19.03.5' ...
    user.local.dev:   - kubelet.node-ip=10.9.99.10
    user.local.dev: * Pulling images ...
    user.local.dev: * Launching Kubernetes ...
    user.local.dev: E1212 05:37:03.427248   10726 kubeadm.go:368] Overriding stale ClientConfig host https://localhost:8443 with https://10.0.2.15:8443
    user.local.dev: * Configuring local host environment ...
    user.local.dev: *
    user.local.dev:   - https://minikube.sigs.k8s.io/docs/reference/drivers/none/
    user.local.dev: *
    user.local.dev: *
    user.local.dev:   - sudo mv /home/vagrant/.kube /home/vagrant/.minikube $HOME
    user.local.dev:   - sudo chown -R $USER $HOME/.kube $HOME/.minikube
    user.local.dev: *
    user.local.dev: * This can also be done automatically by setting the env var CHANGE_MINIKUBE_NONE_USER=true
    user.local.dev: * Waiting for cluster to come online ...
    user.local.dev: ! The 'none' driver provides limited isolation and may reduce system security and reliability.
    user.local.dev: ! For more information, see:
    user.local.dev: ! kubectl and minikube configuration will be stored in /home/vagrant
    user.local.dev: ! To use kubectl or minikube commands as your own user, you may need to relocate them. For example, to overwrite your own settings, run:
    user.local.dev: E1212 05:37:03.517401   10726 kubeadm.go:368] Overriding stale ClientConfig host https://localhost:8443 with https://10.0.2.15:8443
    user.local.dev: * Done! kubectl is now configured to use "minikube"
    user.local.dev: chmod: changing permissions of 'kubectl': Operation not permitted
    user.local.dev: * minikube IP has been updated to point at 10.0.2.15
    user.local.dev: W1212 05:37:16.080458   14080 proxy.go:142] Request filter disabled, your proxy is vulnerable to XSRF attacks, please be cautious
    user.local.dev: Starting to serve on 10.9.99.10:10888
    user.local.dev: host:
    user.local.dev: Running
    user.local.dev: kubelet: Running
    user.local.dev: apiserver: Running
    user.local.dev: kubeconfig: Configured
    user.local.dev: NAME       STATUS   ROLES    AGE   VERSION
    user.local.dev: minikube   Ready    master   16s   v1.17.0
    user.local.dev: deployment.apps/hello-minikube created
    user.local.dev: service/hello-minikube exposed
    user.local.dev: http://10.0.2.15:30664
    user.local.dev: NAME
    user.local.dev:                               READY   STATUS    RESTARTS   AGE
    user.local.dev: hello-minikube-797f975945-sr9gg   0/1     Pending   0          0s
    user.local.dev: minikube dashboard: http://10.9.99.10:10888/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/#/overview?namespace=default
```    
Let's verify that our Minikube is running, we can go to the Dashboard by visiting in your browser:
http://localhost:10888/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/#/overview?namespace=kubernetes-dashboard

## Minikube Dashboard 

The Dashboard is a web-based Kubernetes user interface. You can use it to:

- deploy containerized applications to a Kubernetes cluster
- troubleshoot your containerized application
- manage the cluster resources
- get an overview of applications running on your cluster
- creating or modifying individual Kubernetes resources (such as Deployments, Jobs, DaemonSets, etc)

For example, you can scale a Deployment, initiate a rolling update, restart a pod or deploy new applications using a deploy wizard.

![Minikube](images/minikube.png?raw=true "Minikube")

## Kubernetes Pods

Pods are the smallest deployable units of computing that you can create and manage in Kubernetes.

A Pod (as in a pod of whales or pea pod) is a group of one or more containers, with shared storage and network resources, and a specification for how to run the containers. A Pod's contents are always co-located and co-scheduled, and run in a shared context. A Pod models an application-specific "logical host": it contains one or more application containers which are relatively tightly coupled. In non-cloud contexts, applications executed on the same physical or virtual machine are analogous to cloud applications executed on the same logical host.

As well as application containers, a Pod can contain init containers that run during Pod startup. You can also inject ephemeral containers for debugging if your cluster offers this.

![Kubernetes Pods](images/minikube-dashboard-pods.png?raw=true "Kubernetes Pods")

## Kubernetes Services

In Kubernetes, a Service is a method for exposing a network application that is running as one or more Pods in your cluster.

A key aim of Services in Kubernetes is that you don't need to modify your existing application to use an unfamiliar service discovery mechanism. You can run code in Pods, whether this is a code designed for a cloud-native world, or an older app you've containerized. You use a Service to make that set of Pods available on the network so that clients can interact with it.

If you use a Deployment to run your app, that Deployment can create and destroy Pods dynamically. From one moment to the next, you don't know how many of those Pods are working and healthy; you might not even know what those healthy Pods are named. Kubernetes Pods are created and destroyed to match the desired state of your cluster. Pods are ephemeral resources (you should not expect that an individual Pod is reliable and durable).

Each Pod gets its own IP address (Kubernetes expects network plugins to ensure this). For a given Deployment in your cluster, the set of Pods running in one moment in time could be different from the set of Pods running that application a moment later.

This leads to a problem: if some set of Pods (call them "backends") provides functionality to other Pods (call them "frontends") inside your cluster, how do the frontends find out and keep track of which IP address to connect to, so that the frontend can use the backend part of the workload?

Enter Services.

![Kubernetes Services](images/minikube-dashboard-service.png?raw=true "Kubernetes Services")

From your computer you can interact with kubectl by using `vagrant ssh -c "sudo kubectl command"`

Like so:
`vagrant ssh -c "sudo kubectl get nodes"`

```log
NAME       STATUS   ROLES    AGE   VERSION
minikube   Ready    master   59m   v1.17.0
Connection to 127.0.0.1 closed.
```

Ahandy one is get all: 
`vagrant ssh -c "kubectl get all -A"` or inside Hashiqube simply `kubectl get all -A`

```log
NAMESPACE              NAME                                                    READY   STATUS      RESTARTS      AGE
airflow                pod/airflow-postgresql-0                                1/1     Running     0             23h
airflow                pod/airflow-redis-0                                     1/1     Running     0             23h
airflow                pod/airflow-scheduler-7d6b77666c-spfv8                  2/2     Running     0             23h
airflow                pod/airflow-statsd-77685bcd45-mvkwr                     1/1     Running     0             23h
airflow                pod/airflow-triggerer-0                                 2/2     Running     0             23h
airflow                pod/airflow-webserver-c47b7f5cf-86q76                   1/1     Running     0             23h
airflow                pod/airflow-worker-0                                    2/2     Running     0             23h
awx                    pod/awx-demo-688f5b6fb9-srzhd                           4/4     Running     0             23h
awx                    pod/awx-demo-postgres-13-0                              1/1     Running     0             23h
awx                    pod/awx-operator-controller-manager-77c67cb7c6-sg7q7    2/2     Running     0             23h
default                pod/grafana-75c6d45b4f-s2tp7                            1/1     Running     0             23h
default                pod/hello-minikube-6f9d4fb9d-wt67g                      1/1     Running     0             23h
default                pod/kubernetes-trex-nodejs-v1-75df4b7c6-jgk5q           1/1     Running     0             22h
default                pod/kubernetes-trex-nodejs-v2-77b7d574b5-m72nf          1/1     Running     0             22h
default                pod/prometheus-alertmanager-0                           1/1     Running     0             23h
default                pod/prometheus-kube-state-metrics-7f6769f7c6-qj7jt      1/1     Running     0             23h
default                pod/prometheus-prometheus-node-exporter-wjq94           1/1     Running     0             23h
default                pod/prometheus-prometheus-pushgateway-684dc6674-9wcg2   1/1     Running     0             23h
default                pod/prometheus-server-76c84b55b5-4j8hl                  2/2     Running     0             23h
default                pod/traefik-5f4bd445c7-9cr4m                            1/1     Running     0             23h
default                pod/waypoint-server-0                                   1/1     Running     0             22h
ingress-nginx          pod/ingress-nginx-admission-create-mtjww                0/1     Completed   0             23h
ingress-nginx          pod/ingress-nginx-admission-patch-4pswx                 0/1     Completed   1             23h
ingress-nginx          pod/ingress-nginx-controller-6cc5ccb977-f9jsr           1/1     Running     0             23h
kube-system            pod/coredns-787d4945fb-zrfbn                            1/1     Running     0             23h
kube-system            pod/etcd-minikube                                       1/1     Running     0             23h
kube-system            pod/kube-apiserver-minikube                             1/1     Running     0             23h
kube-system            pod/kube-controller-manager-minikube                    1/1     Running     0             23h
kube-system            pod/kube-proxy-gwq9b                                    1/1     Running     0             23h
kube-system            pod/kube-scheduler-minikube                             1/1     Running     0             23h
kube-system            pod/metrics-server-6588d95b98-cf8mn                     1/1     Running     0             23h
kube-system            pod/registry-lvg4v                                      1/1     Running     0             23h
kube-system            pod/registry-proxy-k4xhh                                1/1     Running     0             23h
kube-system            pod/storage-provisioner                                 1/1     Running     1 (23h ago)   23h
kubernetes-dashboard   pod/dashboard-metrics-scraper-5c6664855-26vfl           1/1     Running     0             23h
kubernetes-dashboard   pod/kubernetes-dashboard-55c4cbbc7c-q7dqg               1/1     Running     0             23h

NAMESPACE     NAME                             DESIRED   CURRENT   READY   AGE
kube-system   replicationcontroller/registry   1         1         1       23h

NAMESPACE              NAME                                                      TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                            AGE
airflow                service/airflow-postgresql                                ClusterIP      10.101.178.41    <none>          5432/TCP                           23h
airflow                service/airflow-postgresql-hl                             ClusterIP      None             <none>          5432/TCP                           23h
airflow                service/airflow-redis                                     ClusterIP      10.100.198.182   <none>          6379/TCP                           23h
airflow                service/airflow-statsd                                    ClusterIP      10.102.60.215    <none>          9125/UDP,9102/TCP                  23h
airflow                service/airflow-triggerer                                 ClusterIP      None             <none>          8794/TCP                           23h
airflow                service/airflow-webserver                                 ClusterIP      10.108.230.135   <none>          8080/TCP                           23h
airflow                service/airflow-worker                                    ClusterIP      None             <none>          8793/TCP                           23h
awx                    service/awx-demo-postgres-13                              ClusterIP      None             <none>          5432/TCP                           23h
awx                    service/awx-demo-service                                  NodePort       10.110.124.130   <none>          80:30080/TCP                       23h
awx                    service/awx-operator-controller-manager-metrics-service   ClusterIP      10.100.4.26      <none>          8443/TCP                           23h
default                service/grafana                                           ClusterIP      10.101.167.77    <none>          80/TCP                             23h
default                service/hello-minikube                                    NodePort       10.104.198.203   <none>          3000:32633/TCP                     23h
default                service/kubernetes                                        ClusterIP      10.96.0.1        <none>          443/TCP                            23h
default                service/kubernetes-trex-nodejs                            LoadBalancer   10.107.244.72    10.107.244.72   6001:31108/TCP                     23h
default                service/prometheus-alertmanager                           ClusterIP      10.111.248.157   <none>          9093/TCP                           23h
default                service/prometheus-alertmanager-headless                  ClusterIP      None             <none>          9093/TCP                           23h
default                service/prometheus-kube-state-metrics                     ClusterIP      10.96.142.155    <none>          8080/TCP                           23h
default                service/prometheus-prometheus-node-exporter               ClusterIP      10.103.69.195    <none>          9100/TCP                           23h
default                service/prometheus-prometheus-pushgateway                 ClusterIP      10.111.92.55     <none>          9091/TCP                           23h
default                service/prometheus-server                                 ClusterIP      10.98.154.181    <none>          80/TCP                             23h
default                service/traefik                                           LoadBalancer   10.109.3.4       10.109.3.4      80:30316/TCP,443:31020/TCP         23h
default                service/waypoint-server                                   ClusterIP      None             <none>          9702/TCP,9701/TCP                  22h
default                service/waypoint-ui                                       ClusterIP      10.108.181.55    <none>          80/TCP,443/TCP,9701/TCP,9702/TCP   22h
ingress-nginx          service/ingress-nginx-controller                          NodePort       10.108.253.89    <none>          80:31981/TCP,443:30662/TCP         23h
ingress-nginx          service/ingress-nginx-controller-admission                ClusterIP      10.101.203.125   <none>          443/TCP                            23h
kube-system            service/kube-dns                                          ClusterIP      10.96.0.10       <none>          53/UDP,53/TCP,9153/TCP             23h
kube-system            service/metrics-server                                    ClusterIP      10.105.33.164    <none>          443/TCP                            23h
kube-system            service/registry                                          ClusterIP      10.107.185.218   <none>          80/TCP,443/TCP                     23h
kubernetes-dashboard   service/dashboard-metrics-scraper                         ClusterIP      10.102.3.136     <none>          8000/TCP                           23h
kubernetes-dashboard   service/kubernetes-dashboard                              ClusterIP      10.99.118.27     <none>          80/TCP                             23h

NAMESPACE     NAME                                                 DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
default       daemonset.apps/prometheus-prometheus-node-exporter   1         1         1       1            1           <none>                   23h
kube-system   daemonset.apps/kube-proxy                            1         1         1       1            1           kubernetes.io/os=linux   23h
kube-system   daemonset.apps/registry-proxy                        1         1         1       1            1           <none>                   23h

NAMESPACE              NAME                                                READY   UP-TO-DATE   AVAILABLE   AGE
airflow                deployment.apps/airflow-scheduler                   1/1     1            1           23h
airflow                deployment.apps/airflow-statsd                      1/1     1            1           23h
airflow                deployment.apps/airflow-webserver                   1/1     1            1           23h
awx                    deployment.apps/awx-demo                            1/1     1            1           23h
awx                    deployment.apps/awx-operator-controller-manager     1/1     1            1           23h
default                deployment.apps/grafana                             1/1     1            1           23h
default                deployment.apps/hello-minikube                      1/1     1            1           23h
default                deployment.apps/kubernetes-trex-nodejs-v1           1/1     1            1           23h
default                deployment.apps/kubernetes-trex-nodejs-v2           1/1     1            1           23h
default                deployment.apps/prometheus-kube-state-metrics       1/1     1            1           23h
default                deployment.apps/prometheus-prometheus-pushgateway   1/1     1            1           23h
default                deployment.apps/prometheus-server                   1/1     1            1           23h
default                deployment.apps/traefik                             1/1     1            1           23h
ingress-nginx          deployment.apps/ingress-nginx-controller            1/1     1            1           23h
kube-system            deployment.apps/coredns                             1/1     1            1           23h
kube-system            deployment.apps/metrics-server                      1/1     1            1           23h
kubernetes-dashboard   deployment.apps/dashboard-metrics-scraper           1/1     1            1           23h
kubernetes-dashboard   deployment.apps/kubernetes-dashboard                1/1     1            1           23h

NAMESPACE              NAME                                                          DESIRED   CURRENT   READY   AGE
airflow                replicaset.apps/airflow-scheduler-7d6b77666c                  1         1         1       23h
airflow                replicaset.apps/airflow-statsd-77685bcd45                     1         1         1       23h
airflow                replicaset.apps/airflow-webserver-c47b7f5cf                   1         1         1       23h
awx                    replicaset.apps/awx-demo-688f5b6fb9                           1         1         1       23h
awx                    replicaset.apps/awx-operator-controller-manager-77c67cb7c6    1         1         1       23h
default                replicaset.apps/grafana-75c6d45b4f                            1         1         1       23h
default                replicaset.apps/hello-minikube-6f9d4fb9d                      1         1         1       23h
default                replicaset.apps/kubernetes-trex-nodejs-v1-75df4b7c6           1         1         1       22h
default                replicaset.apps/kubernetes-trex-nodejs-v1-9bdf5d66f           0         0         0       23h
default                replicaset.apps/kubernetes-trex-nodejs-v2-756cb6786f          0         0         0       23h
default                replicaset.apps/kubernetes-trex-nodejs-v2-77b7d574b5          1         1         1       22h
default                replicaset.apps/prometheus-kube-state-metrics-7f6769f7c6      1         1         1       23h
default                replicaset.apps/prometheus-prometheus-pushgateway-684dc6674   1         1         1       23h
default                replicaset.apps/prometheus-server-76c84b55b5                  1         1         1       23h
default                replicaset.apps/traefik-5f4bd445c7                            1         1         1       23h
ingress-nginx          replicaset.apps/ingress-nginx-controller-6cc5ccb977           1         1         1       23h
kube-system            replicaset.apps/coredns-787d4945fb                            1         1         1       23h
kube-system            replicaset.apps/metrics-server-6588d95b98                     1         1         1       23h
kubernetes-dashboard   replicaset.apps/dashboard-metrics-scraper-5c6664855           1         1         1       23h
kubernetes-dashboard   replicaset.apps/kubernetes-dashboard-55c4cbbc7c               1         1         1       23h

NAMESPACE   NAME                                       READY   AGE
airflow     statefulset.apps/airflow-postgresql        1/1     23h
airflow     statefulset.apps/airflow-redis             1/1     23h
airflow     statefulset.apps/airflow-triggerer         1/1     23h
airflow     statefulset.apps/airflow-worker            1/1     23h
awx         statefulset.apps/awx-demo-postgres-13      1/1     23h
default     statefulset.apps/prometheus-alertmanager   1/1     23h
default     statefulset.apps/waypoint-server           1/1     22h

NAMESPACE       NAME                                       COMPLETIONS   DURATION   AGE
ingress-nginx   job.batch/ingress-nginx-admission-create   1/1           10s        23h
ingress-nginx   job.batch/ingress-nginx-admission-patch    1/1           10s        23h
```

`vagrant ssh -c "sudo kubectl get deployments"`

```log
NAME             READY   UP-TO-DATE   AVAILABLE   AGE
hello-minikube   1/1     1            1           59m
Connection to 127.0.0.1 closed.
```

`vagrant ssh -c "sudo kubectl get services"`

```log
NAME             TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)           AGE
hello-minikube   NodePort    10.96.216.129   <none>        10800:30091/TCP   59m
kubernetes       ClusterIP   10.96.0.1       <none>        443/TCP           60m
Connection to 127.0.0.1 closed.
```

Or you can SSH into the VM by doing `vagrant ssh` and then using `sudo` do:
`sudo kubectl get nodes`

```log
NAME       STATUS   ROLES    AGE   VERSION
minikube   Ready    master   63m   v1.17.0
```

## Helm Dashboard by Komodor

https://github.com/komodorio/helm-dashboard

![Helm Dashboard](images/helm-dashboard-logo.png?raw=true "Helm Dashboard")

Helm Dashboard is an open-source project which offers a UI-driven way to view the installed Helm charts, see their revision history and corresponding k8s resources. Also, you can perform simple actions like roll back to a revision or upgrade to newer version. This project is part of Komodor's vision of helping Kubernetes users to navigate and troubleshoot their clusters, the project is NOT an official project by the helm team.

Key capabilities of the tool:

- See all installed charts and their revision history
- See manifest diff of the past revisions
- Browse k8s resources resulting from the chart
- Easy rollback or upgrade version with a clear and easy manifest diff
- Integration with popular problem scanners
- Easy switch between multiple clusters
- Can be used locally, or installed into Kubernetes cluster
- Does not require Helm or Kubectl installed

You can access Helm Dashboard
http://localhost:11888/

![Helm Dashboard](images/helm-dashboard.png?raw=true "Helm Dashboard")

## K9s CLI for Minikube
k9s is a CLI tool for interacting with k8s clusters. It wraps kubectl functionality to provide a terminal interface for interaction with clusters in an intuitive way. 

With the minikube installation k9s is also installed on the Vagrant machine. To run, after provisioning minikube run the following commands:
```bash
ssh vagrant
k9s
```
You should be greeted with the following in your terminal:
![k9s](images/k9s_screenshot1.png?raw=true "k9s")

Press "0" to display all namespaces. 
![k9s_2](images/k9s_screenshot2.png?raw=true "k9s_2")
### Helpful k9s tips
- Press ":" to bring up command prompt. You can enter commands to change screens. e.g. "deployments" takes you to list of deployments.
- You can navigate around with arrow keys then press buttons as listed in the top right to interact with the highlighted item. e.g "l" to show logs of selected pod. 
- For full instructions and preview video see the k9s website: https://k9scli.io/

## Traefik on Minikube
https://doc.traefik.io/traefik/v1.7/user-guide/kubernetes/ <br />
Traefik Dashboard: http://localhost:18181/dashboard/<br />
Traefik Loadbalancer: http://localhost:18080<br />
Traefik Documentation: http://localhost:3333/#/minikube/README?id=traefik-on-minikube

![Traefik Logo](images/traefik-logo.png?raw=true "Traefik Logo")

This guide explains how to use Traefik as an Ingress controller for a Kubernetes cluster.

![Traefik on Minikube](images/minikube-traefik-dashboard.png?raw=true "Traefik on Minikube")

## Minikube Vagrant Provisioner

[filename](minikube.sh ':include :type=code')