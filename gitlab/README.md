# Gitlab
https://docs.gitlab.com/omnibus/docker/ <br />
https://gitlab.com/ <br />

![Gitlab Logo](images/gitlab-logo.png?raw=true "Gitlab Logo")

GitLab is a complete DevOps platform
With GitLab, you get a complete CI/CD toolchain in a single application. One interface. One conversation. One permission model. Thousands of features. You'll be amazed at everything GitLab can do today. And we're just getting started.

You can get Gitlab up and running by running the following command in the hashiqube source repository that you cloned earlier. 

:clock3: Duration 15 - 30 minutes <br>
:bangbang: Your Docker daemon should at least have 12G Ram (Gitlab takes 6G alone, Minikube 2G and 2G for the Operating System in Hashiqube) <br>
:bulb: We will bring up the Docker daemon and Minikube and then deploy Gitlab ontop of Minikube using Helm

During the install process you can open the Kubernetes Dashboard once Minikube has been installed - Initally you will see some red as Gitlab pods and services start up, later this will all turn to green.

http://localhost:10888/

![Minikube Dashboard](images/gitlab-install-minikube-dashboard.png?raw=true "Minikube Dashboard")

`vagrant up --provision-with basetools,docker,docsify,minikube,gitlab`

```
Bringing machine 'hashiqube0' up with 'docker' provider...
==> hashiqube0: Creating and configuring docker networks...
==> hashiqube0: Building the container from a Dockerfile...
    hashiqube0: #1 [internal] load build definition from Dockerfile
    hashiqube0: #1 transferring dockerfile: 1.99kB done
    hashiqube0: #1 DONE 0.0s
    hashiqube0:
    hashiqube0: #2 [internal] load .dockerignore
    hashiqube0: #2 transferring context: 2B done
    hashiqube0: #2 DONE 0.0s
    hashiqube0:
    hashiqube0: #3 [internal] load metadata for docker.io/library/ubuntu:focal
    hashiqube0: #3 DONE 0.0s
    hashiqube0:
    hashiqube0: #4 [ 1/11] FROM docker.io/library/ubuntu:focal
    hashiqube0: #4 DONE 0.0s
    hashiqube0:
    hashiqube0: #5 [ 8/11] RUN useradd -m -G sudo -s /bin/bash vagrant &&     echo "vagrant:vagrant" | chpasswd &&     echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant &&     chmod 440 /etc/sudoers.d/vagrant
    hashiqube0: #5 CACHED
    hashiqube0:
    hashiqube0: #6 [ 9/11] RUN mkdir -p /home/vagrant/.ssh;     chmod 700 /home/vagrant/.ssh
    hashiqube0: #6 CACHED
    hashiqube0:
    hashiqube0: #7 [ 4/11] RUN apt-get -qq clean < /dev/null > /dev/null
    hashiqube0: #7 CACHED
    hashiqube0:
    hashiqube0: #8 [ 6/11] RUN find /lib/systemd/system/sysinit.target.wants -mindepth 1 -not -name "systemd-tmpfiles-setup.service" -delete;     find /lib/systemd/system/multi-user.target.wants -mindepth 1 -not -name "systemd-user-sessions.service" -delete;     rm -f /etc/systemd/system/*.wants/*;     rm -f /lib/systemd/system/local-fs.target.wants/*;     rm -f /lib/systemd/system/sockets.target.wants/*udev*;     rm -f /lib/systemd/system/sockets.target.wants/*initctl*;     rm -f /lib/systemd/system/basic.target.wants/*;     rm -f /lib/systemd/system/anaconda.target.wants/*;
    hashiqube0: #8 CACHED
    hashiqube0:
    hashiqube0: #9 [ 7/11] RUN systemctl enable ssh.service;
    hashiqube0: #9 CACHED
    hashiqube0:
    hashiqube0: #10 [10/11] RUN wget -q -O /home/vagrant/.ssh/authorized_keys https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub
    hashiqube0: #10 CACHED
    hashiqube0:
    hashiqube0: #11 [ 3/11] RUN apt-get -y install -qq         openssh-server         passwd         sudo         man-db         curl         wget         vim-tiny < /dev/null > /dev/null
    hashiqube0: #11 CACHED
    hashiqube0:
    hashiqube0: #12 [ 2/11] RUN apt-get update -qq < /dev/null > /dev/null
    hashiqube0: #12 CACHED
    hashiqube0:
    hashiqube0: #13 [ 5/11] RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    hashiqube0: #13 CACHED
    hashiqube0:
    hashiqube0: #14 [11/11] RUN chmod 600 /home/vagrant/.ssh/authorized_keys;     chown -R vagrant:vagrant /home/vagrant/.ssh
    hashiqube0: #14 CACHED
    hashiqube0:
    hashiqube0: #15 exporting to image
    hashiqube0: #15 exporting layers done
    hashiqube0: #15 writing image sha256:a3cd0f5b5cffa45571f31cf9b097c8c30d96147e7e78a615122de1094302e8c4 done
    hashiqube0: #15 DONE 0.0s
    ...
    ...
    ...
    ...
    ...
    hashiqube0:   Port: 10888:10888
    hashiqube0:   Port: 11888:11888
    hashiqube0:   Port: 18080:18080
    hashiqube0:   Port: 18181:18181
    hashiqube0:   Port: 31506:31506
    hashiqube0:   Port: 18888:18888
    hashiqube0:   Port: 18889:18889
    hashiqube0:   Port: 3333:3333
    hashiqube0:   Port: 8043:8043
    hashiqube0:   Port: 5580:5580
    hashiqube0:   Port: 8181:8181
    hashiqube0:   Port: 32022:32022
    hashiqube0:   Port: 7777:7777
    hashiqube0:   Port: 28080:28080
    hashiqube0:   Port: 8000:8000
    hashiqube0:
    hashiqube0: Container created: 27d6cf5fe6e3555a
==> hashiqube0: Enabling network interfaces...
==> hashiqube0: Starting container...
==> hashiqube0: Waiting for machine to boot. This may take a few minutes...
    hashiqube0: SSH address: 127.0.0.1:2255
    hashiqube0: SSH username: vagrant
    hashiqube0: SSH auth method: private key
    hashiqube0:
    hashiqube0: Vagrant insecure key detected. Vagrant will automatically replace
    hashiqube0: this with a newly generated keypair for better security.
    hashiqube0:
    hashiqube0: Inserting generated public key within guest...
    hashiqube0: Removing insecure key from the guest if it's present...
    hashiqube0: Key inserted! Disconnecting and reconnecting using new SSH key...
==> hashiqube0: Machine booted and ready!
==> hashiqube0: Running provisioner: basetools (shell)...
    hashiqube0: Running: /var/folders/24/42plvkmn3313qkrvqjr3nqph0000gn/T/vagrant-shell20230830-87512-mgxdlt.sh
    hashiqube0: debconf: delaying package configuration, since apt-utils is not installed
    hashiqube0: debconf: delaying package configuration, since apt-utils is not installed
    hashiqube0: update-alternatives: using /usr/bin/python3.9 to provide /usr/bin/python (python) in auto mode
    hashiqube0: update-alternatives: using /usr/bin/pip3 to provide /usr/bin/pip (pip) in auto mode
    hashiqube0: Python 3.9.5
    hashiqube0: Python 3.9.5
    hashiqube0: pip 20.0.2 from /usr/lib/python3/dist-packages/pip (python 3.8)
    hashiqube0: pip 20.0.2 from /usr/lib/python3/dist-packages/pip (python 3.8)
    hashiqube0: #!/bin/bash
    hashiqube0: /usr/bin/toilet --gay -f standard hashiqube0 -w 170
    hashiqube0: printf "%s"
    hashiqube0: END BOOTSTRAP 2023-08-30 03:40:11
    ...
    ...
    ...
    ...
    ...
==> hashiqube0: Running provisioner: docker (shell)...
    hashiqube0: Running: /var/folders/24/42plvkmn3313qkrvqjr3nqph0000gn/T/vagrant-shell20230830-87512-8io2nq.sh
    hashiqube0: Warning: apt-key output should not be parsed (stdout is not a terminal)
    hashiqube0: OK
    hashiqube0: CPU is arm64
    hashiqube0: Get:1 https://download.docker.com/linux/ubuntu focal InRelease [57.7 kB]
    hashiqube0: Get:2 https://download.docker.com/linux/ubuntu focal/stable arm64 Packages [36.9 kB]
    hashiqube0: Hit:3 http://ports.ubuntu.com/ubuntu-ports focal InRelease
    hashiqube0: Hit:4 http://ports.ubuntu.com/ubuntu-ports focal-updates InRelease
    hashiqube0: Hit:5 http://ports.ubuntu.com/ubuntu-ports focal-backports InRelease
    hashiqube0: Hit:6 http://ports.ubuntu.com/ubuntu-ports focal-security InRelease
    hashiqube0: Fetched 94.5 kB in 3s (37.3 kB/s)
    hashiqube0: Reading package lists...
    hashiqube0: Error response from daemon: No such container: registry
    hashiqube0: Error response from daemon: No such container: registry
    hashiqube0: Error response from daemon: No such container: apache2
    hashiqube0: Error response from daemon: No such container: apache2
    hashiqube0: WARNING! This will remove:
    hashiqube0:   - all stopped containers
    hashiqube0:   - all networks not used by at least one container
    hashiqube0:   - all images without at least one container associated to them
    hashiqube0:   - all build cache
    ...
    ...
    ...
    ...
    ...
==> hashiqube0: Running provisioner: minikube (shell)...
    hashiqube0: Running: /var/folders/24/42plvkmn3313qkrvqjr3nqph0000gn/T/vagrant-shell20230830-87512-1inddv.sh
    hashiqube0: ++++
    hashiqube0: ++++ CPU is arm64
    hashiqube0: ++++
    hashiqube0: ++++
    hashiqube0: ++++ Delete Minikube
    hashiqube0: ++++
    hashiqube0: ++++
    hashiqube0: ++++ Check minikube proccesses
    hashiqube0: ++++
    hashiqube0: vagrant    26870  0.0  0.0   3480   892 ?        S    03:43   0:00 bash -c ps aux | grep -e dashboard -e kubectl || true
    hashiqube0: vagrant    26872  0.0  0.0   2844   612 ?        S    03:43   0:00 grep -e dashboard -e kubectl
    hashiqube0: * Successfully deleted all profiles
    hashiqube0: * Successfully purged minikube directory located at - [/home/vagrant/.minikube]
    hashiqube0: ++++
    hashiqube0: ++++ docker system prune -a
    hashiqube0: ++++
    hashiqube0: WARNING! This will remove:
    hashiqube0:   - all stopped containers
    hashiqube0:   - all networks not used by at least one container
    hashiqube0:   - all images without at least one container associated to them
    hashiqube0:   - all build cache
    hashiqube0:
    hashiqube0: Are you sure you want to continue? [y/N] Deleted build cache objects:
    hashiqube0: x83uqz87h2a6fwp1fpp45fzn0
    hashiqube0: v2m7ny8cvuc7n764tc6c05hzu
    hashiqube0: cq4i9bzxj95cg9n0o1dim2mo9
    hashiqube0: mb3prfplciljp652tht95a2xt
    hashiqube0: mhfd0fmadi5uk001j7iplazr6
    hashiqube0: vo76ep4wsgoktbncyqvbc9whp
    hashiqube0:
    hashiqube0: Total reclaimed space: 143.6MB
    hashiqube0: WARNING! This will remove:
    hashiqube0:   - all stopped containers
    hashiqube0:   - all networks not used by at least one container
    hashiqube0:   - all volumes not used by at least one container
    hashiqube0:   - all dangling images
    hashiqube0:   - all dangling build cache
    hashiqube0:
    hashiqube0: Are you sure you want to continue? [y/N] Total reclaimed space: 0B
    hashiqube0: Total reclaimed space: 0B
    hashiqube0: ++++
    hashiqube0: ++++ Installing Contrack
    hashiqube0: ++++
    hashiqube0: Reading package lists...
    hashiqube0: Building dependency tree...
    hashiqube0: Reading state information...
    hashiqube0: Suggested packages:
    hashiqube0:   nftables
    hashiqube0: The following NEW packages will be installed:
    hashiqube0:   conntrack ethtool socat
    hashiqube0: 0 upgraded, 3 newly installed, 0 to remove and 2 not upgraded.
    hashiqube0: Need to get 470 kB of archives.
    hashiqube0: After this operation, 1924 kB of additional disk space will be used.
    hashiqube0: Get:1 http://ports.ubuntu.com/ubuntu-ports focal/main arm64 conntrack arm64 1:1.4.5-2 [28.8 kB]
    hashiqube0: Get:2 http://ports.ubuntu.com/ubuntu-ports focal/main arm64 ethtool arm64 1:5.4-1 [126 kB]
    hashiqube0: Get:3 http://ports.ubuntu.com/ubuntu-ports focal/main arm64 socat arm64 1.7.3.3-2 [315 kB]
    hashiqube0: debconf: unable to initialize frontend: Dialog
    hashiqube0: debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 76, <> line 3.)
    hashiqube0: debconf: falling back to frontend: Readline
    hashiqube0: debconf: unable to initialize frontend: Readline
    hashiqube0: debconf: (This frontend requires a controlling tty.)
    hashiqube0: debconf: falling back to frontend: Teletype
    hashiqube0: dpkg-preconfigure: unable to re-open stdin:
    hashiqube0: Fetched 470 kB in 3s (143 kB/s)
    hashiqube0: Selecting previously unselected package conntrack.
(Reading database ... 43999 files and directories currently installed.)
    hashiqube0: Preparing to unpack .../conntrack_1%3a1.4.5-2_arm64.deb ...
    hashiqube0: Unpacking conntrack (1:1.4.5-2) ...
    hashiqube0: Selecting previously unselected package ethtool.
    hashiqube0: Preparing to unpack .../ethtool_1%3a5.4-1_arm64.deb ...
    hashiqube0: Unpacking ethtool (1:5.4-1) ...
    hashiqube0: Selecting previously unselected package socat.
    hashiqube0: Preparing to unpack .../socat_1.7.3.3-2_arm64.deb ...
    hashiqube0: Unpacking socat (1.7.3.3-2) ...
    hashiqube0: Setting up conntrack (1:1.4.5-2) ...
    hashiqube0: Setting up socat (1.7.3.3-2) ...
    hashiqube0: Setting up ethtool (1:5.4-1) ...
    hashiqube0: Processing triggers for man-db (2.9.1-1) ...
    hashiqube0: ++++
    hashiqube0: ++++ Launching Minikube
    hashiqube0: ++++
    hashiqube0: * minikube v1.31.2 on Ubuntu 20.04 (docker/arm64)
    hashiqube0: * Using the docker driver based on user configuration
    hashiqube0: * Using Docker driver with root privileges
    hashiqube0: * Starting control plane node minikube in cluster minikube
    hashiqube0: * Pulling base image ...
    hashiqube0: * Downloading Kubernetes v1.27.4 preload ...
    ...
    ...
    ...
    ...
    ...
==> hashiqube0: Running provisioner: gitlab (shell)...
    hashiqube0: Running: /var/folders/24/42plvkmn3313qkrvqjr3nqph0000gn/T/vagrant-shell20230830-87512-xvpgt9.sh
    hashiqube0: ++++
    hashiqube0: ++++ Cleanup
    hashiqube0: ++++
    hashiqube0: Error response from daemon: No such container: gitlab
    hashiqube0: Error response from daemon: No such container: gitlab
    hashiqube0: Error response from daemon: No such container: gitlab-runner
    hashiqube0: Error response from daemon: No such container: gitlab-runner
    hashiqube0: WARNING! This will remove:
    hashiqube0:   - all stopped containers
    hashiqube0:   - all networks not used by at least one container
    hashiqube0:   - all images without at least one container associated to them
    hashiqube0:   - all build cache
    hashiqube0:
    hashiqube0: Are you sure you want to continue? [y/N] Total reclaimed space: 0B
    hashiqube0: WARNING! This will remove:
    hashiqube0:   - all stopped containers
    hashiqube0:   - all networks not used by at least one container
    hashiqube0:   - all volumes not used by at least one container
    hashiqube0:   - all dangling images
    hashiqube0:   - all dangling build cache
    hashiqube0:
    hashiqube0: Are you sure you want to continue? [y/N] Total reclaimed space: 0B
    hashiqube0: NAME   	NAMESPACE	REVISION	UPDATED                                	STATUS  	CHART         	APP VERSION
    hashiqube0: traefik	default  	1       	2023-08-30 03:53:24.715624058 +0000 UTC	deployed	traefik-24.0.0	v2.10.4
    hashiqube0: Error: uninstall: Release not loaded: gitlab: release: not found
    hashiqube0: NAME   	NAMESPACE	REVISION	UPDATED                                	STATUS  	CHART         	APP VERSION
    hashiqube0: traefik	default  	1       	2023-08-30 03:53:24.715624058 +0000 UTC	deployed	traefik-24.0.0	v2.10.4
    hashiqube0: ++++
    hashiqube0: CPU is arm64
    hashiqube0: ++++
    hashiqube0: ++++
    hashiqube0: Ensure Minikube is running
    hashiqube0: ++++
    hashiqube0: Minikube is running
    hashiqube0: ++++
    hashiqube0: ++++ helm repo add gitlab https://charts.gitlab.io/
    hashiqube0: ++++
    hashiqube0: "gitlab" has been added to your repositories
    hashiqube0: ++++
    hashiqube0: ++++ helm repo update
    hashiqube0: ++++
    hashiqube0: Hang tight while we grab the latest from your chart repositories...
    hashiqube0: ...Successfully got an update from the "traefik" chart repository
    hashiqube0: ...Successfully got an update from the "gitlab" chart repository
    hashiqube0: ...Successfully got an update from the "bitnami" chart repository
    hashiqube0: Update Complete. ⎈Happy Helming!⎈
    hashiqube0: ++++
    hashiqube0: ++++ helm search repo gitlab
    hashiqube0: ++++
    hashiqube0: NAME                         	CHART VERSION	APP VERSION	DESCRIPTION
    hashiqube0: gitlab/gitlab                	7.3.0        	v16.3.0    	GitLab is the most comprehensive AI-powered Dev...
    hashiqube0: gitlab/gitlab-agent          	1.18.0       	v16.3.0    	GitLab Agent for Kubernetes is a way to integra...
    hashiqube0: gitlab/gitlab-omnibus        	0.1.37       	           	GitLab Omnibus all-in-one bundle
    hashiqube0: gitlab/gitlab-runner         	0.56.0       	16.3.0     	GitLab Runner
    hashiqube0: gitlab/gitlab-zoekt          	0.5.9        	0.0.6      	A Helm chart for deploying Zoekt as a search en...
    hashiqube0: gitlab/kubernetes-gitlab-demo	0.1.29       	           	GitLab running on Kubernetes suitable for demos
    hashiqube0: gitlab/apparmor              	0.2.0        	0.1.0      	AppArmor profile loader for Kubernetes
    hashiqube0: gitlab/auto-deploy-app       	0.8.1        	           	GitLab's Auto-deploy Helm Chart
    hashiqube0: gitlab/elastic-stack         	3.0.0        	7.6.2      	A Helm chart for Elastic Stack
    hashiqube0: gitlab/fluentd-elasticsearch 	6.2.8        	2.8.0      	A Fluentd Helm chart for Kubernetes with Elasti...
    hashiqube0: gitlab/knative               	0.10.0       	0.9.0      	A Helm chart for Knative
    hashiqube0: gitlab/plantuml              	0.1.17       	1.0        	PlantUML server
    hashiqube0: ++++
    hashiqube0: ++++ Launch Gitlab on minikube using Helm Charts
    hashiqube0: ++++
    hashiqube0: ++++
    hashiqube0: ++++ Helm install gitlab
    hashiqube0: ++++
    ...
    ...
    ...
    ...
    ...
    hashiqube0: ++++ Waiting for Gitlab to become available, (6/15) sleep 60s
    hashiqube0: gitlab-gitaly-0                               0/1     PodInitializing   0              6m1s
    hashiqube0: gitlab-gitlab-exporter-69c7ff875c-jvsww       1/1     Running           0              6m1s
    hashiqube0: gitlab-gitlab-shell-7b58f46bdf-t25p5          1/1     Running           0              6m1s
    hashiqube0: gitlab-kas-5b56ddf464-qnqp7                   1/1     Running           3 (3m7s ago)   6m1s
    hashiqube0: gitlab-kas-5b56ddf464-svszl                   0/1     PodInitializing   0              5m46s
    hashiqube0: gitlab-migrations-1-c7sfw                     1/1     Running           0              6m1s
    hashiqube0: gitlab-minio-8676d4f5bd-zhx77                 1/1     Running           0              6m1s
    hashiqube0: gitlab-minio-create-buckets-1-2wqrx           0/1     Completed         0              6m1s
    hashiqube0: gitlab-postgresql-0                           2/2     Running           0              6m1s
    hashiqube0: gitlab-redis-master-0                         2/2     Running           0              6m1s
    hashiqube0: gitlab-sidekiq-all-in-1-v2-86b4544bd8-w65t4   0/1     Init:2/3          0              6m1s
    hashiqube0: gitlab-toolbox-557cf9866-cd5fb                1/1     Running           0              6m1s
    hashiqube0: gitlab-webservice-default-86f6497f6f-2gchj    0/2     Init:2/3          0              6m1s
    hashiqube0: 16m         Normal    NodeHasSufficientMemory        node/minikube                                            Node minikube status is now: NodeHasSufficientMemory
    hashiqube0: 16m         Normal    NodeHasSufficientMemory        node/minikube                                            Node minikube status is now: NodeHasSufficientMemory
    hashiqube0: ++++ Waiting for Gitlab to become available, (7/15) sleep 60s
    hashiqube0: gitlab-gitaly-0                               0/1     Running     0              7m1s
    hashiqube0: gitlab-gitlab-exporter-69c7ff875c-jvsww       1/1     Running     0              7m1s
    hashiqube0: gitlab-gitlab-shell-7b58f46bdf-t25p5          1/1     Running     0              7m1s
    hashiqube0: gitlab-kas-5b56ddf464-qnqp7                   1/1     Running     3 (4m7s ago)   7m1s
    hashiqube0: gitlab-kas-5b56ddf464-svszl                   0/1     Running     0              6m46s
    hashiqube0: gitlab-migrations-1-c7sfw                     1/1     Running     0              7m1s
    hashiqube0: gitlab-minio-8676d4f5bd-zhx77                 1/1     Running     0              7m1s
    hashiqube0: gitlab-minio-create-buckets-1-2wqrx           0/1     Completed   0              7m1s
    hashiqube0: gitlab-postgresql-0                           2/2     Running     0              7m1s
    hashiqube0: gitlab-redis-master-0                         2/2     Running     0              7m1s
    hashiqube0: gitlab-sidekiq-all-in-1-v2-86b4544bd8-w65t4   0/1     Init:2/3    1 (12s ago)    7m1s
    hashiqube0: gitlab-toolbox-557cf9866-cd5fb                1/1     Running     0              7m1s
    hashiqube0: gitlab-webservice-default-86f6497f6f-2gchj    0/2     Init:2/3    1 (27s ago)    7m1s
    hashiqube0: 17m         Normal    NodeHasSufficientMemory        node/minikube                                            Node minikube status is now: NodeHasSufficientMemory
    hashiqube0: 17m         Normal    NodeHasSufficientMemory        node/minikube                                            Node minikube status is now: NodeHasSufficientMemory
    hashiqube0: ++++ Waiting for Gitlab to become available, (8/15) sleep 60s
    hashiqube0: gitlab-gitaly-0                               1/1     Running           0              8m1s
    hashiqube0: gitlab-gitlab-exporter-69c7ff875c-jvsww       1/1     Running           0              8m1s
    hashiqube0: gitlab-gitlab-shell-7b58f46bdf-t25p5          1/1     Running           0              8m1s
    hashiqube0: gitlab-kas-5b56ddf464-qnqp7                   1/1     Running           3 (5m7s ago)   8m1s
    hashiqube0: gitlab-kas-5b56ddf464-svszl                   1/1     Running           0              7m46s
    hashiqube0: gitlab-migrations-1-c7sfw                     1/1     Running           0              8m1s
    hashiqube0: gitlab-minio-8676d4f5bd-zhx77                 1/1     Running           0              8m1s
    hashiqube0: gitlab-minio-create-buckets-1-2wqrx           0/1     Completed         0              8m1s
    hashiqube0: gitlab-postgresql-0                           2/2     Running           0              8m1s
    hashiqube0: gitlab-redis-master-0                         2/2     Running           0              8m1s
    hashiqube0: gitlab-sidekiq-all-in-1-v2-86b4544bd8-w65t4   0/1     Running           0              8m1s
    hashiqube0: gitlab-toolbox-557cf9866-cd5fb                1/1     Running           0              8m1s
    hashiqube0: gitlab-webservice-default-86f6497f6f-2gchj    0/2     PodInitializing   0 (87s ago)    8m1s
    hashiqube0: 18m         Normal    NodeHasSufficientMemory        node/minikube                                            Node minikube status is now: NodeHasSufficientMemory
    hashiqube0: 18m         Normal    NodeHasSufficientMemory        node/minikube                                            Node minikube status is now: NodeHasSufficientMemory
    ...
    ...
    ...
    ...
    ...
    hashiqube0: ++++
    hashiqube0: ++++ Waiting for Gitlab to stabalize, sleep 60s
    hashiqube0: ++++
    hashiqube0: gitlab-gitaly-0                               1/1     Running     0               9m32s
    hashiqube0: gitlab-gitlab-exporter-69c7ff875c-jvsww       1/1     Running     0               9m32s
    hashiqube0: gitlab-gitlab-shell-7b58f46bdf-t25p5          1/1     Running     0               9m32s
    hashiqube0: gitlab-kas-5b56ddf464-qnqp7                   1/1     Running     3 (6m38s ago)   9m32s
    hashiqube0: gitlab-kas-5b56ddf464-svszl                   1/1     Running     0               9m17s
    hashiqube0: gitlab-migrations-1-c7sfw                     0/1     Completed   0               9m32s
    hashiqube0: gitlab-minio-8676d4f5bd-zhx77                 1/1     Running     0               9m32s
    hashiqube0: gitlab-minio-create-buckets-1-2wqrx           0/1     Completed   0               9m32s
    hashiqube0: gitlab-postgresql-0                           2/2     Running     0               9m32s
    hashiqube0: gitlab-redis-master-0                         2/2     Running     0               9m32s
    hashiqube0: gitlab-sidekiq-all-in-1-v2-86b4544bd8-w65t4   0/1     Running     0               9m32s
    hashiqube0: gitlab-toolbox-557cf9866-cd5fb                1/1     Running     0               9m32s
    hashiqube0: gitlab-webservice-default-86f6497f6f-2gchj    1/2     Running     0               9m32s
    hashiqube0: 20m         Normal    NodeHasSufficientMemory        node/minikube                                            Node minikube status is now: NodeHasSufficientMemory
    hashiqube0: 20m         Normal    NodeHasSufficientMemory        node/minikube                                            Node minikube status is now: NodeHasSufficientMemory
    hashiqube0: ++++
    hashiqube0: ++++ kubectl port-forward -n default service/gitlab-webservice-default 5580:8181 --address="0.0.0.0", (1/20) sleep 60s
    hashiqube0: ++++
    hashiqube0: ++++
    hashiqube0: ++++ kubectl port-forward -n default service/gitlab-webservice-default 5580:8181 --address="0.0.0.0", (2/20) sleep 60s
    hashiqube0: ++++
    hashiqube0: tcp        0      0 0.0.0.0:5580            0.0.0.0:*               LISTEN      121140/kubectl
    hashiqube0: ++++
    hashiqube0: ++++ kubectl port-forward -n default service/gitlab-webservice-default 80:8181 --address="0.0.0.0", (1/20) sleep 60s
    hashiqube0: ++++
    hashiqube0: ++++
    hashiqube0: ++++ kubectl port-forward -n default service/gitlab-webservice-default 80:8181 --address="0.0.0.0", (2/20) sleep 60s
    hashiqube0: ++++
    hashiqube0: tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      130328/kubectl
    hashiqube0: ++++
    hashiqube0: ++++ kubectl port-forward -n default service/gitlab-webservice-default 8181:8181 --address="0.0.0.0", (1/20) sleep 60s
    hashiqube0: ++++
    hashiqube0: ++++
    hashiqube0: ++++ kubectl port-forward -n default service/gitlab-webservice-default 8181:8181 --address="0.0.0.0", (2/20) sleep 60s
    hashiqube0: ++++
    hashiqube0: tcp        0      0 0.0.0.0:8181            0.0.0.0:*               LISTEN      139475/kubectl
    hashiqube0: ++++
    hashiqube0: ++++ kubectl port-forward -n default service/gitlab-gitlab-shell 32022:32022 --address="0.0.0.0", (1/20) sleep 60s
    hashiqube0: ++++
    hashiqube0: ++++
    hashiqube0: ++++ kubectl port-forward -n default service/gitlab-gitlab-shell 32022:32022 --address="0.0.0.0", (2/20) sleep 60s
    hashiqube0: ++++
    hashiqube0: tcp        0      0 0.0.0.0:32022           0.0.0.0:*               LISTEN      148590/kubectl
    hashiqube0: 200
    hashiqube0: ++++
    hashiqube0: ++++ Installing Gitlab-Runner
    hashiqube0: ++++
    hashiqube0: Detected operating system as Ubuntu/focal.
    hashiqube0: Checking for curl...
    hashiqube0: Detected curl...
    hashiqube0: Checking for gpg...
    hashiqube0: Detected gpg...
    hashiqube0: Running apt-get update... done.
    hashiqube0: Installing apt-transport-https... done.
    hashiqube0: Installing /etc/apt/sources.list.d/runner_gitlab-runner.list...done.
    hashiqube0: Importing packagecloud gpg key... done.
    hashiqube0: Running apt-get update... done.
    hashiqube0:
    hashiqube0: The repository is setup! You can now install packages.
    hashiqube0: ++++
    hashiqube0: ++++ Gitlab CE http://localhost:5580 and login with Username: root and below password:
    hashiqube0: jMh629reoQ7FqtillBmLQZPY69JUStSFATXD11T5wMk39NtNezqIKohcIIwoxwvl
    hashiqube0: ++++
    hashiqube0: ++++ Please login to Gitlab and create a project called test
    hashiqube0: ++++ Please follow the rest of the instructions here: http://localhost:3333/#/gitlab/README?id=you-are-here
    hashiqube0: ++++
```

