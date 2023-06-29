# Portainer
https://www.portainer.io/

MAKING DOCKER MANAGEMENT EASY.
Build and manage your Docker environments with ease today.

## Provision
`vagrant up --provision-with portainer`                                                                 
```
Bringing machine 'user.local.dev' up with 'virtualbox' provider...
==> user.local.dev: Checking if box 'ubuntu/xenial64' version '20190918.0.0' is up to date...
==> user.local.dev: [vagrant-hostsupdater] Checking for host entries
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: Running provisioner: portainer (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200112-42662-1na3ws3.sh
    user.local.dev: Error response from daemon: No such container: portainer
    user.local.dev: Error: No such container: portainer
    user.local.dev: WARNING! This will remove:
    user.local.dev:   - all stopped containers
    user.local.dev:   - all networks not used by at least one container
    user.local.dev:   - all images without at least one container associated to them
    user.local.dev:   - all build cache
    user.local.dev:
    user.local.dev: Are you sure you want to continue? [y/N]
    user.local.dev: Total reclaimed space: 0B
    user.local.dev: WARNING! This will remove:
    user.local.dev:   - all stopped containers
    user.local.dev:   - all networks not used by at least one container
    user.local.dev:   - all volumes not used by at least one container
    user.local.dev:   - all dangling images
    user.local.dev:   - all dangling build cache
    user.local.dev:
    user.local.dev: Are you sure you want to continue? [y/N]
    user.local.dev: Total reclaimed space: 0B
    user.local.dev: portainer_data
    user.local.dev: Unable to find image 'portainer/portainer:latest' locally
    user.local.dev: latest:
    user.local.dev: Pulling from portainer/portainer
    user.local.dev: d1e017099d17: Pulling fs layer
    user.local.dev: cc61cd4105c3: Pulling fs layer
    user.local.dev: d1e017099d17: Verifying Checksum
    user.local.dev: d1e017099d17: Download complete
    user.local.dev: d1e017099d17: Pull complete
    user.local.dev: cc61cd4105c3: Verifying Checksum
    user.local.dev: cc61cd4105c3: Download complete
    user.local.dev: cc61cd4105c3: Pull complete
    user.local.dev: Digest: sha256:c016f0e9b92b2dd4fe097d91ace2f21ed3ce34ade43ee2a95d3d4da1e984b96f
    user.local.dev: Status: Downloaded newer image for portainer/portainer:latest
    user.local.dev: 52fdd1ac0b0aeacbec0cf6d85023ff29ab5185b859000eabd158a34eaab034e9
    user.local.dev: ++++ Portainer: http://localhost:9333
```

## Using Portainer  
Please open http://localhost:9333

![Portainer](images/portainer.png?raw=true "Portainer")
