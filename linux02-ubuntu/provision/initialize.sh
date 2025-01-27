#!/usr/bin/env bash

server_name="a4l-linux02"
password="msx@9797"
domain="msx.local"
domain_ip="192.168.56.2"

#update and upgrade os
sudo apt update -y
sudo apt upgrade -y

#install packages required
sudo apt install realmd libnss-sss libpam-sss sssd sssd-tools adcli samba-common-bin oddjob oddjob-mkhomedir packagekit resolvconf tree ncdu vim curl -y

##change hostname

hostnamectl set-hostname $server_name.$domain

#add domain entry in /etc/resolvconf/resolv.conf.d/head
cd /etc/resolvconf/resolv.conf.d/
cat <<EOT > head
# Dynamic resolv.conf(5) file for glibc resolver(3) generated by resolvconf(8)
#     DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN
# 127.0.0.53 is the systemd-resolved stub resolver.
# run "systemd-resolve --status" to see details about the actual nameservers.

search msx.local
nameserver 192.168.56.2
EOT

# apply changes to /etc/resolv.conf
sudo resolvconf -u

