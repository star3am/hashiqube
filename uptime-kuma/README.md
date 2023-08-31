# Uptime Kuma

https://github.com/louislam/uptime-kuma

![Uptime Kuma](images/uptime-kuma-logo.png?raw=true "Uptime Kuma")

Uptime Kuma is an easy-to-use self-hosted monitoring tool.

To get Uptime Kuma running, please do: 

`vagrant up --provision-with basetools,docker,docsify,uptime-kuma`

```log
Bringing machine 'hashiqube0' up with 'docker' provider...
==> hashiqube0: Running provisioner: basetools (shell)...
    hashiqube0: Running: /var/folders/24/42plvkmn3313qkrvqjr3nqph0000gn/T/vagrant-shell20230831-63375-8zjy13.sh
    hashiqube0: Python 3.9.5
    hashiqube0: Python 3.9.5
    hashiqube0: pip 20.0.2 from /usr/lib/python3/dist-packages/pip (python 3.8)
    hashiqube0: pip 20.0.2 from /usr/lib/python3/dist-packages/pip (python 3.8)
    hashiqube0: #!/bin/bash
    hashiqube0: /usr/bin/toilet --gay -f standard hashiqube0 -w 170
    hashiqube0: printf "%s"
    hashiqube0: END BOOTSTRAP 2023-08-31 00:52:34
    ...
    ...
    ...
    ...
==> hashiqube0: Running provisioner: docker (shell)...
    hashiqube0: Running: /var/folders/24/42plvkmn3313qkrvqjr3nqph0000gn/T/vagrant-shell20230831-63375-762ln9.sh
    hashiqube0: Warning: apt-key output should not be parsed (stdout is not a terminal)
    hashiqube0: OK
    hashiqube0: CPU is arm64
    hashiqube0: Hit:1 https://download.docker.com/linux/ubuntu focal InRelease
    hashiqube0: Hit:2 https://deb.nodesource.com/node_14.x focal InRelease
    hashiqube0: Hit:3 http://ports.ubuntu.com/ubuntu-ports focal InRelease
    hashiqube0: Hit:4 http://ports.ubuntu.com/ubuntu-ports focal-updates InRelease
    hashiqube0: Hit:5 http://ports.ubuntu.com/ubuntu-ports focal-backports InRelease
    hashiqube0: Hit:6 http://ports.ubuntu.com/ubuntu-ports focal-security InRelease
    hashiqube0: Reading package lists...
    hashiqube0: registry
    hashiqube0: registry
    ...
    ...
    ...
    ...
    hashiqube0: ++++ open http://localhost:8889 in your browser
    hashiqube0: ++++ you can also run below to get apache2 version from the docker container
    hashiqube0: ++++ vagrant ssh -c "docker ps; docker exec -it apache2 /bin/bash -c 'apache2 -t -v; ps aux'"
    ...
    ...
    ...
    ...
==> hashiqube0: Running provisioner: docsify (shell)...
    hashiqube0: Running: /var/folders/24/42plvkmn3313qkrvqjr3nqph0000gn/T/vagrant-shell20230831-63375-dcua02.sh
    hashiqube0:
    ...
    ...
    ...
    ...
    hashiqube0: /usr/bin/docsify -> /usr/lib/node_modules/docsify-cli/bin/docsify
    hashiqube0: + docsify-cli@4.4.4
    hashiqube0: updated 1 package in 11.599s
    hashiqube0: ++++ Docsify: http://localhost:3333/
    ...
    ...
    ...
    ...
==> hashiqube0: Running provisioner: uptime-kuma (shell)...
    hashiqube0: Running: /var/folders/24/42plvkmn3313qkrvqjr3nqph0000gn/T/vagrant-shell20230831-63375-vsn5e6.sh
    hashiqube0: ++++
    hashiqube0: ++++ Cleanup
    hashiqube0: ++++
    hashiqube0: uptime-kuma
    hashiqube0: uptime-kuma
    hashiqube0: WARNING! This will remove:
    hashiqube0:   - all stopped containers
    hashiqube0:   - all networks not used by at least one container
    hashiqube0:   - all images without at least one container associated to them
    hashiqube0:   - all build cache
    hashiqube0:
    hashiqube0: Are you sure you want to continue? [y/N] Deleted Images:
    hashiqube0: untagged: louislam/uptime-kuma:1
    hashiqube0: untagged: louislam/...
    ...
    ...
    ...
    hashiqube0: Digest: sha256:8e40008dc16ff4ef8d8042c2c6fa5c744ffc7afdc01b1d3ec23dc3e9ef8d627d
    hashiqube0: Status: Downloaded newer image for louislam/uptime-kuma:1
    hashiqube0: 6d8e14c64b6f952ab73098f981cd32909472880d0ecce3c29999e7fbcd5c244b
    hashiqube0: ++++ Uptime Kuma: http://localhost:3001/ and login with Username: admin and Password: P@ssw0rd
```

## Summary

After provision, you can access Kuma on http://localhost:3001 and login with Username: admin and Password: P@ssw0rd

![Uptime Kuma](images/uptime-kuma-dashboard.png?raw=true "Uptime Kuma")

Uptime Kuma also has a status page

![Uptime Kuma](images/uptime-kuma-status-page.png?raw=true "Uptime Kuma")