The above Gitlab provision will look like this

![Gitlab provision](images/gitlab-provision.png?raw=true "Gitlab provision")

You can now login to Gitlab at http://localhost:5580 and login with Username `root` and the password printed out example: `jMh629reoQ7FqtillBmLQZPY69JUStSFATXD11T5wMk39NtNezqIKohcIIwoxwvl`

You can follow along with the rest of the documentation here: 
Locally: http://localhost:3333/gitlab/README?id=you-are-here
Hashiqube.com: https://hashiqube.com/gitlab/README?id=you-are-here
## You are here

You have just ran the Gitlab provisioner and Gitlab should now be installed.  

Please login with username __root__ and the password that was printed out
![Gitlab](images/gitlab-login-root-password.png?raw=true "Gitlab")

Now you should be logged into Gitlab, and you will see a page looking like this
![Gitlab](images/gitlab-first-login.png?raw=true "Gitlab")

Now let's create our first project in Gitlab
Click on Create a Project -> Create a Blank project and enter the project name as `test`

Select the namespace as `root` <br>
Make it a Public repository

And click `Create Project`

![Gitlab Create Project](images/gitlab-create-project.png?raw=true "Gitlab Create Project")

Our Test Repository has been created

![Gitlab Create Project](images/gitlab-created-test-project.png?raw=true "Gitlab Create Project")

