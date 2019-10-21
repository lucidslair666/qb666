#!/bin/bash
adduser --disabled-password --gecos "Admin" admin
echo admin:`openssl rand -base64 32` | chpasswd
echo "admin    ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
mkdir -p /home/admin/.ssh/
echo "ssh-rsa ..." > /home/admin/.ssh/authorized_keys
chmod 700 /home/admin/.ssh/
chmod 600 /home/admin/.ssh/authorized_keys
chown -R admin:admin /home/admin/.ssh
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
systemctl reload sshd
echo 'LC_ALL="en_US.UTF-8"' >> /etc/environment
apt-get -y update ; apt-get -y upgrade
apt-get -y install python-software-properties software-properties-common
apt-get -y install mc htop
apt-get -y install s3cmd percona-xtrabackup
ufw allow OpenSSH
yes | ufw enable
ufw app list
df -h
