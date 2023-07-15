# Boundary

https://www.boundaryproject.io/

![Boundary Logo](images/boundary-logo.png?raw=true "Boundary Logo")

Boundary is designed to grant access to critical systems using the principle of least privilege, solving challenges organizations encounter when users need to securely access applications and machines. Traditional products that grant access to systems are cumbersome, painful to maintain, or are black boxes lacking extensible APIs. Boundary allows authenticated and authorized users to access secure systems in private networks without granting access to the larger network where those systems reside.

[![Introduction to HashiCorp Boundary](https://img.youtube.com/vi/tUMe7EsXYBQ/maxresdefault.jpg)](https://www.youtube.com/watch?v=tUMe7EsXYBQ)

![Hashicorp Boundary](images/boundary-how-it-works.png?raw=true "Hashicorp Boundary")
![Hashicorp Boundary](images/boundary-login-page.png?raw=true "Hashicorp Boundary")
![Hashicorp Boundary](images/boundary-logged-in-page.png?raw=true "Hashicorp Boundary")

`vagrant up --provision-with basetools,docsify,boundary`

```log
Bringing machine 'hashiqube0.service.consul' up with 'virtualbox' provider...
==> hashiqube0.service.consul: Checking if box 'ubuntu/bionic64' version '20200429.0.0' is up to date...
==> hashiqube0.service.consul: [vagrant-hostsupdater] Checking for host entries
==> hashiqube0.service.consul: [vagrant-hostsupdater]   found entry for: 10.9.99.10 hashiqube0.service.consul
==> hashiqube0.service.consul: [vagrant-hostsupdater]   found entry for: 10.9.99.10 hashiqube0.service.consul
==> hashiqube0.service.consul: Running provisioner: boundary (shell)...
    hashiqube0.service.consul: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20201103-74542-1kv32gp.sh
    hashiqube0.service.consul: Reading package lists...
    hashiqube0.service.consul: Building dependency tree...
    hashiqube0.service.consul:
    hashiqube0.service.consul: Reading state information...
    hashiqube0.service.consul: unzip is already the newest version (6.0-21ubuntu1).
    hashiqube0.service.consul: jq is already the newest version (1.5+dfsg-2).
    hashiqube0.service.consul: curl is already the newest version (7.58.0-2ubuntu3.10).
    hashiqube0.service.consul: 0 upgraded, 0 newly installed, 0 to remove and 64 not upgraded.
    hashiqube0.service.consul: ++++ Bundary already installed at /usr/local/bin/boundary
    hashiqube0.service.consul: ++++
    hashiqube0.service.consul: Version information:
    hashiqube0.service.consul:   Git Revision:        eccd68d73c3edf14863ecfd31f9023063b809d5a
    hashiqube0.service.consul:   Version Number:      0.1.1
    hashiqube0.service.consul: listener "tcp" {
    hashiqube0.service.consul:   purpose = "api"
    hashiqube0.service.consul:   address = "0.0.0.0:19200"
    hashiqube0.service.consul: }
    hashiqube0.service.consul: ++++ Starting Boundary in dev mode
    hashiqube0.service.consul: ==> Boundary server configuration:
    hashiqube0.service.consul:
    hashiqube0.service.consul:        [Controller] AEAD Key Bytes: F8Rr2klI5yUffkNBt0y9LgUDLMLkEQ583A3S1Ab315s=
    hashiqube0.service.consul:          [Recovery] AEAD Key Bytes: HVC+7Zs4CZlfCV204HG/VL1uYlqKrNkHizdwGflESTw=
    hashiqube0.service.consul:       [Worker-Auth] AEAD Key Bytes: T3Warqpc25zIpeNebp/+442OoQjejdGxEdykw6tzanA=
    hashiqube0.service.consul:               [Recovery] AEAD Type: aes-gcm
    hashiqube0.service.consul:                   [Root] AEAD Type: aes-gcm
    hashiqube0.service.consul:            [Worker-Auth] AEAD Type: aes-gcm
    hashiqube0.service.consul:                                Cgo: disabled
    hashiqube0.service.consul:             Dev Database Container: relaxed_hermann
    hashiqube0.service.consul:                   Dev Database Url: postgres://postgres:password@localhost:32773?sslmode=disable
    hashiqube0.service.consul:           Generated Auth Method Id: ampw_1234567890
    hashiqube0.service.consul:   Generated Auth Method Login Name: admin
    hashiqube0.service.consul:     Generated Auth Method Password: password
    hashiqube0.service.consul:          Generated Host Catalog Id: hcst_1234567890
    hashiqube0.service.consul:                  Generated Host Id: hst_1234567890
    hashiqube0.service.consul:              Generated Host Set Id: hsst_1234567890
    hashiqube0.service.consul:             Generated Org Scope Id: o_1234567890
    hashiqube0.service.consul:         Generated Project Scope Id: p_1234567890
    hashiqube0.service.consul:                Generated Target Id: ttcp_1234567890
    hashiqube0.service.consul:                         Listener 1: tcp (addr: "0.0.0.0:19200", max_request_duration: "1m30s", purpose: "api")
    hashiqube0.service.consul:                         Listener 2: tcp (addr: "127.0.0.1:9201", max_request_duration: "1m30s", purpose: "cluster")
    hashiqube0.service.consul:                         Listener 3: tcp (addr: "127.0.0.1:9202", max_request_duration: "1m30s", purpose: "proxy")
    hashiqube0.service.consul:                          Log Level: info
    hashiqube0.service.consul:                              Mlock: supported: true, enabled: false
    hashiqube0.service.consul:                            Version: Boundary v0.1.1
    hashiqube0.service.consul:                        Version Sha: eccd68d73c3edf14863ecfd31f9023063b809d5a
    hashiqube0.service.consul:                 Worker Public Addr: 127.0.0.1:9202
    hashiqube0.service.consul:
    hashiqube0.service.consul: ==> Boundary server started! Log data will stream in below:
    hashiqube0.service.consul:
    hashiqube0.service.consul: 2020-11-03T00:02:59.775Z [INFO]  controller: cluster address: addr=127.0.0.1:9201
    hashiqube0.service.consul: 2020-11-03T00:02:59.775Z [INFO]  worker: connected to controller: address=127.0.0.1:9201
    hashiqube0.service.consul: 2020-11-03T00:02:59.778Z [INFO]  controller: worker successfully authed: name=dev-worker
    hashiqube0.service.consul: ++++ Boundary Server started at http://localhost:19200
    hashiqube0.service.consul: ++++ Login with admin:password
    hashiqube0.service.consul: /tmp/vagrant-shell: line 5:  5093 Terminated              sh -c 'sudo tail -f /var/log/boundary.log | { sed "/worker successfully authed/ q" && kill $$ ;}'
```

## Boundary Vagrant Provisioner

`boundary.sh`

[filename](boundary.sh ':include :type=code')