Now we need to add our SSH key to our User Profile in Gitlab, we can then clone this repository locally, using our SSH keys as authentication. 

To do that, please navigate to Top Left, Click on your Profile Icon image and click on `Preferences`

![Gitlab Preferences](images/gitlab-navigate-to-preferences.png?raw=true "Gitlab Gitlab Preferences")

Now please navigate to `SSH Keys`
![Gitlab Preferences SSH Keys](images/gitlab-navigate-to-preferences-ssh-keys.png?raw=true "Gitlab Gitlab Preferences SSH Keys")

On your laptop in a Terminal Window, please do: 
`cat ~/.ssh/id_rsa.pub` It should look something like this 

```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIgkrDFTASaZYyJfGd0swmUZaol3JSZmO6D74230CtZjz/YrHq4QL34r5z4oPz9gO8f0l6kN8Hz6BEhAIzArg8kDI9lrsPXypCqlahE49cuzNH3C5GEC9MHo46U6+ZG2IOwCXjiP5ohnXyG8ho8N1BVpDa0xyVevy4COg4malaLVcRwP73YwgxiitNLWcq8k8nB riaan@Riaans-MacBook-Pro.local
```

Copy that key, we will enter it now, navigate back to Gitlab

![Gitlab Enter SSH Keys](images/gitlab-enter-ssh-keys.png?raw=true "Gitlab Gitlab Enter SSH Keys")

