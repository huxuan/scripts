#!/bin/bash
# +-----------------------------------------------------------------------------
# | File: nginx-ubuntu
# | Author: huxuan
# | E-mail: i(at)huxuan.org
# | Created: 2013-02-25
# | Last modified: 2013-02-26
# | Description:
# |     Nginx installation for Ubuntu
# |
# | Copyrgiht (c) 2013 by huxuan. All rights reserved.
# | License GPLv3
# +-----------------------------------------------------------------------------

# add ppa
sudo add-apt-repository ppa:nginx/stable

# update and install
sudo apt-get update
sudo apt-get install nginx
