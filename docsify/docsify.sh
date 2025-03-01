#!/bin/bash

# https://github.com/nodesource/distributions#installation-instructions

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --batch --dearmor -o /etc/apt/keyrings/nodesource.gpg

NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

sudo apt-get update
sudo apt-get install -qq --assume-yes nodejs < /dev/null > /dev/null

sudo npm i docsify-cli -g #--loglevel=error
cd /vagrant
# This generates SUMMARY.md which is the menu for Docsify
# Example output
# find . -maxdepth 2 -name '*.md' | grep -v SUMMARY | grep -v "\./README" | cut -d "/" -f2 | sort | awk 'BEGIN { print "* [Home](README.md)\n" } { FS=" "} { print "  * ["toupper(substr($0,0,1))tolower(substr($0,2))"]("$1"/README.md)" }'
# * [Home](README.md)
#
#   * [Ansible](ansible/README.md)
#   ...
#   * [Prometheus-grafana](prometheus-grafana/README.md)
#   * [Sonarqube](sonarqube/README.md)
sudo find . -maxdepth 2 -name '*.md' | grep -v SUMMARY | grep -v "\./README" | cut -d "/" -f2 | sort | awk 'BEGIN { print "* [Home](README.md)\n" } { FS=" "} { print "  * ["toupper(substr($0,0,1))tolower(substr($0,2))"]("$1"/README.md)" }' > SUMMARY.md
# sudo pkill node
# sleep 3
sudo sh -c "echo \"16384\" > /proc/sys/fs/inotify/max_user_watches"
sudo touch /var/log/docsify.log
sudo chmod 777 /var/log/docsify.log

# increase file watchers
sudo sysctl fs.inotify.max_user_watches=524288
sudo sysctl -p
sudo sysctl -a | grep max_user_watches

sudo nohup docsify serve --port 3333 . > /var/log/docsify.log 2>&1 &
echo -e '\e[38;5;198m'"++++ Docsify: http://localhost:3333/"