:bangbang: Be sure to remove the expiry date and click `Add Key`

![Gitlab Added SSH Keys](images/gitlab-added-ssh-keys.png?raw=true "Gitlab Gitlab Added SSH Keys")

## Clone Test Gitlab Repo

Now we have a method to authenticate to Gitlab, now we can clone our Test repository we created earlier! 

Navigate back to the home page of Gitlab, and click on your test repository. 

![Gitlab Test Repository](images/gitlab-navigate-to-test-project.png?raw=true "Gitlab Test Repository")

Now, to the right you will see a Clone Button, please click on that, and Copy the `Clone with SSH` link. 

:bangbang: The HTTP Link does not work currently, there is a BUG and i was unable to add the port `5580` in there. So please don't use that, it won;t work.

![Gitlab Clone with SSH Test Repository](images/gitlab-copy-ssh-clone-url-test-project.png?raw=true "Gitlab Clone with SSH Test Repository")

I will clone this to my `~/workspace/personal/test` directory, and I will use this command `git clone ssh://git@localhost:32022/root/test.git` 

The output is below

![Gitlab SSH Clone Test Repository](images/gitlab-ssh-clone-test-project.png?raw=true "Gitlab SSH Clone Test Repository")

## Add a gitlab-ci.yml Pipeline

Now that we have cloned the Test repository locally, we can add files to it. For our first file we are going to add a `.gitlab-ci.yml` Gitlab Pipeline file. 

