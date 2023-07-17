# Consul

https://www.consul.io/

![Consul Logo](images/consul-logo.png?raw=true "Consul Logo")

Consul is a service networking solution to connect and secure services across any runtime platform and public or private cloud

HashiCorp co-founder and CTO Armon Dadgar gives a whiteboard overview of HashiCorp Consul, a service networking solution to connect, configure, and secure services in dynamic infrastructure.

[![Introduction to HashiCorp Consul](images/maxresdefault.jpeg)](https://www.youtube.com/watch?v=mxeMdl0KvBI)

For hands-on interactive labs with Consul, visit HashiCorp Learn https://hashi.co/learnconsul 

### Consul DNS
To use Consul as a DNS resolver from your laptop, you can create the following file<br />
`/etc/resolver/consul`
```
nameserver 10.9.99.10
port 8600
```
Now names such as `nomad.service.consul` and `fabio.service.consul` will work

`vagrant up --provision-with basetools,docker,docsify,consul`

```log
Bringing machine 'user.local.dev' up with 'virtualbox' provider...
==> user.local.dev: Checking if box 'ubuntu/xenial64' version '20190918.0.0' is up to date...
==> user.local.dev: [vagrant-hostsupdater] Checking for host entries
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: Running provisioner: consul (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200110-35654-11zwf6z.sh
    user.local.dev: Reading package lists...
    user.local.dev: Building dependency tree...
    user.local.dev: Reading state information...
    user.local.dev: unzip is already the newest version (6.0-20ubuntu1).
    user.local.dev: curl is already the newest version (7.47.0-1ubuntu2.14).
    user.local.dev: jq is already the newest version (1.5+dfsg-1ubuntu0.1).
    user.local.dev: 0 upgraded, 0 newly installed, 0 to remove and 4 not upgraded.
    user.local.dev: primary_datacenter = "dc1"
    user.local.dev: client_addr = "10.9.99.10 127.0.0.1 ::1"
    user.local.dev: bind_addr = "0.0.0.0"
    user.local.dev: data_dir = "/var/lib/consul"
    user.local.dev: datacenter = "dc1"
    user.local.dev: disable_host_node_id = true
    user.local.dev: disable_update_check = true
    user.local.dev: leave_on_terminate = true
    user.local.dev: log_level = "INFO"
    user.local.dev: ports = {
    user.local.dev:   grpc  = 8502
    user.local.dev:   dns   = 8600
    user.local.dev:   https = -1
    user.local.dev: }
    user.local.dev: protocol = 3
    user.local.dev: raft_protocol = 3
    user.local.dev: recursors = [
    user.local.dev:   "8.8.8.8",
    user.local.dev:   "8.8.4.4",
    user.local.dev: ]
    user.local.dev: server_name = "consul.service.consul"
    user.local.dev: ui = true
    user.local.dev: ++++ Consul already installed at /usr/local/bin/consul
    user.local.dev: ++++ Consul v1.6.2
    user.local.dev: Protocol 2 spoken by default, understands 2 to 3 (agent will automatically use protocol >2 when speaking to compatible agents)
    user.local.dev: ==> Starting Consul agent...
    user.local.dev:            Version: 'v1.6.2'
    user.local.dev:            Node ID: '3e943a0a-d73e-5797-cb3e-f3dc2e6df832'
    user.local.dev:          Node name: 'user'
    user.local.dev:         Datacenter: 'dc1' (Segment: '<all>')
    user.local.dev:             Server: true (Bootstrap: false)
    user.local.dev:        Client Addr: [0.0.0.0] (HTTP: 8500, HTTPS: -1, gRPC: 8502, DNS: 8600)
    user.local.dev:       Cluster Addr: 10.9.99.10 (LAN: 8301, WAN: 8302)
    user.local.dev:            Encrypt: Gossip: false, TLS-Outgoing: false, TLS-Incoming: false, Auto-Encrypt-TLS: false
    user.local.dev:
    user.local.dev: ==> Log data will now stream in as it occurs:
    user.local.dev:
    user.local.dev:     2020/01/10 04:13:07 [INFO]  raft: Initial configuration (index=1): [{Suffrage:Voter ID:3e943a0a-d73e-5797-cb3e-f3dc2e6df832 Address:10.9.99.10:8300}]
    user.local.dev:     2020/01/10 04:13:07 [INFO] serf: EventMemberJoin: user.dc1 10.9.99.10
    user.local.dev:     2020/01/10 04:13:07 [INFO] serf: EventMemberJoin: user 10.9.99.10
    user.local.dev:     2020/01/10 04:13:07 [INFO]  raft: Node at 10.9.99.10:8300 [Follower] entering Follower state (Leader: "")
    user.local.dev:     2020/01/10 04:13:07 [INFO] consul: Handled member-join event for server "user.dc1" in area "wan"
    user.local.dev:     2020/01/10 04:13:07 [INFO] consul: Adding LAN server user (Addr: tcp/10.9.99.10:8300) (DC: dc1)
    user.local.dev:     2020/01/10 04:13:07 [INFO] agent: Started DNS server 0.0.0.0:8600 (udp)
    user.local.dev:     2020/01/10 04:13:07 [INFO] agent: Started DNS server 0.0.0.0:8600 (tcp)
    user.local.dev:     2020/01/10 04:13:07 [INFO] agent: Started HTTP server on [::]:8500 (tcp)
    user.local.dev:     2020/01/10 04:13:07 [INFO] agent: Started gRPC server on [::]:8502 (tcp)
    user.local.dev:     2020/01/10 04:13:07 [INFO] agent: started state syncer
    user.local.dev: ==> Consul agent running!
    user.local.dev:     2020/01/10 04:13:07 [WARN]  raft: Heartbeat timeout from "" reached, starting election
    user.local.dev:     2020/01/10 04:13:07 [INFO]  raft: Node at 10.9.99.10:8300 [Candidate] entering Candidate state in term 2
    user.local.dev:     2020/01/10 04:13:07 [INFO]  raft: Election won. Tally: 1
    user.local.dev:     2020/01/10 04:13:07 [INFO]  raft: Node at 10.9.99.10:8300 [Leader] entering Leader state
    user.local.dev:     2020/01/10 04:13:07 [INFO] consul: cluster leadership acquired
    user.local.dev:     2020/01/10 04:13:07 [INFO] consul: New leader elected: user
    user.local.dev:     2020/01/10 04:13:07 [INFO] connect: initialized primary datacenter CA with provider "consul"
    user.local.dev:     2020/01/10 04:13:07 [INFO] consul: member 'user' joined, marking health alive
    user.local.dev:     2020/01/10 04:13:07 [INFO] agent: Synced service "_nomad-server-4rgldggulg5f54ypvl4pfyqeijtqd3u4"
    user.local.dev: /tmp/vagrant-shell: line 4: 19556 Terminated              sh -c 'sudo tail -f /var/log/consul.log | { sed "/agent: Synced/ q" && kill $$ ;}'
    user.local.dev: Node        Address          Status  Type    Build  Protocol  DC   Segment
    user.local.dev: user  10.9.99.10:8301  alive   server  1.6.2  3         dc1  <all>
    user.local.dev: agent:
    user.local.dev: 	check_monitors = 0
    user.local.dev: 	check_ttls = 1
    user.local.dev: 	checks = 11
    user.local.dev: 	services = 11
    user.local.dev: build:
    user.local.dev: 	prerelease =
    user.local.dev: 	revision = 1200f25e
    user.local.dev: 	version = 1.6.2
    user.local.dev: consul:
    user.local.dev: 	acl = disabled
    user.local.dev: 	bootstrap = false
    user.local.dev: 	known_datacenters = 1
    user.local.dev: 	leader = true
    user.local.dev: 	leader_addr = 10.9.99.10:8300
    user.local.dev: 	server = true
    user.local.dev: raft:
    user.local.dev: 	applied_index = 24
    user.local.dev: 	commit_index = 24
    user.local.dev: 	fsm_pending = 0
    user.local.dev: 	last_contact = 0
    user.local.dev: 	last_log_index = 24
    user.local.dev: 	last_log_term = 2
    user.local.dev: 	last_snapshot_index = 0
    user.local.dev: 	last_snapshot_term = 0
    user.local.dev: 	latest_configuration = [{Suffrage:Voter ID:3e943a0a-d73e-5797-cb3e-f3dc2e6df832 Address:10.9.99.10:8300}]
    user.local.dev: 	latest_configuration_index = 1
    user.local.dev: 	num_peers = 0
    user.local.dev: 	protocol_version = 3
    user.local.dev: 	protocol_version_max = 3
    user.local.dev: 	protocol_version_min = 0
    user.local.dev: 	snapshot_version_max = 1
    user.local.dev: 	snapshot_version_min = 0
    user.local.dev: 	state = Leader
    user.local.dev: 	term = 2
    user.local.dev: runtime:
    user.local.dev: 	arch = amd64
    user.local.dev: 	cpu_count = 2
    user.local.dev: 	goroutines = 115
    user.local.dev:
    user.local.dev: 	max_procs = 2
    user.local.dev: 	os = linux
    user.local.dev: 	version = go1.12.13
    user.local.dev: serf_lan:
    user.local.dev: 	coordinate_resets = 0
    user.local.dev: 	encrypted = false
    user.local.dev: 	event_queue = 1
    user.local.dev: 	event_time = 2
    user.local.dev: 	failed = 0
    user.local.dev: 	health_score = 0
    user.local.dev: 	intent_queue = 0
    user.local.dev: 	left = 0
    user.local.dev: 	member_time = 1
    user.local.dev: 	members = 1
    user.local.dev: 	query_queue = 0
    user.local.dev: 	query_time = 1
    user.local.dev: serf_wan:
    user.local.dev: 	coordinate_resets = 0
    user.local.dev: 	encrypted = false
    user.local.dev: 	event_queue = 0
    user.local.dev: 	event_time = 1
    user.local.dev: 	failed = 0
    user.local.dev: 	health_score = 0
    user.local.dev: 	intent_queue = 0
    user.local.dev: 	left = 0
    user.local.dev: 	member_time = 1
    user.local.dev: 	members = 1
    user.local.dev: 	query_queue = 0
    user.local.dev: 	query_time = 1
    user.local.dev: ++++ Adding Consul KV data for Fabio Load Balancer Routes
    user.local.dev: Success! Data written to: fabio/config/vault
    user.local.dev: Success! Data written to: fabio/config/nomad
    user.local.dev: Success! Data written to: fabio/config/consul
    user.local.dev: ++++ Consul http://localhost:8500
```    
![Consul](images/consul.png?raw=true "Consul")

## Consul Vagrant Provisioner

`consul.sh`

[filename](consul.sh ':include :type=code')

## Monitoring Hashicorp Consul

We use Prometheus and Grafana to Monitor Consul

See: [__Monitoring Hashicorp Consul__](prometheus-grafana/README?id=monitoring-hashicorp-consul)
