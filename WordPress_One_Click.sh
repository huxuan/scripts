#!/bin/bash
# +-----------------------------------------------------------------------------
# | File: WordPress_One_Click
# | Author: huxuan
# | E-mail: i(at)huxuan.org
# | Created: 2012-09-17
# | Last modified: 2012-09-18
# | Description:
# |     Install WordPress by One Click!
# |     This script will config Nginx, MySQL & WordPress file automatically.
# |     You are supposed use it after using lnmp (http://lnmp.org/)
# |
# | Reference:
# |     vhost.sh in lnmp project.
# |
# | Copyrgiht (c) 2012 by huxuan & xehost.com. All rights reserved.
# | License GPLv3
# +-----------------------------------------------------------------------------

# Check whether use root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, use sudo sh $0"
    exit 1
fi

nginx_bin_dir="/usr/local/nginx/sbin"
echo "Please Nignx Bin Directory:"
read -p "(Default Nginx Bin Directory: $nginx_bin_dir):" nginx_bin_dir
[ "$nginx_bin_dir" = "" ] && nginx_bin_dir="/usr/local/nginx/sbin"
echo "==========================="
echo Nginx Bin Directory="$nginx_bin_dir"
echo "==========================="

if [ ! -d $nginx_bin_dir ]; then
    echo "Nginx Bin Directory does not exist. Creating ..."
    mkdir -p $nginx_bin_dir
fi

echo

nginx_vhost_dir="/usr/local/nginx/conf/vhost"
echo "Please Nignx Vhost Directory:"
read -p "(Default Nginx Vhost Directory: $nginx_vhost_dir):" nginx_vhost_dir
[ "$nginx_vhost_dir" = "" ] && nginx_vhost_dir="/usr/local/nginx/conf/vhost"
echo "==========================="
echo Nginx Vhost Directory="$nginx_vhost_dir"
echo "==========================="

if [ ! -d $nginx_vhost_dir ]; then
    echo "Nginx Vhost Directory does not exist. Creating ..."
    mkdir -p $nginx_vhost_dir
fi

echo

domain="www.xehost.com"
echo "Please input Domain:"
read -p "(Default Domain: $domain):" domain
[ "$domain" = "" ] && domain="www.xehost.com"

echo "============================="
if [ ! -f "$nginx_vhost_dir/$domain.conf" ]; then
    echo "Domain=$domain"
else
    echo "$domain is exist!"
    read -p "Press Ctrl+C to stop or this process will OVERWRITE it!"
fi
echo "============================="

read -p "Do you want to add more Domain(s)? (y/n)" add_more_domainame

if [ "$add_more_domainame" == 'y' ]; then
    echo "Type Domain List, example(blog.xehost.com wp.xehost.com wordpress.xehost.com):"
    read moredomain
    echo "============================="
    if [ "$moredomain" = "" ]; then
        echo Domain List is EMPTY, skip ...
        moredomainame=""
    else
        echo Domain List="$moredomain"
        moredomainame=" $moredomain"
    fi
    echo "============================="
fi

echo

install_dir="/home/wwwroot/$domain"
echo "Please input Install Directory:"
read -p "(Default Install Directory: $install_dir):" install_dir
[ "$install_dir" = "" ] && install_dir="/home/wwwroot/$domain"
echo "==========================="
echo Install Directory="$install_dir"
echo "==========================="

if [ ! -d $install_dir ]; then
    echo Install Directory does not exist. Creating ...
    mkdir -p $install_dir
fi

echo

download_dir="$HOME/Downloads"
echo "Please input Download Directory (for WordPress):"
read -p "(Default Donwload Directory: $download_dir):" download_dir
[ "$download_dir" = "" ] && download_dir="$HOME/Downloads"
echo "==========================="
echo Download Directory="$download_dir"
echo "==========================="

if [ ! -d $download_dir ]; then
    echo Download Directory does not exist. Creating ...
    mkdir -p $download_dir
fi

echo

mysql_root="root"
echo "Please input MySQL Root:"
read -p "(Default MySQL Root: $mysql_root):" mysql_root
[ "$mysql_root" = "" ] && mysql_root="root"
echo "==========================="
echo MySQL Root="$mysql_root"
echo "==========================="