So create a new file in the test reposiroty directory, called `.gitlab-ci.yml` with the following content

```
variables:
  REPOSITORY_URL: xxxxxxxxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/container

stages:
  - test
  - build
  - dev
  - stg
  - prd

test:
  stage: test
  script:
    - echo 'Here you can run tests'

build:
  stage: build
  script:
    - echo 'After Test stage was successful, here you can run build your container'

dev:
  stage: dev
  script:
    - echo 'After Build stage was successful, here you can run your Development environment deployment'

stg:
  stage: stg
  script:
    - echo 'After Dev stage was successful, here you can run your Staging environment deployment'

prd:
  stage: prd
  script:
    - echo 'After Stg stage was successful, here you can run your Production environment deployment'
```

Here is a screenshot of what I did, and the commands will be below that you can copy and past. 

![Gitlab add pipeline file to Test Repository](image/gitlab-add-pipeline-file-to-test-repository.png?raw=true "Gitlab add pipeline file to Test Repository")

`cd test`

`nano .gitlab-ci.yml`

`git status`
```
On branch main
Your branch is up to date with 'origin/main'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	.gitlab-ci.yml

nothing added to commit but untracked files present (use "git add" to track)
```

`git add .gitlab-ci.yml`

`git commit -am "adding .gitlab-ci.yml pipeline file"`
```
[main 0fe4e09] adding .gitlab-ci.yml pipeline file
 1 file changed, 35 insertions(+)
 create mode 100644 .gitlab-ci.yml
```

