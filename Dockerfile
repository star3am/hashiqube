# https://betterprogramming.pub/managing-virtual-machines-under-vagrant-on-a-mac-m1-aebc650bc12c
# https://github.com/rofrano/vagrant-docker-provider

FROM ubuntu:noble

ENV DEBIAN_FRONTEND=noninteractive

# Install packages needed for SSH and interactive OS
RUN apt-get update -qq < /dev/null > /dev/null
RUN apt-get -y install -qq \
        openssh-server \
        passwd \
        sudo \
        man-db \
        curl \
        wget \
        vim-tiny < /dev/null > /dev/null

COPY ./hashiqube/basetools.sh .
RUN bash ./basetools.sh; \
    rm ./basetools.sh;

RUN apt-get -qq clean < /dev/null > /dev/null
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Enable systemd (from Matthew Warman's mcwarman/vagrant-provider)
RUN find /lib/systemd/system/sysinit.target.wants -mindepth 1 -not -name "systemd-tmpfiles-setup.service" -delete; \
    find /lib/systemd/system/multi-user.target.wants -mindepth 1 -not -name "systemd-user-sessions.service" -delete; \
    rm -f /etc/systemd/system/*.wants/*; \
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*; \
    rm -f /lib/systemd/system/anaconda.target.wants/*;

# Enable ssh for vagrant
RUN systemctl enable ssh.service;
EXPOSE 22

# Create the vagrant user
RUN useradd -m -G sudo -s /bin/bash vagrant && \
    echo "vagrant:vagrant" | chpasswd && \
    echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant && \
    chmod 440 /etc/sudoers.d/vagrant

# Generate unique SSH keys for vagrant user
RUN mkdir -p /home/vagrant/.ssh && \
    chmod 700 /home/vagrant/.ssh && \
    ssh-keygen -t rsa -b 4096 -f /home/vagrant/.ssh/id_rsa -N "" && \
    cp /home/vagrant/.ssh/id_rsa.pub /home/vagrant/.ssh/authorized_keys && \
    chmod 600 /home/vagrant/.ssh/authorized_keys && \
    chown -R vagrant:vagrant /home/vagrant/.ssh

# Store the private key in a location that can be accessed during provisioning
RUN mkdir -p /vagrant/ssh_keys && \
    cp /home/vagrant/.ssh/id_rsa /vagrant/ssh_keys/vagrant_id_rsa && \
    chmod 600 /vagrant/ssh_keys/vagrant_id_rsa

# Run the init daemon
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
