#!/bin/bash

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Set 8.8.8.8 in /etc/resolv.conf"
echo -e '\e[38;5;198m'"++++ "
cat <<EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Installing Base packages"
echo -e '\e[38;5;198m'"++++ "

export DEBIAN_FRONTEND=noninteractive
export PATH=$PATH:/root/.local/bin
sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes update -q -o Dpkg::Progress-Fancy="1" -o Acquire::CompressionTypes::Order::=gz # < /dev/null > /dev/null
sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes upgrade -q -o Dpkg::Progress-Fancy="1" # < /dev/null > /dev/null
sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes install -q -o Dpkg::Progress-Fancy="1" swapspace jq curl unzip software-properties-common bzip2 git make python3 python3-pip python3-dev python3-venv python3-virtualenv python3-passlib golang-go apt-utils ntp update-motd toilet figlet nano iputils-ping dnsutils iptables net-tools telnet mc iproute2 psmisc # < /dev/null > /dev/null
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1 --force
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1 --force
systemctl restart swapspace
python -V
sudo python -V
pip -V
sudo pip -V

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Running Apt Clean"
echo -e '\e[38;5;198m'"++++ "

sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes autoremove -qq < /dev/null > /dev/null
sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes clean -qq < /dev/null > /dev/null
sudo rm -rf /var/lib/apt/lists/partial

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Set MOTD Message of the Day"
echo -e '\e[38;5;198m'"++++ "

# set MOTD using toilet-fonts
sudo mkdir -p /etc/update-motd.d

cat <<EOF | sudo tee /etc/update-motd.d/00-header
#!/bin/bash
/usr/bin/toilet --gay -f standard hashiqube0 -w 170
printf "%s"
EOF

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ END BOOTSTRAP $(date '+%Y-%m-%d %H:%M:%S')"
echo -e '\e[38;5;198m'"++++ "
