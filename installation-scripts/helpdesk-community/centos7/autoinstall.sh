#!/bin/sh
#
#  Faveo Helpdesk Community CentOS 7 Auto Installation Script
#  Tested on 7.0, 7.2
#
#  Copyright (C) 2020 Ladybird Web Solution Pvt ltd
#
#  Author Mathieu Aubin
#
#  * Note: This script does not contain any kind of error checking or
#    management. If you are looking for professional, worry-free
#    installation by a Faveo Certified Professional do not hesitate to
#    contact me using the email listed above.
#
#  This script is intended to be run on a fresh CentOS 7 installation
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
    printf '\E[1;37;41m THIS SCRIPT IS INTENDED FOR A FRESH CENTOS 7 INSTALL \E[0m\n'; sleep 1;
    printf '\E[1;37;41m THIS SCRIPT DOES NOT CONTAIN ANY ERROR CHECKING SO BE SMART \E[0m\n'; sleep 1;
    printf '\E[1;37;41m IT IS NOT MADE FOR A SYSTEM THAT ALREADY HAS PACKAGES INSTALLED \E[0m\n'; sleep 2;
    read -rsp $'\n Press any key to continue or CTRL+C to quit...\n' -n1 key;
}
showHeader() {
    printf '\n\E[1;37;42m Faveo-Helpdesk CE Ticketing System - LEMP Install CentOS 7 \E[0m\n'
    printf ' Copyright 2016 Ladybird Web Solution Pvt Ltd\n'
    printf ' Author Mathieu Aubin \n'
    printf ' Visit us online at - \E[1mhttps://www.faveohelpdesk.com\E[0m\n'
    printf ' Fork it on GitHub  - \E[1mhttps://github.com/ladybirdweb/faveo-helpdesk.git\E[0m\n\n'
    printf ' If you make an error while running this script, you can re-run it anytime.\E[0m\n\n'
}
/usr/bin/clear;
showHeader;
checkUser;
displayWarning;

# adding user because its not in the system by default
/usr/sbin/useradd -r www-data && /usr/sbin/usermod -G www-data www-data;

# remi repository
/usr/bin/wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/centos7/epel-gpg-key.txt && \
/usr/bin/wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-remi https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/centos7/remi-gpg-key.txt && \
/usr/bin/wget -O /etc/yum.repos.d/remi-php56-safe.repo https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/centos7/remi-php56-safe-repo.txt && \

# epel repository
/usr/bin/wget -O /etc/yum.repos.d/epel.repo https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/centos7/epel-repo.txt && \

# mariadb 5.5 repository
/usr/bin/wget -O /etc/yum.repos.d/MariaDB.repo https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/centos7/mariadb55-repo.txt && \

# nginx stable repository
/usr/bin/wget -O /etc/yum.repos.d/Nginx-stable.repo https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/centos7/nginx-stable-repo.txt && \

# update the system
/usr/bin/yum update -y && \

# install mandatory packages
/usr/bin/yum install php-cli phpunit php-fpm php-mysql php-mcrypt php-gd php-json php-curl php-imap php-mbstring nginx git sl mlocate dos2unix bash-completion openssl mariadb-server -y && \
sleep 1;

# stopping services
/usr/bin/systemctl stop nginx && \
/usr/bin/systemctl stop php-fpm && \

# getting files for nginx configuration
/usr/bin/mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.back;
/usr/bin/wget -O /etc/nginx/nginx.conf https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/centos7/faveo-nginx-conf.txt && \
/usr/bin/wget -O /etc/nginx/conf.d/faveo-helpdesk.conf https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/centos7/faveo-helpdesk-conf.txt && \
/usr/bin/rm -rf /etc/nginx/conf.d/default.conf;

# creating our own php-fpm pool
/usr/bin/wget -O /etc/php-fpm.d/faveo_php.conf https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/centos7/faveo_php-conf.txt && \

# creating directories and cloning repository
/usr/bin/mkdir -p /opt/faveo/log && /usr/bin/mkdir -p /opt/faveo/run;
/usr/bin/git clone https://github.com/ladybirdweb/faveo-helpdesk.git /opt/faveo/faveo-helpdesk && \
chown www-data:www-data /opt/faveo -R && /usr/bin/updatedb && \

