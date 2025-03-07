# Database Credentials with HashiCorp Vault

<div align="center">
  <p><strong>Dynamic database credentials provisioning and lifecycle management</strong></p>
</div>

## 🚀 About

In this HashiQube DevOps lab, you'll get hands-on experience with HashiCorp Vault's database secrets engine. Learn how Vault can securely provision and manage credentials for your databases, eliminating the need for static credentials and enhancing your security posture.

This lab will guide you through integrating three popular database systems with HashiCorp Vault:

- Oracle MySQL
- Microsoft SQL Server
- PostgreSQL

## 📚 Database Engines

<details>
<summary><h3>🔵 Oracle MySQL</h3></summary>

<div align="center">
  <img src="images/mysql-logo.png" alt="MySQL Logo" width="300px">
</div>

### Provision MySQL

<!-- tabs:start -->

### **Github Codespace**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash vault/vault.sh
bash database/mysql.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docker,docsify,vault,mysql
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash vault/vault.sh
bash database/mysql.sh
```
<!-- tabs:end -->

### Verifying MySQL Installation

Let's verify that our MySQL container is up and accepting connections:

```bash
vagrant ssh -c "mysql -h 127.0.0.1 -u root -ppassword -e \"show databases;\""
```

Output:

```sql
mysql: [Warning] Using a password on the command line interface can be insecure.
+--------------------+
| Database           |
+--------------------+
| db                 |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+

