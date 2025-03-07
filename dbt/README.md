# dbt - Data Build Tool

<div align="center">
  <img src="images/dbt-logo.png" alt="DBT Logo" width="300px">
  <br><br>
  <p><strong>Transform, test, and document data in your warehouse</strong></p>
</div>

## 🚀 About

In this HashiQube DevOps lab, you'll get hands-on experience with dbt (Data Build Tool) - a transformation tool that enables data analysts and engineers to transform, test, and document data in cloud data warehouses.

<div align="center">
  <img src="https://www.getdbt.com/ui/img/png/analytics-engineering-dbt.png" alt="Analytics Engineering with dbt" width="85%">
  <p><em>The modern analytics engineering workflow powered by dbt</em></p>
</div>

## 📋 Getting Started

Before provisioning, review the dbt and adapter versions located in [common.sh](./common.sh).

You can control which adapter and version you want to install with dbt by changing the `DBT_WITH` variable to one of these values:

```bash
DBT_WITH=postgres

# AVAILABLE OPTIONS:
# postgres    - PostgreSQL adapter
# redshift    - Amazon Redshift adapter
# bigquery    - Google BigQuery adapter
# snowflake   - Snowflake adapter
# mssql       - SQL Server and Synapse adapter
# spark       - Apache Spark adapter
# all         - Install all adapters (excluding mssql)
```

## 📥 Provision

<!-- tabs:start -->

### **Github Codespace**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash database/postgresql.sh
bash dbt/dbt.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docsify,docker,postgresql,dbt
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash database/postgresql.sh
bash dbt/dbt.sh
```
<!-- tabs:end -->

## 🧪 dbt Labs Example Project

The provisioner automatically sets up the [Jaffle Shop](https://github.com/dbt-labs/jaffle_shop) example project from dbt Labs.

### Running the Example

1. Run the Provision step above.

2. The example project from <https://github.com/dbt-labs/jaffle_shop> is already cloned into `/vagrant/dbt/jaffle_shop`.

3. Enter the HashiQube environment:

   ```bash
   vagrant ssh
   ```

4. Navigate to the example project:

   ```bash
   cd /vagrant/dbt/jaffle_shop
   ```

5. Explore the project structure and follow the tutorial at <https://github.com/dbt-labs/jaffle_shop#running-this-project>.

## 💻 Using Your Own dbt Project

1. Enter HashiQube SSH session:

   ```bash
   vagrant ssh
   ```

2. If you have an existing dbt project under your home directory, you can access it via the `/osdata` volume, which is mapped to your home directory.

3. Update your `profiles.yml` with the correct credentials for your target database.

4. Test your connection:

   ```bash
   dbt debug
   ```

5. Run your dbt project:

   ```bash
   dbt run
   ```

## 🖥️ Web UI Access

Once provisioning is complete, you can access the dbt web interface:

- **URL**: <http://localhost:28080/>

<div align="center">
  <img src="images/dbt_project.png" alt="DBT Project View" width="85%">
  <p><em>dbt project view showing models and structure</em></p>
</div>

<div align="center">
  <img src="images/dbt_database.png" alt="DBT Database View" width="85%">
  <p><em>dbt database view showing tables and schemas</em></p>
</div>

<div align="center">
  <img src="images/dbt_lineage_graph.png" alt="DBT Lineage Graph" width="85%">
  <p><em>dbt lineage graph showing data transformation dependencies</em></p>
</div>

## 🔌 Supported Database Adapters

dbt supports multiple database adapters, allowing you to connect to various data warehouses.

### MSSQL and Synapse

These adapters require a specific version of dbt:

```log
Core:
  - installed: 1.1.0
  - latest:    1.2.1 - Update available!

Plugins:
  - postgres:  1.1.0 - Update available!
  - synapse:   1.1.0 - Up to date!
  - sqlserver: 1.1.0 - Up to date!
```

### Other Adapters

When using other adapters, you'll see something like:

```log
Core:
  - installed: 1.2.1
  - latest:    1.2.1 - Up to date!

Plugins:
  - spark:     1.2.0 - Up to date!
  - postgres:  1.2.1 - Up to date!
  - snowflake: 1.2.0 - Up to date!
  - redshift:  1.2.1 - Up to date!
  - bigquery:  1.2.0 - Up to date!
```

## 💡 Performance Tips

As your dbt project grows, `dbt run` and `dbt test` commands can become time-consuming. Here are some optimization strategies:

### Using Deferred Execution

Store artifacts to reuse in future runs:

```bash
# Run only new or modified models
dbt run --select [...] --defer --state path/to/artifacts

# Test only new or modified models
dbt test --select [...] --defer --state path/to/artifacts
```

This approach:

- Executes only what's new or changed in your code
- Reuses previously compiled artifacts
- Significantly reduces execution time for large projects
- Is perfect for CI/CD pipelines and pull request validation

## 🔧 Provisioner Scripts

The dbt environment is set up using these scripts:

### common.sh

[filename](common.sh ':include :type=code')

### dbt-global.sh

[filename](dbt-global.sh ':include :type=code')

## 🔗 Additional Resources

- [dbt Official Website](https://www.getdbt.com/)
- [dbt Documentation](https://docs.getdbt.com/)
- [dbt Slack Community](https://www.getdbt.com/community/join-the-community/)
- [dbt GitHub Repository](https://github.com/dbt-labs/dbt-core)
- [Analytics Engineering Guide](https://www.getdbt.com/analytics-engineering/)

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')