# poping up nano for the user to edit server_name value
printf "\n\E[1m I will open up a text editor, you need to change the server_name value to match your server \E[0m\n";
/usr/bin/curl https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/centos7/nginx-help.txt;
printf "\n\E[1m Using nano editor, CTRL+O saves the file. CTRL+X to exit. \E[0m\n";
getAttention;
/usr/bin/nano /etc/nginx/conf.d/faveo-helpdesk.conf && \
/usr/bin/clear && \
/usr/bin/systemctl start mysql;
/usr/bin/clear;

# starting mysql and securing installation
printf "\n\E[1m I will now secure your MySQL installation, read the following \E[0m\n";
/usr/bin/curl https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/centos7/mysql-help.txt;
getAttention;
/usr/bin/mysql_secure_installation && \

# getting blank sql db template and popping up nno for the user to edit values according to his/her install
/usr/bin/wget -O /tmp/faveo-createdb.sh https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk-community/centos7/createdb.txt && /usr/bin/chmod +x /tmp/faveo-createdb.sh && \
/usr/bin/clear;
printf "\n\E[1m I will open up a text editor, you need to change the values to match your MySQL installation \E[0m";
printf "\n\E[1m Using nano editor, CTRL+O saves the file. CTRL+X to exit. \E[0m\n";
getAttention;
/usr/bin/nano /tmp/faveo-createdb.sh && /usr/bin/dos2unix /tmp/faveo-createdb.sh && /bin/sh /tmp/faveo-createdb.sh;

# starting installed services
/usr/bin/systemctl start php-fpm && sleep 1;
/usr/bin/systemctl start nginx && sleep 1;
/usr/bin/systemctl restart mysql && sleep 1;
/usr/bin/curl -sS https://getcomposer.org/installer | /usr/bin/php -- --install-dir=/usr/local/bin --filename=composer

# making sure services autostart on boot
/usr/bin/systemctl enable mysql && /usr/bin/systemctl enable php-fpm && /usr/bin/systemctl enable nginx && sleep 1;
/sbin/chkconfig php-fpm on && /sbin/chkconfig nginx on && /sbin/chkconfig mysql on && sleep 1;

# installing default cronjobs
/usr/bin/crontab -l ; echo -e "# Faveo-Helpdesk Cronjobs\n# This gets email tickets every 5 minutes, change to suit your needs\n*/5 * * * * /usr/bin/curl http://127.0.0.1/readmails\n# This runs the notification everyday at 23:55, change for another time if you want.\n55 23 * * * /usr/bin/curl http://127.0.0.1/notification" | /usr/bin/crontab - && sleep 1;
#export EDITOR="/usr/bin/nano";
#printf "\n\E[1m To create Faveo-Helpdesk required cron-job, I will open up a text editor.\E[0m";
#printf "\n\E[1m You need to change the values to match your server, either with a domain or a ip.\E[0m";
#printf "\n\E[1m Using nano editor, CTRL+O saves the file. CTRL+X to exit. \E[0m\n";
#getAttention;
#/usr/bin/crontab -e && /usr/bin/clear; sleep 1;
/usr/bin/clear;

# ouput services status for the user to see/troubleshoot if problem
printf "\n\E[1;37;42m *** Services Check *** \E[0m\n\n"; sleep 1;
/usr/bin/systemctl status nginx | grep 'Active:' | grep --color=auto 'dead\|failed\|running'; sleep 1;
/usr/bin/systemctl status mysql | grep 'Active:' | grep --color=auto 'dead\|failed\|running'; sleep 1;
/usr/bin/systemctl status php-fpm | grep 'Active:' | grep --color=auto 'dead\|failed\|running'; sleep 1;
printf "\n\E[1m If you see a problem in the above use /usr/bin/systemctl status 'name of service' to get detailed error message. \E[0m\n";
printf "\n\E[1m All should be installed. Jump aboard Faveo-Helpdesk train!! \E[0m\n";
getAttention;
/usr/bin/clear;

# having too much fun with sl... i know
sl;
printf '\n\E[1;37;42m Now simply point your browser to your domain to finish up Faveo-Helpdesk installation. Enjoy!\E[0m\n'