```

### Configuring Vault with MySQL

1. **Start Vault**

   ```bash
   vagrant up --provision-with basetools,docker,docsify,vault
   ```

2. **Unseal Vault and Login**

   Use the unseal keys and root token provided in the output to unseal Vault and log in.

   <div align="center">
     <img src="images/vault_logged_in.png" alt="Vault Logged In" width="80%">
     <p><em>Vault UI after successful login</em></p>
   </div>

3. **Enable the Database Secrets Engine**

   Navigate to "Enable new Engine" in the top right, select "Database" and click "Next".

   <div align="center">
     <img src="images/vault_enable_new_secret_engine_database.png" alt="Enable Database Engine" width="80%">
     <p><em>Select the Database secrets engine</em></p>
   </div>

   <div align="center">
     <img src="images/vault_enable_new_secret_engine_database_enable.png" alt="Confirm Database Engine" width="80%">
     <p><em>Confirm and enable the Database secrets engine</em></p>
   </div>

4. **Create Vault User in MySQL**

   ```bash
   vagrant ssh -c "mysql -h 127.0.0.1 -u root -ppassword -e \"CREATE USER 'vault'@'%' IDENTIFIED BY 'password';\""
   
   vagrant ssh -c "mysql -h 127.0.0.1 -u root -ppassword -e \"GRANT ALL PRIVILEGES ON *.* TO 'vault'@'%' WITH GRANT OPTION;\""
   
   vagrant ssh -c "mysql -h 127.0.0.1 -u root -ppassword -e \"GRANT CREATE USER ON *.* to 'vault'@'%';\""
   ```

5. **Configure MySQL in Vault**

   ```bash
   vagrant ssh -c "vault write database/config/db plugin_name=mysql-database-plugin connection_url='{{username}}:{{password}}@tcp(localhost:3306)/' allowed_roles='mysql-role' username='vault' password='password'"
   ```

6. **Create a Database Role**

   ```bash
   vagrant ssh -c "vault write database/roles/mysql-role db_name=db creation_statements=\"CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT ALL PRIVILEGES ON db.* TO '{{name}}'@'%';\" default_ttl='1h' max_ttl='24h'"
   ```

   Output:

   ```sql
   Success! Data written to: database/roles/mysql-role
   ```

### Generating and Using Dynamic Credentials

1. **Check Current MySQL Users**

   ```bash
   vagrant ssh -c "mysql -h 127.0.0.1 -u root -ppassword -e \"SELECT User, Host from mysql.user;\""
   ```

   Output:

   ```sql
   mysql: [Warning] Using a password on the command line interface can be insecure.
   +------------------+-----------+
   | User             | Host      |
   +------------------+-----------+
   | root             | %         |
   | vault            | %         |
   | mysql.infoschema | localhost |
   | mysql.session    | localhost |
   | mysql.sys        | localhost |
   | root             | localhost |
   +------------------+-----------+
   ```

2. **Generate Credentials from Vault**

   ```bash
   vagrant ssh -c "vault read database/creds/mysql-role"
   ```

   Output:

   ```sql
   Key                Value
   ---                -----
   lease_id           database/creds/mysql-role/IhHPq0RcdmDdTIjsfLBePLcp
   lease_duration     1h
   lease_renewable    true
   password           A1a-0bdhOg0OiZQV0TTP
   username           v-root-mysqlrole-zV7t3V0bJFZZJTg
   ```

3. **Verify New User Existence**

   ```bash
   vagrant ssh -c "mysql -h 127.0.0.1 -u root -ppassword -e \"SELECT User, Host from mysql.user;\""
   ```

   Output:

   ```sql
   mysql: [Warning] Using a password on the command line interface can be insecure.
   +-----------------------------------+-----------+
   | User                              | Host      |
   +-----------------------------------+-----------+
   | root                              | %         |
   | v-root-mysql-role-zV7t3V0bJFZZJTg | %         |
   | vault                             | %         |
   | mysql.infoschema                  | localhost |
   | mysql.session                     | localhost |
   | mysql.sys                         | localhost |
   | root                              | localhost |
   +-----------------------------------+-----------+
   ```

4. **Retrieve Credentials via API**

   ```bash
   vagrant ssh -c "curl --header 'X-Vault-Token:s.h7kojucmDDULDmxHAyr7jhrE' http://localhost:8200/v1/database/creds/mysql-role"
   ```

   Output:

   ```json
   {
   "request_id":"23116091-f72b-80f9-fb0e-6ce5418bae1d",
   "lease_id":"database/creds/mysql-role/7wMxCUzNcEaOrvCspBhXnjTM",
   "renewable":true,
   "lease_duration":3600,
   "data":{
     "password":"A1a-XhNU8s4P0Ph5Se9O",
     "username":"v-root-mysql-role-kmFADTyAAfv7LS0"
   },
   "wrap_info":null,
   "warnings":null,
   "auth":null
   }
   ```

5. **Using Credentials in Applications**

   ```bash
   response=$(curl --header "X-Vault-Token:s.h7kojucmDDULDmxHAyr7jhrE" http://localhost:8200/v1/database/creds/mysql-role)
   export DBPASSWORD=$(echo $response | jq -r .data.password)
   export DBUSERNAME=$(echo $response | jq -r .data.username)

   docker run --name webapp -d -p 8080:80 --rm -e DATABASE_URL=mysql+pymysql://DBUSERNAME:DBPASSWORD@mysql.consul/db webapp:latest
   ```

6. **Credential Lifecycle Management**

   After the lease expires (1 hour in our configuration), Vault automatically revokes the credentials:

   ```bash
   vagrant ssh -c "mysql -h 127.0.0.1 -u root -ppassword -e \"SELECT User, Host from mysql.user;\""
   ```

   Output after credential expiration:

   ```sql
   mysql: [Warning] Using a password on the command line interface can be insecure.
   +------------------+-----------+
   | User             | Host      |
   +------------------+-----------+
   | root             | %         |
   | vault            | %         |
   | mysql.infoschema | localhost |
   | mysql.session    | localhost |
   | mysql.sys        | localhost |
   | root             | localhost |
   +------------------+-----------+
   ```

### MySQL Provisioner Script

The script below automates the setup of MySQL in your HashiQube environment:

[filename](mysql.sh ':include :type=code')

</details>

<details>
<summary><h3>🔴 Microsoft SQL Server</h3></summary>

<div align="center">
  <img src="images/mssql-logo.png" alt="Microsoft SQL Logo" width="300px">
</div>

### Provision Microsoft SQL Server

<!-- tabs:start -->
#### **GitHub Codespaces**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash vault/vault.sh
bash database/mssql.sh
```

#### **Vagrant**

```bash
vagrant up --provision-with basetools,docker,docsify,vault,mssql
```

#### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash vault/vault.sh
bash database/mssql.sh
```
<!-- tabs:end -->

### Configuring Microsoft SQL Server with Vault

1. **Create a Database**

   ```bash
   vagrant ssh
   docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P P@ssw0rd -Q "CREATE DATABASE mssql"
   ```

2. **Verify Database Creation**

   ```bash
   docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P P@ssw0rd -Q "SELECT name, database_id, create_date FROM sys.databases"
   ```

   Output:

   ```
   name                                                                                                                             database_id create_date
   -------------------------------------------------------------------------------------------------------------------------------- ----------- -----------------------
   master                                                                                                                                     1 2003-04-08 09:13:36.390
   tempdb                                                                                                                                     2 2019-11-20 03:23:54.157
   model                                                                                                                                      3 2003-04-08 09:13:36.390
   msdb                                                                                                                                       4 2018-06-13 18:27:29.220
   mssql                                                                                                                                      5 2019-11-20 03:24:03.043

   (5 rows affected)
   ```

3. **Enable Database Secrets Engine in Vault** (if not already enabled)

   ```bash
   vault secrets enable database
   ```

4. **Configure MSSQL in Vault**

   ```bash
   vault write database/config/mssql \
     plugin_name=mssql-database-plugin \
     connection_url='sqlserver://{{username}}:{{password}}@localhost:1433' \
     allowed_roles="mssql" \
     username="sa" \
     password="P@ssw0rd"
   ```

5. **Create a Database Role**

   ```bash
   vault write database/roles/mssql \
     db_name=mssql \
     creation_statements="CREATE LOGIN [{{name}}] WITH PASSWORD = '{{password}}'; \
     CREATE USER [{{name}}] FOR LOGIN [{{name}}]; \
     GRANT SELECT ON SCHEMA::dbo TO [{{name}}];" \
     default_ttl="1h" \
     max_ttl="24h"
   ```

### Generating and Using Dynamic Credentials

1. **Generate Credentials from Vault**

   ```bash
   vault read database/creds/mssql
   ```

2. **Verify Credential Creation**

   ```bash
   docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U v-root-mssql-5nBk5IA9hydRgzOkgB8M-1574220338 -P A1a-dninssZ6v3mNBOfK -Q "SELECT * FROM sys.server_principals"
   ```

3. **Credential Lifecycle Management**

   After the lease expires (1 hour in our configuration), attempting to use the credentials will fail:

   ```bash
   docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U v-root-mssql-5nBk5IA9hydRgzOkgB8M-1574220338 -P A1a-dninssZ6v3mNBOfK -Q "SELECT * FROM sys.server_principals"
   ```

   Output after credential expiration:

   ```sql
   Sqlcmd: Error: Microsoft ODBC Driver 17 for SQL Server : Login failed for user 'v-root-mssql-5nBk5IA9hydRgzOkgB8M-1574220338'..
   ```

### Microsoft SQL Server Provisioner Script

The script below automates the setup of Microsoft SQL Server in your HashiQube environment:

[filename](mssql.sh ':include :type=code')

</details>

<details>
<summary><h3>🟢 PostgreSQL</h3></summary>

<div align="center">
  <img src="images/postgresql-logo.png" alt="PostgreSQL Logo" width="300px">
</div>

### Provision PostgreSQL

<!-- tabs:start -->
#### **GitHub Codespaces**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash vault/vault.sh
bash database/postgresql.sh
```

#### **Vagrant**

```bash
vagrant up --provision-with basetools,docker,docsify,vault,postgresql
```

#### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash vault/vault.sh
bash database/postgresql.sh
```
<!-- tabs:end -->

### PostgreSQL Provisioner Script

The script below automates the setup of PostgreSQL in your HashiQube environment:

[filename](postgresql.sh ':include :type=code')

</details>

## 🔑 Key Benefits

1. **Enhanced Security** - Eliminate static, long-lived credentials that can be compromised
2. **Automatic Rotation** - Credentials are automatically rotated based on configured TTLs
3. **Fine-grained Access Control** - Create specific roles with limited permissions
4. **Audit Trail** - Track who accessed which credentials and when
5. **Simplified Credential Management** - Centralized management of all database credentials
6. **Reduced Operational Overhead** - No need to manually rotate credentials or manage password reset schedules

## 🔍 How It Works

1. Vault is configured with connection details to the database, using a privileged account that can create users
2. When an application needs database access, it authenticates to Vault and requests credentials
3. Vault creates a unique set of credentials with the requested permissions and returns them to the application
4. The credentials have a time-to-live (TTL) setting, after which Vault automatically revokes them
5. If needed, the application can renew the credentials before they expire

## 🛠️ Additional Use Cases

- **CI/CD Pipelines** - Provide temporary credentials for database migrations and tests
- **Microservices** - Each service gets its own set of credentials with minimal required permissions
- **Development Environments** - Easily create and manage credentials for developers without sharing access
- **Cross-environment Consistency** - Use the same workflow in development, staging, and production

## 📚 Further Reading

- [HashiCorp Vault Database Secrets Engine](https://www.vaultproject.io/docs/secrets/databases)
- [Dynamic Secrets: Database Credentials Rotation](https://learn.hashicorp.com/tutorials/vault/database-credentials-rotation)
- [Database Root Credential Rotation](https://learn.hashicorp.com/tutorials/vault/database-root-rotation)

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')