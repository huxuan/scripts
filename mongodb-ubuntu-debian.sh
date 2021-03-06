#!/bin/bash
# +-----------------------------------------------------------------------------
# | File: mongodb-ubuntu-debian
# | Author: huxuan
# | E-mail: i(at)huxuan.org
# | Created: 2012-04-29
# | Last modified: 2012-04-29
# | Description:
# |     MongoDB installation for Ubuntu and Debian like *nix
# |
# | Copyrgiht (c) 2012 by huxuan. All rights reserved.
# | License GPLv3
# +-----------------------------------------------------------------------------

# Add GPG key
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

# Add source list
echo "deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen" \
    | sudo tee /etc/apt/sources.list.d/mongodb.list

# update and install
sudo apt-get update
sudo apt-get install mongodb-10gen
