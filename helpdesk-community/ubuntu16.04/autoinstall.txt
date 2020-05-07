#!/bin/sh
#
#  Faveo-Helpdesk Ubuntu 16.04 Xenial LTS Auto Installation Script
#  Tested on Ubuntu 16.04 and Faveo 1.0.7.5
#
#  Copyright (C) 2016 Ladybird Web Solution Pvt Ltd
#
#  Author: Mathieu Aubin 
#
#  * Note: This script does not contain any kind of error checking or
#    management. If you are looking for professional, worry-free
#    installation by a Faveo Certified Professional do not hesitate to
#    contact me using the email listed above.
#
#  This script is intended to be run on a fresh Ubuntu 15.10 Wily install
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, see <http://www.gnu.org/licenses>.
#
getAttention() {
echo "";
read -rsp $'\E[1;37;41m Press any key to continue... \E[0m\n' -n1 key
}
checkUser() {
if [[ $EUID -ne 0 ]]; then
    printf '\E[1;37;41m This script must be run as root, type> sudo !! to sudo script \E[0m\n' 1>&2
    exit 1
fi
}
displayWarning() {
    printf '\E[1;37;41m THIS SCRIPT IS INTENDED FOR A FRESH UBUNTU 16.04 LTS INSTALL \E[0m\n'; sleep 1;
    printf '\E[1;37;41m THIS SCRIPT DOES NOT CONTAIN ANY ERROR CHECKING SO BE SMART \E[0m\n'; sleep 1;
    printf '\E[1;37;41m IT IS NOT MADE FOR A SYSTEM THAT ALREADY HAS PACKAGES INSTALLED \E[0m\n'; sleep 2;
    read -rsp $'\n Press any key to continue or CTRL+C to quit...\n' -n1 key;
}
showHeader() {
    printf '\n\E[1;37;42m Faveo-Helpdesk CE Ticketing System - LEMP Install Ubuntu 16.04 LTS \E[0m\n'
    printf ' Copyright 2016 Ladybird Web Solution Pvt Ltd\n'
    printf ' Author Mathieu Aubin\n'
    printf ' Visit us online at - \E[1mhttps://www.faveohelpdesk.com\E[0m\n'
    printf ' Fork it on GitHub  - \E[1mhttps://github.com/ladybirdweb/faveo-helpdesk.git\E[0m\n\n'
    printf ' If you make an error while running this script, you can re-run it anytime.\E[0m\n\n'
}
/usr/bin/clear;
showHeader;
checkUser;
displayWarning;

# adding user in case it's not in the system for some odd reason
useradd -r www-data && /usr/sbin/usermod -G www-data www-data;

# nginx stable repository
wget -O /tmp/nginx-gpg.key http://nginx.org/keys/nginx_signing.key && apt-key add /tmp/nginx-gpg.key && \
wget -O /etc/apt/sources.list.d/Nginx-stable.list https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/ubuntu16/nginx-stable-repo.txt && \

# ondrej/php ppa repository
wget -O /tmp/ondrej-ppa-gpg.key https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/ubuntu16/ppa_ondrej-php-gpg-key.txt && apt-key add /tmp/ondrej-ppa-gpg.key && \
wget -O /etc/apt/sources.list.d/ondrej-php-trusty.list https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/ubuntu16/ppa_ondrej-php-repo.txt && \

# mariadb 5.5 repository
wget -O /tmp/mariadb-gpg.key https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/ubuntu16/mariadb-gpg-key.txt && apt-key add /tmp/mariadb-gpg.key && \
wget -O /etc/apt/sources.list.d/MariaDB101.list https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/ubuntu16/mariadb101-repo.txt && \

# updating apt sources and upgrading
apt-get update && apt-get upgrade -y && \

