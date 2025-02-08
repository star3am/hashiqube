# Vault

![Vault Logo](images/vault-logo.png?raw=true "Vault Logo")

In this HashiQube DevOps lab you will get hands on experience with HashiCorp Vault.

Manage Secrets and Protect Sensitive Data.
Secure, store and tightly control access to tokens, passwords, certificates, encryption keys for protecting secrets and other sensitive data using a UI, CLI, or HTTP API.

In this whiteboard video, Armon Dadgar, HashiCorp's co-founder and CTO, explains Vault, a tool for securely accessing secrets. A secret is anything that you want to tightly control access to, such as API keys, passwords, or certificates.

## Latest News

- [Vault 1.15 adopts Microsoft Workload Identity Federation](https://www.hashicorp.com/blog/hashicorp-vault-1-15-adopts-microsoft-workload-identity-federation)
- [Vault 1.14 brings ACME for PKI, AWS roles, and more improvements](https://www.hashicorp.com/blog/vault-1-14-brings-acme-for-pki-aws-roles-and-more-improvements)
- [Vault 1.13 adds Kubernetes Operator, MFA improvements, and more](https://www.hashicorp.com/blog/vault-1-13-adds-kubernetes-operator-mfa-improvements-and-more)
- [Vault 1.12 Adds New Secrets Engines, ADP Updates, and More](https://www.hashicorp.com/blog/vault-1-12)
- [Vault 1.11 Adds Kubernetes Secrets Engine, PKI Updates, and More](https://www.hashicorp.com/blog/vault-1-11)
- [Vault 1.10 Achieves FIPS 140-2 Compliance](https://www.hashicorp.com/blog/hashicorp-vault-1-10-achieves-fips-140-2-compliance)

## Introduction

[![Armon Dadgar: Introduction to HashiCorp Vault](images/maxresdefault.jpeg)](https://www.youtube.com/watch?v=VYfl-DpZ5wM)

## Provision

<!-- tabs:start -->
#### **Github Codespaces**
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)
```
bash vault/vault.sh
```

#### **Vagrant**

```
vagrant up --provision-with basetools,docsify,vault
```

#### **Docker Compose**

```
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash vault/vault.sh
```
<!-- tabs:end -->

Once the provisioner has run, you will be able to access vault on http://localhost:8200
And you can login with the `Initial Root Token` displayed in the output of the privisioner. 

:bulb: If you ever needed to feth the Initial Root Token again you can get this inside HashiQube by doing: 

- vagrant ssh
- cat /etc/vault/init.file

![Vault](images/vault.png?raw=true "Vault")

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')

### Performance Replication

Vault supports two types of replication:

__Performance Replication__, in which multiple clusters are simultaneously active in different geographical regions so that applications can interact with nearby Vault servers. This reduces latency when applications request secrets from Vault.

When multiple clusters are joined in a performance replication set, one is the primary while the others are secondary. All the clusters can service read requests themselves, but write requests are forwarded to the primary cluster.

After the primary cluster saves new secrets, it replicates them to the secondary clusters. So, even when a request is initially sent to a secondary cluster, from Vault's point of view the data always flows from the primary cluster to the secondary clusters.

This is important to keep in mind when we talk about mount filters and local mounts.

__A Mount Filter__ is a configuration that tells the primary cluster which secrets engines and auth methods should have their data replicated from the primary cluster to specific secondary clusters.

They can be dynamically enabled and removed both before and after performance replication has been configured.

A generalization of a mount filter is a __Path Filter__ which can filter both mounts and namespaces in Vault Enterprise.

A __Local Mount__ is a secret engine or auth method that is designated as local when it is created. It's data is not replicated to other clusters.

Additionally, requests to do writes against it are handled by the cluster it was created in, even if that cluster is a performance secondary. In that case, the primary performance cluster will not see any of the local mount's data.

A mount that is not local is considered a replicated mount. All mounts are replicated by default unless they are explicitly designated as local mounts when they are created.

Use a mount filter when you want to restrict the flow of data from a performance primary to secondary clusters. Use a local mount when you want to restrict the flow of data from secondary clusters to the primary cluster and any other secondaries.

You can learn more about the difference between local and replicated mounts at https://developer.hashicorp.com/vault/tutorials/enterprise/performance-replication#replicated-vs-local-backend-mounts

__Disaster Recovery Replication__, in which only one cluster is active while the other secondary clusters serve as warm standbys in case the primary cluster suffers a catastrophic failure.

`Both kinds of replication can be used simultaneously.`

## Vault Policy Syntax

if you define a policy for "secret/foo*", the policy would also match "secret/foobar". Specifically, when there are potentially multiple matching policy paths, P1 and P2, the following matching criteria is applied:

If the first wildcard (+) or glob (*) occurs earlier in P1, P1 is lower priority

```
If P1 ends in * and P2 doesn't, P1 is lower priority
If P1 has more + (wildcard) segments, P1 is lower priority
If P1 is shorter, it is lower priority
If P1 is smaller lexicographically, it is lower priority
For example, given the two paths, "secret/*" and "secret/+/+/foo/*", the first wildcard appears in the same place, both end in * and the latter has two wildcard segments while the former has zero. So we end at rule (3), and give "secret/+/+/foo/*" lower priority.
```

:bulb: The glob character referred to in this documentation is the asterisk (*). It is not a regular expression and is only supported as the last character of the path!

When providing list capability, it is important to note that since listing always operates on a prefix, policies must operate on a prefix because Vault will sanitize request paths to be prefixes.

### Capabilities

Each path must define one or more capabilities which provide fine-grained control over permitted (or denied) operations. As shown in the examples above, capabilities are always specified as a list of strings, even if there is only one capability.

To determine the capabilities needed to perform a specific operation, the -output-policy flag can be added to the CLI subcommand. For an example, refer to the Print Policy Requirements document section.

The list of capabilities include the following:

- create (POST/PUT) - Allows creating data at the given path. Very few parts of Vault distinguish between create and update, so most operations require both create and update capabilities. Parts of Vault that provide such a distinction are noted in documentation.

- read (GET) - Allows reading the data at the given path.

- update (POST/PUT) - Allows changing the data at the given path. In most parts of Vault, this implicitly includes the ability to create the initial value at the path.

- patch (PATCH) - Allows partial updates to the data at a given path.

- delete (DELETE) - Allows deleting the data at the given path.

- list (LIST) - Allows listing values at the given path. Note that the keys returned by a list operation are not filtered by policies. Do not encode sensitive information in key names. Not all backends support listing.

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')

## Vault Policy Example

This is fairly long but gives a Vault administrator capabilities for most paths that they will need assuming they enable secrets engines and auth methods on the standard paths.

In an actual Vault deployment, you would determine which paths are needed in advance and add them to this policy before revoking your root token.

Additionally, the policy gives a token created from it access to common system paths and to all Vault Enterprise paths.

```hcl
# Manage auth methods broadly across Vault
path "auth/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Create, update, and delete auth methods
path "sys/auth/*" {
  capabilities = ["create", "update", "delete", "sudo"]
}

# List auth methods
path "sys/auth" {
  capabilities = ["read"]
}

# Create and manage ACL policies
path "sys/policies/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# To list policies - Step 3
path "sys/policies/" {
  capabilities = ["list"]
}

# List, create, update, and delete key/value secrets mounted under secret/
path "secret/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# List secret/
path "secret/" {
  capabilities = ["list"]
}

# Prevent admin users from reading user secrets
# But allow them to create, update, delete, and list them
path "secret/users/*" {
  capabilities = ["create", "update", "delete", "list"]
}

# List, create, update, and delete key/value secrets mounted under kv/
path "kv/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# List kv/
path "kv/" {
  capabilities = ["list"]
}

# Prevent admin users from reading user secrets
# But allow them to create, update, delete, and list them
# Creating and updating are explicitly included here
# Deleting and listing are implied by capabilities given on kv/* which includes kv/delete/users/* and kv/metadata/users/* paths
path "kv/data/users/*" {
  capabilities = ["create", "update"]
}

# Active Directory secrets engine
path "ad/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Alicloud secrets engine
path "alicloud/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# AWS secrets engine
path "aws/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Azure secrets engine
path "azure/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Google Cloud secrets engine
path "gcp/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Google Cloud KMS secrets engine
path "gcpkms/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Consul secrets engine
path "consul/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Cubbyhole secrets engine
path "cubbyhole/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Database secrets engine
path "database/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Identity secrets engine
path "identity/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# PKI secrets engine
path "nomad/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Nomad secrets engine
path "pki/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# RabbitMQ secrets engine
path "rabbitmq/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# SSH secrets engine
path "ssh/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# TOTP secrets engine
path "totp/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Transit secrets engine
path "transit/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Create and manage secrets engines broadly across Vault.
path "sys/mounts/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

# List sys/mounts/
path "sys/mounts" {
  capabilities = ["read"]
}

# Check token capabilities
path "sys/capabilities" {
  capabilities = ["create", "update"]
}

# Check token accessor capabilities
path "sys/capabilities-accessor" {
  capabilities = ["create", "update"]
}

# Check token's own capabilities
path "sys/capabilities-self" {
  capabilities = ["create", "update"]
}

# Audit hash
path "sys/audit-hash" {
  capabilities = ["create", "update"]
}

# Health checks
path "sys/health" {
  capabilities = ["read"]
}

# Host info
path "sys/host-info" {
  capabilities = ["read"]
}

# Key Status
path "sys/key-status" {
  capabilities = ["read"]
}

# Leader
path "sys/leader" {
  capabilities = ["read"]
}

# Plugins catalog
path "sys/plugins/catalog/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# List sys/plugins/catalog
path "sys/plugins/catalog" {
  capabilities = ["read"]
}

# Read system configuration state
path "sys/config/state/sanitized" {
  capabilities = ["read"]
}

# Use system tools
path "sys/tools/*" {
  capabilities = ["create", "update"]
}

# Generate OpenAPI docs
path "sys/internal/specs/openapi" {
  capabilities = ["read"]
}

# Lookup leases
path "sys/leases/lookup" {
  capabilities = ["create", "update"]
}

# Renew leases
path "sys/leases/renew" {
  capabilities = ["create", "update"]
}

# Revoke leases
path "sys/leases/revoke" {
  capabilities = ["create", "update"]
}

# Tidy leases
path "sys/leases/tidy" {
  capabilities = ["create", "update"]
}

# Telemetry
path "sys/metrics" {
  capabilities = ["read"]
}

# Seal Vault
path "sys/seal" {
  capabilities = ["create", "update", "sudo"]
}

# Unseal Vault
path "sys/unseal" {
  capabilities = ["create", "update", "sudo"]
}

# Step Down
path "sys/step-down" {
  capabilities = ["create", "update", "sudo"]
}

# Wrapping
path "sys/wrapping/*" {
  capabilities = ["create", "update"]
}

## Enterprise Features

# Manage license
path "sys/license/status" {
  capabilities = ["create", "read", "update"]
}

# Use control groups
path "sys/control-group/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# MFA
path "sys/mfa/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# List MFA
path "sys/mfa/" {
  capabilities = ["list"]
}

# Namespaces
path "sys/namespaces/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# List sys/namespaces
path "sys/namespaces/" {
  capabilities = ["list"]
}

# Replication
path "sys/replication/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Seal Wrap
path "sys/sealwrap/rewrap" {
  capabilities = ["create", "read", "update"]
}

# KMIP secrets engine
path "kmip/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
```

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')

## Vault Namespaces

Vault Enterprise Namespaces allow Vault to support multi-tenant deployments in which different teams are isolated from each other and can self-manage their own secrets.

Vault namespaces form a hierarchy with all namespaces living under the "root" namespace which is what we have been using all along. However, namespaces do much more than make the hierarchy of Vault paths deeper since each namespace can have its own secrets engines, auth methods, policies, identities, and tokens.

## Links

- https://www.vaultproject.io/

## Vault Provisioner

`vault.sh`

[filename](vault.sh ':include :type=code')

## Monitoring Vault

We use Prometheus and Grafana to Monitor Vault

See: [__Monitoring Hashicorp Vault__](prometheus-grafana/README?id=monitoring-hashicorp-vault)

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')