`git push`
```
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 10 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 573 bytes | 573.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
To ssh://localhost:32022/root/test.git
   29c151b..0fe4e09  main -> main
```

Now when you navigate back to the Gitlab Test Reposiroty and you refresh the page, you will see that our file have been added. 

![Gitlab Test Repository](images/gitlab-added-pipeline-file.png?raw=true "Gitlab Test Repository")

In the next section we will add a Runner to run our pipeline, enjoy! 

## Runners
https://docs.gitlab.com/runner/register/index.html#docker

Let's add a Gitlab runner for our `test` project, please navigate to Settings -> CI/CD 

![Gitlab Navigate to Settings CICD](images/gitlab-navigate-to-settings-cicd.png?raw=true "Gitlab Navigate to Settings CICD")

Now please expand Runners 

![Gitlab Expand Runners](images/gitlab-navigate-to-settings-cicd-expand-runners.png?raw=true "Gitlab Expand Runners")

and click on `New Project Runner`

:bangbang: You can leave everything default, but please Click `Run Untagged Jobs`

![Gitlab New Project Runner](images/gitlab-add-test-project-runners.png?raw=true "Gitlab New Project Runner")

And click on Create Runner. 

Remember that BUG I mentioned above? 
:bug: https://gitlab.com/gitlab-org/charts/gitlab/-/issues/4205