# installing mandatory packages
apt-get install curl software-properties-common git sl mlocate dos2unix bash-completion openssl mariadb-server nginx \
php5.6-soap php5.6-json php5.6-fpm php5.6-cli php5.6-gd php5.6-mbstring php5.6-common \
php5.6-mcrypt php5.6-xml php5.6-curl php5.6-imap php5.6-mysql php5.6-xmlrpc -y && updatedb;
sleep 1;

# stopping services
service nginx stop && \
service php5.6-fpm stop && \

# getting files for nginx configuration
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.back;
wget -O /etc/nginx/nginx.conf https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/ubuntu16/faveo-nginx-conf.txt && \
wget -O /etc/nginx/conf.d/faveo-helpdesk.conf https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/ubuntu16/faveo-helpdesk-conf.txt && \
rm -rf /etc/nginx/conf.d/default.conf;

# creating our own php-fpm pool
wget -O /etc/php/5.6/fpm/pool.d/faveo_php.conf https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/ubuntu16/faveo_php-conf.txt && \

# creating directories and cloning repository
mkdir -p /opt/faveo/log && mkdir -p /opt/faveo/run;
git clone https://github.com/ladybirdweb/faveo-helpdesk.git /opt/faveo/faveo-helpdesk && \
chown www-data:www-data /opt/faveo -R && updatedb && \

# poping up nano for the user to edit server_name value
printf "\n\E[1m I will open up a text editor, you need to change the server_name value to match your server \E[0m\n";
curl https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/ubuntu16/nginx-help;
printf "\n\E[1m Using nano editor, CTRL+O saves the file. CTRL+X to exit. \E[0m\n";
getAttention;
nano /etc/nginx/conf.d/faveo-helpdesk.conf && \
clear;

# starting mysql and securing installation
service mysql start;
clear && \
printf "\n\E[1m I will now secure your MySQL installation, read the following \E[0m\n";
curl https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/ubuntu16/mysql-help.txt;
getAttention;
mysql_secure_installation && \

# getting blank sql db template and popping up nno for the user to edit values according to his/her install
wget -O /tmp/faveo-createdb.sh https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/ubuntu16/createdb.txt && chmod +x /tmp/faveo-createdb.sh && \
clear && \
printf "\n\E[1m I will open up a text editor, you need to change the values to match your MySQL installation \E[0m";
printf "\n\E[1m Using nano editor, CTRL+O saves the file. CTRL+X to exit. \E[0m\n";
getAttention;
nano /tmp/faveo-createdb.sh && dos2unix /tmp/faveo-createdb.sh && sh /tmp/faveo-createdb.sh;

# starting all installed services
service php5.6-fpm start && sleep 1;
service nginx start && sleep 1;
service mysql start && sleep 1;

# installing composer globally - run using 'composer' only on cli
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# installing default cronjobs
crontab -l ; echo -e "# Faveo-Helpdesk Cronjobs\n# This gets email tickets every 5 minutes, change to suit your needs\n*/5 * * * * /usr/bin/curl http://127.0.0.1/readmails\n# This runs the notification everyday at 23:55, change for another time if you want.\n55 23 * * * /usr/bin/curl http://127.0.0.1/notification" | crontab - && sleep 1;
clear;

# output services status for the user to see/troubleshoot if problem
printf "\n\E[1;37;42m *** Services Check *** \E[0m\n\n"; sleep 1;
service nginx status | grep 'Active:' | grep --color=auto 'dead\|failed\|running'; sleep 1;
service mysql status | grep 'Active:' | grep --color=auto 'dead\|failed\|running'; sleep 1;
service php5.6-fpm status | grep 'Active:' | grep --color=auto 'dead\|failed\|running'; sleep 1;
printf "\n\E[1m If you see a problem in the above use /usr/sbin/service 'name of service' status to get detailed error message. \E[0m\n";
printf "\n\E[1m All should be installed. Jump aboard Faveo-Helpdesk train!! \E[0m\n";
getAttention;
clear;

sl;
printf '\n\E[1;37;42m Now simply map your server IP with domain name and open the domain in browser to finish the installation. Enjoy!\E[0m\n'
