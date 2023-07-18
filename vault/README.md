# Vault

https://www.vaultproject.io/

![Vault Logo](images/vault-logo.png?raw=true "Vault Logo")

Manage Secrets and Protect Sensitive Data.
Secure, store and tightly control access to tokens, passwords, certificates, encryption keys for protecting secrets and other sensitive data using a UI, CLI, or HTTP API.

In this whiteboard video, Armon Dadgar, HashiCorp's co-founder and CTO, explains Vault, a tool for securely accessing secrets. A secret is anything that you want to tightly control access to, such as API keys, passwords, or certificates.

[![Armon Dadgar: Introduction to HashiCorp Vault](images/maxresdefault.jpeg)](https://www.youtube.com/watch?v=VYfl-DpZ5wM)

`vagrant up --provision-with basetools,docsify,vault`

```log
Bringing machine 'user.local.dev' up with 'virtualbox' provider...
==> user.local.dev: Checking if box 'ubuntu/xenial64' version '20190918.0.0' is up to date...
==> user.local.dev: [vagrant-hostsupdater] Checking for host entries
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: Running provisioner: vault (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200110-35357-1112dsr.sh
    user.local.dev: Reading package lists...
    user.local.dev: Building dependency tree...
    user.local.dev:
    user.local.dev: Reading state information...
    user.local.dev: unzip is already the newest version (6.0-20ubuntu1).
    user.local.dev: curl is already the newest version (7.47.0-1ubuntu2.14).
    user.local.dev: jq is already the newest version (1.5+dfsg-1ubuntu0.1).
    user.local.dev: 0 upgraded, 0 newly installed, 0 to remove and 4 not upgraded.
    user.local.dev: sed: -e expression #1, char 34: unknown option to `s'
    user.local.dev: ++++ Vault already installed and running
    user.local.dev: ++++ Vault http://localhost:8200/ui and enter the following codes displayed below
    user.local.dev: ++++ Auto unseal vault
    user.local.dev: Key             Value
    user.local.dev: ---             ----
    user.local.dev: -
    user.local.dev: Seal Type       shamir
    user.local.dev: Initialize
    user.local.dev: d     true
    user.local.dev: Sealed          false
    user.local.dev: Total Shares    5
    user.local.dev: Threshold       3
    user.local.dev: Version         1.3.1
    user.local.dev: Cluster Name    vault
    user.local.dev: Cluster ID      11fa4aed
    user.local.dev: -dc06-2d64-5429-7fadc5d8473a
    user.local.dev: HA Enabled      false
    user.local.dev: Key             Value
    user.local.dev: ---             -----
    user.local.dev: Seal Type       shamir
    user.local.dev: Initialized
    user.local.dev:   true
    user.local.dev: Sealed          false
    user.local.dev: Total
    user.local.dev: Shares    5
    user.local.dev: Threshold       3
    user.local.dev: Version         1.3.1
    user.local.dev: Cluster Name    vault
    user.local.dev: Cluster ID      11fa4aed-dc06-2d6
    user.local.dev: Unseal Key 1: XsVFkqDcG7JCXaAYHEUcg1VrKE6uO7Zs90FV9XqL7S1X
    user.local.dev: Unseal Key 2: eUNVAQbFxbGTkQ0rdT1RRp1E/hdgMVmOXCTyddsYOzOV
    user.local.dev: Unseal Key 3: eaIbXrTA+VA/g7/Tm1iCdfzajjRSx6k1xfIUHvd/IiKp
    user.local.dev: Unseal Key 4: 7lcRnPqLaQiopY3NFCcRAfUHc9shxHTqmUXjzsxAQdbr
    user.local.dev: Unseal Key 5: l9GpctLEhzOS1O9K2qk09B3vFU85PUC1s8KWHKNYplj8
    user.local.dev:
    user.local.dev: Initial Root Token: s.rrftkbzQ8XBKVTijFyxaRWkH
    user.local.dev:
    user.local.dev: Vault initialized with 5 key shares and a key threshold of 3. Please securely
    user.local.dev: distribute the key shares printed above. When the Vault is re-sealed,
    user.local.dev: restarted, or stopped, you must supply at least 3 of these keys to unseal it
    user.local.dev: before it can start servicing requests.
    user.local.dev:
    user.local.dev: Vault does not store the generated master key. Without at least 3 key to
    user.local.dev: reconstruct the master key, Vault will remain permanently sealed!
    user.local.dev:
    user.local.dev: It is possible to generate new unseal keys, provided you have a quorum of
    user.local.dev: existing unseal keys shares. See "vault operator rekey" for more information.
```
![Vault](images/vault.png?raw=true "Vault")

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

## Vault Vagrant Provisioner

`vault.sh`

[filename](vault.sh ':include :type=code')

## Monitoring Hashicorp Vault

We use Prometheus and Grafana to Monitor Vault

See: [__Monitoring Hashicorp Vault__](prometheus-grafana/README?id=monitoring-hashicorp-vault)
