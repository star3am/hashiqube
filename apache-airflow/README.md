# Apache Airflow

In this HashiQube DevOps lab you will get hands on experience with Apache Airflow. Mot only that but you will learn how to install Airflow with Helm charts and run it on Kubernetes using Minikube. 

We will configure Airflow, and create a DAG in Python that runs DBT. That's incredible learnings! 

Be sure to checkout the DBT section as well and have fun1 

Airflow is a platform created by the community to programmatically author, schedule and monitor workflows

![Airflow](images/airflow-logo.png?raw=true "Airflow")

## Provision

<!-- tabs:start -->
#### **Github Codespaces**

```
bash hashiqube/basetools.sh
bash docker/docker.sh
bash database/postgresql.sh
bash minikube/minikube.sh
bash dbt/dbt.sh
bash apache-airflow/apache-airflow.sh
```

#### **Vagrant**

```
vagrant up --provision-with basetools,docker,docsify,postgresql,minikube,dbt,apache-airflow
```

#### **Docker Compose**

```
docker compose exec hashiqube /bin/bash
bash bashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash database/postgresql.sh
bash minikube/minikube.sh
bash dbt/dbt.sh
bash apache-airflow/apache-airflow.sh
```
<!-- tabs:end -->

## Web UI Access

To access the web UI visit http://localhost:18889. 
Default login is:
```
Username: admin
Password: admin
```

# Further Info
Airflow is deployed on Minikube (Kubernetes) using Helm, and additional values are supplied in the values.yaml file.

Example DAGs are supplied in the dags folder and they are mounted into the airflow scheduler pod, see the details in the values.yaml file
 
# Airflow Information
In the dags folder you will find 2 dags
- example-dag.py
- test-ssh.py

The `example-dag.py` runs dbt commands by using the SSHOperator and ssh'ing into Hashiqube. 
The `test-ssh.py` just ssh into hashiqube to test the connection

# Airflow DAGs
![Airflow](images/airflow_dags.png?raw=true "Airflow")

# Airflow Connections
![Airflow](images/airflow_connections.png?raw=true "Airflow")

# Airflow DAG run
![Airflow](images/airflow_dag_run_dbt.png?raw=true "Airflow")

# Airflow Task
![Airflow](images/airflow_task_instance.png?raw=true "Airflow")

# Airflow Task Result
![Airflow](images/airflow_task_result.png?raw=true "Airflow")

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')

# Links

- https://airflow.apache.org/
- https://artifacthub.io/packages/helm/airflow-helm/airflow/8.3.1
- https://airflow.apache.org/docs/helm-chart/stable/index.html
- https://airflow.apache.org/docs/helm-chart/stable/adding-connections-and-variables.html
- https://airflow.readthedocs.io/_/downloads/en/1.10.2/pdf/
- https://airflow.apache.org/docs/helm-chart/stable/parameters-ref.html

## Provisioner

[filename](apache-airflow.sh ':include :type=code')

## DAG

[filename](dags/run-dbt.py ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')