echo

mysql_root_passwd="root"
echo "Please input MySQL Root PassWord:"
read -p "(Default MySQL Root PassWord: $mysql_root_passwd):" mysql_root_passwd
[ "$mysql_root_passwd" = "" ] && mysql_root_passwd="root"
echo "==========================="
echo MySQL Root PassWord="$mysql_root_passwd"
echo "==========================="

echo

mysql_user=$USER
echo "Please input MySQL User (to be created):"
read -p "(Default MySQL User: $mysql_user):" mysql_user
[ "$mysql_user" = "" ] && mysql_user=$USER
echo "==========================="
echo MySQL User="$mysql_user"
echo "==========================="

echo

mysql_user_passwd="xehost"
echo "Please input MySQL User PassWord (to be created):"
read -p "(Default MySQL User PassWord: $mysql_user_passwd):" mysql_user_passwd
[ "$mysql_user_passwd" = "" ] && mysql_user_passwd="xehost"
echo "==========================="
echo MySQL User PassWord="$mysql_user_passwd"
echo "==========================="

echo

mysql_db="${mysql_user}_wp"
echo "Please input WordPress Database (to be created):"
read -p "(Default WordPress Database: $mysql_db):" mysql_db
[ "$mysql_db" = "" ] && mysql_db="${mysql_user}_wp"
echo "==========================="
echo WordPress Database="$mysql_db"
echo "==========================="

echo

read -p "Press Any Key to start Installation!"

if [ -f "$download_dir/latest.tar.gz" ]; then
    echo Deleting old WordPress file ...
    rm $download_dir/latest.tar.gz
fi

echo Downloading WordPress ...
wget -P $download_dir http://wordpress.org/latest.tar.gz

echo Extracting WordPress ...
tar -zxf $download_dir/latest.tar.gz --strip-components 1 -C $install_dir

echo Creating wp-config.php from wp-config-sample.php
sed -e s/database_name_here/$mysql_db/g -e s/username_here/$mysql_user/g \
    -e s/password_here/$mysql_user_passwd/g $install_dir/wp-config-sample.php \
    > $install_dir/wp-config.php

echo Droping potential existing MySQL User ...
SQL_DROP_USER="DROP USER '$mysql_user'@'localhost'"
mysql -u$mysql_root -p$mysql_root_passwd -e "$SQL_DROP_USER"

echo Creating MySQL User ...
SQL_CREATE_USER="CREATE USER '$mysql_user'@'localhost' IDENTIFIED BY '$mysql_user_passwd'"
mysql -u$mysql_root -p$mysql_root_passwd -e "$SQL_CREATE_USER"

echo Granting Privilege for MySQL User ...
SQL_GRANT_PRIVILEGE="GRANT ALL PRIVILEGES ON \`$mysql_user\_%\`.* TO '$mysql_user'@'localhost'"
mysql -u$mysql_root -p$mysql_root_passwd -e "$SQL_GRANT_PRIVILEGE"

echo Droping potential existing Database ...
SQL_DROP_DB="DROP DATABASE $mysql_db"
mysql -u$mysql_root -p$mysql_root_passwd -e "$SQL_DROP_DB"

echo Creating corresponding Database ...
SQL_CREATE_DB="CREATE DATABASE $mysql_db"
mysql -u$mysql_root -p$mysql_root_passwd -e "$SQL_CREATE_DB"

echo Creating Vhost Conf file ...
cat >/usr/local/nginx/conf/vhost/$domain.conf<<EOF
server
{
    listen 80;
    server_name $domain$moredomainame;
    index index.php;
    root $install_dir;

    include wordpress.conf;
    location ~ .*\.(php|php5)?$
    {
        fastcgi_pass unix:/tmp/php-cgi.sock;
        fastcgi_index index.php;
        include fcgi.conf;
    }

    location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$
    {
        expires 30d;
    }

    location ~ .*\.(js|css)?$
    {
        expires 12h;
    }
}
EOF

echo Testing Nginx configure file ...
$nginx_bin_dir/nginx -t

echo Reloading Nginx ...
$nginx_bin_dir/nginx -s reload

echo "==========================="
echo Harry!
echo You have WordPress installed Successfully !
echo View it at $domain !
echo "==========================="
