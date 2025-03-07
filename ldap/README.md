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

```bash
#!/bin/bash

# Print the commands that are run
set -x

# Stop execution if something fails
set -e

# This script provisions LDAP

HOSTIP=$(hostname -I | awk '{print $2}')
if [[ -z "$HOSTIP" ]]; then
  HOSTIP=$(hostname -I | awk '{print $1}')
fi

echo "Host IP: $HOSTIP"

# Check if OpenLDAP Docker container is already running
if [ "$(docker ps -q -f name=openldap)" ]; then
    echo "OpenLDAP container is already running"
else
    echo "Starting OpenLDAP container..."
    docker run \
        --name openldap \
        --hostname openldap-host \
        --detach \
        -p 389:389 \
        -p 636:636 \
        --env LDAP_ORGANISATION="Planet Express, Inc." \
        --env LDAP_DOMAIN="planetexpress.com" \
        --env LDAP_ADMIN_PASSWORD="GoodNewsEveryone" \
        --volume /tmp/ldap/var:/var/lib/ldap \
        --volume /tmp/ldap/etc:/etc/ldap/slapd.d \
        --volume /tmp/ldap/ldifs:/container/service/slapd/assets/config/bootstrap/ldif/custom \
        osixia/openldap:1.3.0

    # Wait for LDAP server to start
    sleep 10

    # Copy ldif files
    mkdir -p /tmp/ldap/ldifs
    cp /vagrant/ldap/bootstrap.ldif /tmp/ldap/ldifs/

    # Restart the container to apply changes
    docker restart openldap
    sleep 10
fi

# Check if phpLDAPadmin Docker container is already running
if [ "$(docker ps -q -f name=phpldapadmin)" ]; then
    echo "phpLDAPadmin container is already running"
else
    echo "Starting phpLDAPadmin container..."
    docker run \
        --name phpldapadmin \
        --hostname phpldapadmin-service \
        --link openldap:ldap-host \
        --detach \
        -p 8443:443 \
        --env PHPLDAPADMIN_LDAP_HOSTS=ldap-host \
        osixia/phpldapadmin:0.9.0

    # Wait for phpLDAPadmin to start
    sleep 5
fi

echo "LDAP server is running at: ldap://${HOSTIP}:389"
echo "phpLDAPadmin is running at: https://${HOSTIP}:8443"
echo "Login DN: cn=admin,dc=planetexpress,dc=com"
echo "Password: GoodNewsEveryone"

# Create bootstrap.ldif if it doesn't exist
if [ ! -f "/vagrant/ldap/bootstrap.ldif" ]; then
    mkdir -p /vagrant/ldap
    cat > /vagrant/ldap/bootstrap.ldif << 'EOF'
# Create top-level organization
dn: ou=people,dc=planetexpress,dc=com
objectClass: organizationalUnit
ou: people

# Create users
dn: uid=fry,ou=people,dc=planetexpress,dc=com
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: fry
sn: Fry
givenName: Philip
cn: Philip J. Fry
displayName: Philip J. Fry
uidNumber: 1000
gidNumber: 1000
userPassword: fry
gecos: Philip J. Fry
loginShell: /bin/bash
homeDirectory: /home/fry
shadowExpire: -1
shadowFlag: 0
shadowWarning: 7
shadowMin: 0
shadowMax: 99999
shadowLastChange: 10877
mail: fry@planetexpress.com
postalCode: 12345
l: New New York
o: Planet Express
mobile: +1 234 567 890
homePhone: +1 234 567 890
title: Delivery Boy
initials: PJF

dn: uid=bender,ou=people,dc=planetexpress,dc=com
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: bender
sn: Rodriguez
givenName: Bender
cn: Bender Bending Rodriguez
displayName: Bender Bending Rodriguez
uidNumber: 1001
gidNumber: 1001
userPassword: bender
gecos: Bender Bending Rodriguez
loginShell: /bin/bash
homeDirectory: /home/bender
shadowExpire: -1
shadowFlag: 0
shadowWarning: 7
shadowMin: 0
shadowMax: 99999
shadowLastChange: 10877
mail: bender@planetexpress.com
postalCode: 12345
l: New New York
o: Planet Express
mobile: +1 234 567 890
homePhone: +1 234 567 890
title: Robot
initials: BBR

dn: uid=leela,ou=people,dc=planetexpress,dc=com
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: leela
sn: Turanga
givenName: Leela
cn: Turanga Leela
displayName: Turanga Leela
uidNumber: 1002
gidNumber: 1002
userPassword: leela
gecos: Turanga Leela
loginShell: /bin/bash
homeDirectory: /home/leela
shadowExpire: -1
shadowFlag: 0
shadowWarning: 7
shadowMin: 0
shadowMax: 99999
shadowLastChange: 10877
mail: leela@planetexpress.com
postalCode: 12345
l: New New York
o: Planet Express
mobile: +1 234 567 890
homePhone: +1 234 567 890
title: Captain
initials: TL

dn: uid=zoidberg,ou=people,dc=planetexpress,dc=com
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: zoidberg
sn: Zoidberg
givenName: John
cn: John A. Zoidberg
displayName: John A. Zoidberg
uidNumber: 1003
gidNumber: 1003
userPassword: zoidberg
gecos: John A. Zoidberg
loginShell: /bin/bash
homeDirectory: /home/zoidberg
shadowExpire: -1
shadowFlag: 0
shadowWarning: 7
shadowMin: 0
shadowMax: 99999
shadowLastChange: 10877
mail: zoidberg@planetexpress.com
postalCode: 12345
l: New New York
o: Planet Express
mobile: +1 234 567 890
homePhone: +1 234 567 890
title: Doctor
initials: JAZ

dn: uid=amy,ou=people,dc=planetexpress,dc=com
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: amy
sn: Wong
givenName: Amy
cn: Amy Wong
displayName: Amy Wong
uidNumber: 1004
gidNumber: 1004
userPassword: amy
gecos: Amy Wong
loginShell: /bin/bash
homeDirectory: /home/amy
shadowExpire: -1
shadowFlag: 0
shadowWarning: 7
shadowMin: 0
shadowMax: 99999
shadowLastChange: 10877
mail: amy@planetexpress.com
postalCode: 12345
l: New New York
o: Planet Express
mobile: +1 234 567 890
homePhone: +1 234 567 890
title: Intern
initials: AW

dn: uid=hermes,ou=people,dc=planetexpress,dc=com
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: hermes
sn: Conrad
givenName: Hermes
cn: Hermes Conrad
displayName: Hermes Conrad
uidNumber: 1005
gidNumber: 1005
userPassword: hermes
gecos: Hermes Conrad
loginShell: /bin/bash
homeDirectory: /home/hermes
shadowExpire: -1
shadowFlag: 0
shadowWarning: 7
shadowMin: 0
shadowMax: 99999
shadowLastChange: 10877
mail: hermes@planetexpress.com
postalCode: 12345
l: New New York
o: Planet Express
mobile: +1 234 567 890
homePhone: +1 234 567 890
title: Bureaucrat
initials: HC

dn: uid=professor,ou=people,dc=planetexpress,dc=com
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: professor
sn: Farnsworth
givenName: Hubert
cn: Hubert J. Farnsworth
displayName: Hubert J. Farnsworth
uidNumber: 1006
gidNumber: 1006
userPassword: professor
gecos: Hubert J. Farnsworth
loginShell: /bin/bash
homeDirectory: /home/professor
shadowExpire: -1
shadowFlag: 0
shadowWarning: 7
shadowMin: 0
shadowMax: 99999
shadowLastChange: 10877
mail: professor@planetexpress.com
postalCode: 12345
l: New New York
o: Planet Express
mobile: +1 234 567 890
homePhone: +1 234 567 890
title: Professor
initials: HJF

dn: uid=nibbler,ou=people,dc=planetexpress,dc=com
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: nibbler
sn: Nibbler
givenName: Lord
cn: Lord Nibbler
displayName: Lord Nibbler
uidNumber: 1007
gidNumber: 1007
userPassword: nibbler
gecos: Lord Nibbler
loginShell: /bin/bash
homeDirectory: /home/nibbler
shadowExpire: -1
shadowFlag: 0
shadowWarning: 7
shadowMin: 0
shadowMax: 99999
shadowLastChange: 10877
mail: nibbler@planetexpress.com
postalCode: 12345
l: New New York
o: Planet Express
mobile: +1 234 567 890
homePhone: +1 234 567 890
title: Pet
initials: LN
EOF
fi

# Show instructions for accessing phpLDAPadmin
echo
echo "You can now access phpLDAPadmin at https://${HOSTIP}:8443"
echo "Login with:"
echo "Login DN: cn=admin,dc=planetexpress,dc=com"
echo "Password: GoodNewsEveryone"
```

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

[filename](ldap.sh ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')