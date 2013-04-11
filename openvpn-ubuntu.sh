#!/bin/bash
#
# File: openvpn-ubuntu
# Author: huxuan <i(at)huxuan.org>
# Created: 2013-04-11
# Last modified: 2013-04-11
# Description:
#   OpenVPN installation for Ubuntu
# Usage:
#   For normal situation:
#       sudo ./openvpn-ubuntu.sh
#   If you are fucked by GFW, you need to config `proxychains` then:
#       sudo proxychains ./openvpn-ubuntu.sh
#
# Copyrgiht (c) 2013 by huxuan. All rights reserved.
# License GPLv3

# add key
wget -O - http://repos.openvpn.net/repos/repo-public.gpg | apt-key add -

# add source list
wget -P /etc/apt/sources.list.d/ \
    http://repos.openvpn.net/repos/apt/conf/repos.openvpn.net-precise-snapshots.list

# update and install
apt-get update
apt-get install openvpn easy-rsa
