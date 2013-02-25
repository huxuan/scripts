#!/bin/bash
# +-----------------------------------------------------------------------------
# | File: nginx-ubuntu
# | Author: huxuan
# | E-mail: i(at)huxuan.org
# | Created: 2013-02-25
# | Last modified: 2013-02-25
# | Description:
# |     Nginx installation for Ubuntu
# |
# | Copyrgiht (c) 2013 by huxuan. All rights reserved.
# | License GPLv3
# +-----------------------------------------------------------------------------

# Get Ubuntu release codename
CODENAME=$(lsb_release -sc)

# Add apt key
wget -q http://nginx.org/keys/nginx_signing.key -O- | sudo apt-key add -

# Add source list
sudo tee /etc/apt/sources.list.d/nginx.list << EOF
deb http://nginx.org/packages/ubuntu/ $CODENAME nginx
deb-src http://nginx.org/packages/ubuntu/ $CODENAME nginx
EOF

# update and install
sudo apt-get update
sudo apt-get install nginx