![Gitlab New Project Runner Bug](images/gitlab-add-test-project-runners-bug.png?raw=true "Gitlab New Project Runner Bug")

Well you will now get a blank page, because it redirects us to the URL: http://localhost/root/test/-/runners/1/register?platform=linux

BUT IT SHOULD ACTUALLY BE: 

http://localhost:5580/root/test/-/runners/1/register?platform=linux

So please add the `:5580` after localhost in the URL adrress bar and press enter

![Gitlab Create Project Runner Correct Page](images/gitlab-add-test-project-runners-correct-page.png?raw=true "Gitlab Create Project Runner Correct Page")

## Register our Runner

You see the text in Register Runner, Step 1? Copy that, mine looks like below, BUT LOK CLOSELY, You see the BUG again? It's missing the port!! `:5580` 

WRONG!!
```
gitlab-runner register  --url http://localhost  --token glrt-NRYUnqLZ2yzyutC1MYVV
```

So remember to add the port there so that it looks like 

CORRECT!!
```
gitlab-runner register  --url http://localhost:5580  --token glrt-NRYUnqLZ2yzyutC1MYVV
```

Now let's head over to our Hashiqube instance, in our hashiqube directory, we can do

`vagrant ssh`

![Vagrant SSH](images/gitlab-vagrant-ssh-register-runner.png?raw=true "Vagrant SSH")

