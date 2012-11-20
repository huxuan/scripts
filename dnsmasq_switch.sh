# +-----------------------------------------------------------------------------
# | File: dnsmasq_switch
# | Author: huxuan
# | E-mail: i(at)huxuan.org
# | Created: 2012-11-19
# | Last modified: 2012-11-19
# | Description:
# |     Switch dnsmasq configuration easily
# | Reference:
# |     http://felixc.at/Dnsmasq
# |
# | Copyrgiht (c) 2012 by huxuan. All rights reserved.
# | License GPLv3
# +-----------------------------------------------------------------------------

# Default
DNS=114.114.114.114
Server1=8.8.8.8
Server2=8.8.4.4

case "$1" in
  # Telecom
  t)
    DNS=202.103.24.68
    ;;
  # Unicom
  u)
    DNS=218.104.111.114
    ;;
  # Cernet
  c)
    DNS=202.112.20.131
    ;;
  # Cernet 2
  c2)
    DNS=202.114.0.242
  ;;
  p | pku )
    DNS=162.105.129.27
    Server1=162.105.129.27
    Server2=162.105.129.26
  ;;
  *)
    echo "Waring: No corresponding configure available, use default"
esac

sudo sed -i "s|^\(server.*\)/[^/]*$|\1/$DNS|" /etc/dnsmasq.d/server-china.conf
sudo sed -i "1s/^\(server=\).*$/\1$Server1/" /etc/dnsmasq.d/server-global.conf
sudo sed -i "2s/^\(server=\).*$/\1$Server2/" /etc/dnsmasq.d/server-global.conf
sudo service dnsmasq restart
