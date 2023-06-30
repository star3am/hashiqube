# Prometheus and Grafana

We need a monitoring and alerting solution. For this we have chosen to use Prometheus and Grafana
## Grafana
https://grafana.com/
Grafana is a multi-platform open source analytics and interactive visualization web application. It provides charts, graphs, and alerts for the web when connected to supported data sources.

![Grafana](images/grafana-logo.png?raw=true "Grafana")

## Prometheus
Prometheus is an open source monitoring system for which Grafana provides out-of-the-box support. This topic walks you through the steps to create a series of dashboards in Grafana to display system metrics for a server monitored by Prometheus.

![Prometheus](images/prometheus-logo.png?raw=true "Prometheus")

## Provision

In order to provision Prometheus and Grafana, you need bastetools, docker, minikube as dependencies. 

:bulb: We enable Vault, because we monitor it with Prometheus and we enable Minikube because we host Grafana and Prometheus on Minikkube using Helm

`vagrant up --provision-with basetools,docker,vault,minikube,prometheus-grafana`

Prometheus http://localhost:9090 <br />
Alertmanager http://localhost:9093 <br />
Grafana http://localhost:3000 and login with Username: admin Password: Password displayed in the Terminal

Look at Minikube dashboard for progress update and the terminal output. 
```
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
hashiqube0.service.consul: 5m23s       Warning   SystemOOM                                          node/minikube                                        System OOM encountered, victim process: prometheus, pid: 2375725
hashiqube0.service.consul: 5m23s       Warning   SystemOOM                                          node/minikube                                        System OOM encountered, victim process: prometheus, pid: 2385107
hashiqube0.service.consul: 5m23s       Warning   SystemOOM                                          node/minikube                                        System OOM encountered, victim process: prometheus, pid: 2394543
hashiqube0.service.consul: 5m22s       Normal    NodeHasSufficientMemory                            node/minikube                                        Node minikube status is now: NodeHasSufficientMemory
hashiqube0.service.consul: The easiest way to access this service is to let kubectl to forward the port:
hashiqube0.service.consul: kubectl port-forward service/prometheus-server-np 9090:9090
hashiqube0.service.consul: vagrant  1198180  0.4  0.3 751844 42116 ?        Sl   22:25   0:01 kubectl port-forward -n kubernetes-dashboard service/kubernetes-dashboard 10888:80 --address=0.0.0.0
hashiqube0.service.consul: vagrant  1198888  0.2  0.3 751588 41420 ?        Sl   22:26   0:00 kubectl port-forward -n default service/hello-minikube 18888:8080 --address=0.0.0.0
hashiqube0.service.consul: ++++ Prometheus http://localhost:9090
hashiqube0.service.consul: ++++ Grafana http://localhost:3000 and login with Username: admin Password:
hashiqube0.service.consul: N6as3Odq7bprqVdvWV5iFmwhOLs8QvutCJb8f2lS
hashiqube0.service.consul: ++++ You should now be able to access Prometheus http://localhost:9090 and Grafana http://localhost:3000 Please login to Grafana and add Prometheus as a Datasource, next please click on the + symbol in Grafana and import 6417 dashboard.
```

![Minikube Dashboard Pods](images/minikube-dashboard-pods.png?raw=true "Minikube Dashboard Pods")

You can also open Prometheus web interface and look at Status -> Targets

![Prometheus Targets](images/prometheus.png?raw=true "Prometheus Targets")

To use Prometheus as a Datasource in Grafana, we need to add it so let's do that now, please head over to Grafana on http://localhost:3000 and login with user: `admin` and the password: `TOKEN_IN_TERMINAL_OUTPUT` 

![Grafana Login](images/grafana.png?raw=true "Grafana Login")

Click on Configuration -> Datasources 

Click add Data sources
Select Prometheus and enter the URL of Prometheus, in this case we will use http://10.9.99.10:9090

![Grafana Configuration Datasources](images/prometheus.png?raw=true "Grafana Configuration Datasources")

Lastly we can import a dashboard, lick on the `+` in the left menue and select `Import` now enter `6417` and click import 

![Grafana Import Dashboard 6417](images/grafana_import_dashboard_6417.png?raw=true "Grafana Import Dashboard 6417")

and you should be able to see some graphs. 

![Grafana Dashboard Kubernetes Cluster (Prometheus)](images/grafana_dashboard_6417.png?raw=true "Grafana Dashboard Kubernetes Cluster (Prometheus)")

## Monitoring Hashicorp Vault

https://developer.hashicorp.com/vault/docs/configuration/telemetry#prometheus <br />
https://developer.hashicorp.com/vault/docs/configuration/telemetry

In hashicorp/vault.sh we enabled Telemetry in the Vault config file see `hashicorp/vault.sh`

```hcl
# https://developer.hashicorp.com/vault/docs/configuration/telemetry
# https://developer.hashicorp.com/vault/docs/configuration/telemetry#prometheus
telemetry {
  disable_hostname = true
  prometheus_retention_time = "12h"
}
```

When we install Prometheus with Helm we set a values.yaml file that specify an `extraScrapeConfigs` You guessed it! Vault...

`helm install prometheus prometheus-community/prometheus -f /vagrant/prometheus-grafana/values.yaml`

[filename](values.yaml ':include :type=code')

You should now see the Vault target in Prometheus web interface at http://localhost:9090/targets

![Prometheus Vault Target](images/prometheus-targets-vault.png?raw=true "Prometheus Vault Target")

We now need to Grafana Datasource of Type Prometheus based on this Target

Please navigate to http://localhost:3000/connections/your-connections/datasources

And add a Vault Datasource

Name: Vault
URL: http://10.9.99.10:9090

![Grafana Datasource Prometheus Vault](images/grafana-datasource-prometheus-vault.png?raw=true "Grafana Datasource Prometheus Vault")

Now, let's import the Vault Grafana Dashboard, to do that, click on the top right + and select `Import Dashboard` ref: https://grafana.com/grafana/dashboards/12904-hashicorp-vault/

![Grafana Import Dashboard Vault 12904](images/grafana-import-dashboard-vault-12904.png?raw=true "Grafana Import Dashboard Vault 12904")

Enter `12904` and click on Load

![Grafana Import Dashboard Vault 12904 Load](images/grafana-import-dashboard-vault-12904-load.png?raw=true "Grafana Import Dashboard Vault 12904 Load")

Navigating to Grafana -> Dashboards you should now be able to see the Hashicorp Vault Grafana Dashboard

![Grafana Hashicorp Vault Dashboard](images/grafana-hashicorp-vault-dashboard.png?raw=true "Grafana Hashicorp Vault Dashboard")

## Prometheus Grafana Vagrant Provisioner 

[filename](prometheus-grafana.sh ':include :type=code')
