# LDAP

<div align="center">
  <img src="images/ldap-logo.png" alt="LDAP Logo" width="300px">
  <br><br>
  <p><strong>Lightweight Directory Access Protocol for directory services</strong></p>
</div>

## 🚀 About

LDAP (Lightweight Directory Access Protocol) is a client-server protocol for accessing and maintaining distributed directory information services over an IP network. As the name suggests, it is a lightweight protocol for accessing directory services, specifically X.500-based directory services.

In this HashiQube DevOps lab, you'll set up an LDAP server and integrate it with HashiCorp Vault for authentication.

## 📋 Provision

<!-- tabs:start -->

### **Github Codespace**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash ldap/ldap.sh
bash vault/vault.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docker,docsify,ldap,vault
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash ldap/ldap.sh
bash vault/vault.sh
```

<!-- tabs:end -->

## 🔐 Integrating LDAP with Vault

Once you have provisioned LDAP and Vault, you can configure Vault to use LDAP for authentication. This allows users to log in to Vault using their LDAP credentials.

### Step 1: Enable LDAP Auth Method in Vault

```bash
vault auth enable ldap
```

Output:

```bash
Success! Enabled ldap auth method at: ldap/
```

### Step 2: Configure LDAP Auth Method

Configure Vault to connect to your LDAP server:

```bash
vault write auth/ldap/config \
  url="ldap://localhost:389" \
  userdn="ou=people,dc=planetexpress,dc=com" \
  groupdn="ou=people,dc=planetexpress,dc=com" \
  groupattr="cn" \
  insecure_tls=true \
  userattr=uid \
  starttls=false \
  binddn="cn=admin,dc=planetexpress,dc=com" \
  bindpass='GoodNewsEveryone'
```

Output:

```bash
Success! Data written to: auth/ldap/config
```

### Step 3: Login Using LDAP Credentials

Now you can log in to Vault using LDAP credentials:

```bash
vault login -method=ldap username=hermes
```

You'll be prompted for a password. After entering it, you should see:

```bash
Password (will be hidden):
WARNING! The VAULT_TOKEN environment variable is set! This takes precedence
over the value set by this command. To use the value set by this command,
unset the VAULT_TOKEN environment variable or set it to the token displayed
below.

Success! You are now authenticated. The token information displayed below
is already stored in the token helper. You do NOT need to run "vault login"
again. Future Vault requests will automatically use this token.

Key                    Value
---                    -----
token                  s.dbcrQVvhuT1RNQiK3FMFiNZe
token_accessor         wNdDBVDTEj3AfAfxypJELiGD
token_duration         10h
token_renewable        true
token_policies         ["default"]
identity_policies      []
policies               ["default"]
token_meta_username    hermes
```

## 🧩 Key LDAP Components

- **Directory**: A hierarchical database that stores information about objects
- **Entries**: Basic unit of data in LDAP, represented as an object
- **Attributes**: Properties of entries, like username, password, etc.
- **Distinguished Name (DN)**: Unique identifier for an entry
- **Binding**: Process of authenticating to the LDAP server

## 🔍 LDAP Structure in This Lab

The LDAP server in this lab is configured with a Planet Express (from Futurama) theme:

- **Base DN**: `dc=planetexpress,dc=com`
- **Admin User**: `cn=admin,dc=planetexpress,dc=com`
- **Admin Password**: `GoodNewsEveryone`
- **User OU**: `ou=people,dc=planetexpress,dc=com`
- **Sample Users**:
  - `uid=hermes,ou=people,dc=planetexpress,dc=com`
  - `uid=fry,ou=people,dc=planetexpress,dc=com`
  - `uid=bender,ou=people,dc=planetexpress,dc=com`

## 🛠️ LDAP Provisioner Script

The script below automates the setup of LDAP in your HashiQube environment:

[filename](ldap.sh ':include :type=code')

## 🔗 Additional Resources

- [HashiCorp Vault LDAP Auth Method](https://www.vaultproject.io/docs/auth/ldap.html)
- [OpenLDAP Documentation](https://www.openldap.org/doc/)
- [LDAP Wikipedia Article](https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol)
- [phpLDAPadmin Documentation](http://phpldapadmin.sourceforge.net/wiki/index.php/Main_Page)
- [Integrating LDAP with Vault](https://learn.hashicorp.com/tutorials/vault/ldap-auth)

## 💡 Common Use Cases

- **User Authentication**: Centralizing user authentication for multiple systems
- **Address Book**: Storing contact information for an organization
- **Single Sign-On (SSO)**: Enabling users to access multiple applications with one set of credentials
- **Authorization**: Determining what resources a user can access
- **Directory Services**: Storing and organizing information about resources on a network

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')