And we'll register our runner in the Hashiqube instance, be sure to remember to add the port in there 

Now you can do step 3 where we run the runner

`gitlab-runner run`

![Vagrant SSH Gitlab Runner Run](images/gitlab-vagrant-ssh-register-runner-gitlab-runner-run.png?raw=true "Vagrant SSH Gitlab Runner Run")

When you now go back to your Gitlab page you will see :tada: You've created a new runner!

![Vagrant SSH Gitlab Runner Run Success](images/gitlab-vagrant-ssh-register-runner-gitlab-runner-run-success.png?raw=true "Vagrant SSH Gitlab Runner Run Success")

You can now click on Go to the Runners page and you will see it is registered and ready to accept jobs

![Vagrant SSH Gitlab Runners Page](images/gitlab-runners-page-registered.png?raw=true "Vagrant SSH Gitlab Runners Page")

## Run Pipeline

Ok, so we have a Test Project, We have a registered Runner and we have a Pipeline, so let's run our pipeline. Please navigate on your left to `Build - Pipelines`

![Build Pipelines Run](images/gitlab-test-project-run-pipeline.png?raw=true "Build Pipelines Run")

and you will see in the next screen your pipeline is running

![Build Pipelines in progress](images/gitlab-test-project-run-pipeline-in-progress.png?raw=true "Build Pipelines in progress")

To see what the Pipeline Jobs did, please navigate to `Jobs` on the left and then click on one of those jobs

![Build Pipelines Job Details](images/gitlab-test-project-pipeline-job.png?raw=true "Build Pipelines Job Details")

And that's it for now folks, thank you for taking the time to go through this tutorial with me and thank you for using Hashiqube, I hope you had fun! 



