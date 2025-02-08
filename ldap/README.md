# LDAP
https://www.vaultproject.io/docs/auth/ldap.html

![LDAP Logo](images/ldap-logo.png?raw=true "LDAP Logo")

LDAP stands for Lightweight Directory Access Protocol. As the name suggests, it is a lightweight client-server protocol for accessing directory services, specifically X. 500-based directory services. LDAP runs over TCP/IP or other connection oriented transfer services.

## Provision

<!-- tabs:start -->
#### **Github Codespaces**
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)
```
bash docker/docker.sh
bash ldap/ldap.sh
bash vault/vault.sh
```

#### **Vagrant**

```
vagrant up --provision-with basetools,docker,docsify,ldap,vault
```

#### **Docker Compose**

```
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash ldap/ldap.sh
bash vault/vault.sh
```
<!-- tabs:end -->

## Enable LDAP Auth in Vault

`vault auth enable ldap`
```log
Success! Enabled ldap auth method at: ldap/
```

`vault write auth/ldap/config url="ldap://localhost:389" userdn="ou=people,dc=planetexpress,dc=com" groupdn="ou=people,dc=planetexpress,dc=com" groupattr="cn" insecure_tls=true userattr=uid starttls=false binddn="cn=admin,dc=planetexpress,dc=com" bindpass='GoodNewsEveryone'`
```log
Success! Data written to: auth/ldap/config
```

`vault login -method=ldap username=hermes`
```log
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

## Ldap Vault Vagrant Provisioner

[filename](ldap.sh ':include :type=code')