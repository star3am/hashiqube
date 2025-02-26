# Apache Airflow

<div align="center">
  <img src="images/airflow-logo.png" alt="Apache Airflow Logo" width="300px">
  <br><br>
  <p><strong>A platform to programmatically author, schedule and monitor workflows</strong></p>
</div>

## 🚀 About

In this HashiQube DevOps lab, you'll get hands-on experience with Apache Airflow. You'll learn how to:

- Install Airflow with Helm charts
- Run Airflow on Kubernetes using Minikube
- Configure Airflow connections
- Create a Python DAG that runs DBT

This lab provides an incredible learning opportunity to understand how Airflow can orchestrate your data pipelines. Be sure to check out the DBT section as well!

## 📋 Provision

<!-- tabs:start -->

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash database/postgresql.sh
bash minikube/minikube.sh
bash dbt/dbt.sh
bash apache-airflow/apache-airflow.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docker,docsify,postgresql,minikube,dbt,apache-airflow
```

### **Docker Compose**

```bash
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

## 🔑 Web UI Access

To access the Airflow web UI:

- **URL**: <http://localhost:18889>
- **Default Login**:

  ```bash
  Username: admin
  Password: admin
  ```

## 🧩 Architecture

Airflow is deployed on Minikube (Kubernetes) using Helm, with custom configurations provided in the `values.yaml` file. The architecture includes:

- Airflow scheduler running in a Kubernetes pod
- Example DAGs mounted into the scheduler pod
- PostgreSQL database for Airflow metadata

## 📊 Example DAGs

In the `dags` folder, you'll find two example DAGs:

1. **example-dag.py**
   - Runs DBT commands using the SSHOperator
   - Connects to Hashiqube via SSH to execute data transformation tasks

2. **test-ssh.py**
   - A simple DAG that tests the SSH connection to Hashiqube
   - Useful for verifying connectivity before running more complex workflows

## 📸 Airflow Dashboard

<div align="center">
  <img src="images/airflow_dags.png" alt="Airflow DAGs" width="85%">
  <p><em>DAGs list in the Airflow UI</em></p>
</div>

<div align="center">
  <img src="images/airflow_connections.png" alt="Airflow Connections" width="85%">
  <p><em>Configured connections in Airflow</em></p>
</div>

<div align="center">
  <img src="images/airflow_dag_run_dbt.png" alt="Airflow DAG Execution" width="85%">
  <p><em>Execution graph of a DBT DAG run</em></p>
</div>

<div align="center">
  <img src="images/airflow_task_instance.png" alt="Airflow Task Instance" width="85%">
  <p><em>Task instance details</em></p>
</div>

<div align="center">
  <img src="images/airflow_task_result.png" alt="Airflow Task Result" width="85%">
  <p><em>Task execution results</em></p>
</div>

## 🔍 Code Examples

### Provisioner Script

The following script automates the Airflow deployment:

```bash
#!/bin/bash

# Print the commands that are run
set -x

# Stop execution if something fails
# set -e

# This script installs Airflow on minikube
# https://github.com/hashicorp/vagrant/issues/8878
# https://github.com/apache/airflow
# https://airflow.apache.org/docs/helm-chart/stable/index.html

# ... rest of provisioner script
```

### Example DAG

Here's a sample DAG that runs DBT tasks:

```python
"""
This DAG runs dbt models on Hashiqube
"""
import os
from datetime import datetime, timedelta

from airflow import DAG
from airflow.contrib.operators.ssh_operator import SSHOperator
from airflow.operators.dummy_operator import DummyOperator

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email': ['airflow@example.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# ... rest of DAG code
```

## 🔗 Additional Resources

- [Apache Airflow Official Website](https://airflow.apache.org/)
- [Airflow Helm Chart on Artifact Hub](https://artifacthub.io/packages/helm/airflow-helm/airflow/8.3.1)
- [Airflow Helm Chart Documentation](https://airflow.apache.org/docs/helm-chart/stable/index.html)
- [Adding Connections and Variables](https://airflow.apache.org/docs/helm-chart/stable/adding-connections-and-variables.html)
- [Airflow 1.10.2 Documentation (PDF)](https://airflow.readthedocs.io/_/downloads/en/1.10.2/pdf/)
- [Helm Chart Parameters Reference](https://airflow.apache.org/docs/helm-chart/stable/parameters-ref.html)
