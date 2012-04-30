#!/bin/bash
# +-----------------------------------------------------------------------------
# | File: fprint-ubuntu
# | Author: huxuan
# | E-mail: i(at)huxuan.org
# | Created: 2012-04-30
# | Last modified: 2012-04-30
# | Description:
# |     Install fingerprint to Ubuntu
# |
# | Copyrgiht (c) 2012 by huxuan. All rights reserved.
# | License GPLv3
# +-----------------------------------------------------------------------------

# add ppa
add-apt-repository ppa:fingerprint/fprint

# update
apt-get update

# install
sudo apt-get install libfprint0 fprint-demo libpam-fprintd gksu-polkit

# help
echo "Now you can set fingerprint in 'System Settings' -> 'User Accounts'"
