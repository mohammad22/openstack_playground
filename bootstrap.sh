#!/bin/bash

apt-get update
apt install git-core
id -u stack &>/dev/null || useradd -s /bin/bash -d /opt/stack -m stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/stack
su -l stack -c  'if [ ! -d  ./devstack ]; then git clone https://github.com/openstack-dev/devstack.git -b stable/pike devstack/; fi'
cat > /opt/stack/devstack/local.conf <<EOF
[[local|localrc]]
ADMIN_PASSWORD=secret
DATABASE_PASSWORD=secret
RABBIT_PASSWORD=secret
SERVICE_PASSWORD=secret
HOST_IP=192.168.33.10
RECLONE=yes
EOF
chown stack:stack /opt/stack/devstack/local.conf
su -l stack -c '/opt/stack/devstack/stack.sh'    

