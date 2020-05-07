#!/bin/sh
#
#  Faveo Helpdesk Ubuntu 18 Auto Installation Script
#  Tested on Ubuntu 18.04.4 & Faveo Helpdesk v3.3.1
#
#  Copyright (C) 2020 Ladybird Web Solution Pvt Ltd
#
#  Author Vijay Kumar
#
#  * Note: This script does not contain any kind of error checking or
#    management. If you are looking for professional, worry-free
#    installation by a Faveo Certified Professional do not hesitate to
#    contact me using the email listed above.
#
#  This script is intended to be run on a fresh Ubuntu 18 installation
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
apt-get update -y
apt-get install nano -y
apt-get install unzip -y
apt-get install wget -y
apt-get install zip -y

# Create firewall rules
FWZONE=$(firewall-cmd --get-default-zone)
firewall-cmd --zone=$FWZONE --add-service=http --permanent
firewall-cmd --zone=$FWZONE --add-service=https --permanent
firewall-cmd --reload

useradd -r www-data
usermod -G www-data www-data
mkdir -p /home/www-data

apt-get install -y software-properties-common
add-apt-repository ppa:ondrej/php

apt-get install -y curl git apache2
apt-get install -y php7.3 php7.3-mysql php7.3-curl php7.3-json php7.3-cgi php7.3-xsl
apt-get install php7.3-zip -y
apt-get install php7.3-imap -y
apt-get install php7.3-mbstring -y
apt-get install php7.3-zip -y
apt-get install php7.3-bcmath -y
apt-get install php7.3-ldap -y
apt-get install php7.3-soap -y
apt install php libapache2-mod-php7.3
apt-get install redis-server
apt-get install php7.3-redis

a2enmod php7.3
a2dismod php7.2
a2dismod php7.1
sudo update-alternatives --set php /usr/bin/php7.3

a2enmod rewrite
service apache2 restart

apt-get install -y mysql-server


#Installing Ioncube Encoder
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
tar xvfz ioncube_loaders_lin_x86-64.tar.gz
cp ioncube/ioncube_loader_lin_7.3.so /usr/lib/php/20190902
sed -i '2 a zend_extension = "/usr/lib/php/20190902/ioncube_loader_lin_7.3.so"' /etc/php/7.3/apache2/php.ini
sed -i '2 a zend_extension = "/usr/lib/php/20190902/ioncube_loader_lin_7.3.so"' /etc/php/7.3/cli/php.ini

#Downloading Faveo from Billing
echo -n 'please enter your order number: '
read ordernumber

echo -n 'please enter your serial key: '
read serialkey

curl https://billing.faveohelpdesk.com/download/faveo\?order_number\=${ordernumber}\&serial_key\=${serialkey} --output faveo.zip

mkdir -p /var/www/faveo/faveo-helpdesk

cp faveo.zip /var/www/faveo/faveo-helpdesk

cd /var/www/faveo/faveo-helpdesk

unzip faveo.zip

#Changing permissions
chown -R www-data:www-data /var/www/
chmod -R 755 /var/www/


cat <<EOF > /etc/apache2/sites-available/faveo.conf

<VirtualHost *:80>

ServerName localhost

ServerAdmin webmaster@localhost

DocumentRoot /var/www/faveo/faveo-helpdesk/public

<Directory /var/www/faveo/faveo-helpdesk>

AllowOverride All

</Directory>

ErrorLog ${APACHE_LOG_DIR}/error.log

CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>
EOF

a2ensite faveo.conf
a2dissite 000-default.conf

#Chnaging Execution Time
sed -i "s/max_execution_time = .*/max_execution_time = 120/" /etc/php/7.3/apache2/php.ini
sed -i "s/max_execution_time = .*/max_execution_time = 120/" /etc/php/7.3/cli/php.ini

curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#Adding cron
echo "* * * * * /usr/bin/php7.3 /var/www/faveo/faveo-helpdesk/artisan schedule:run >> /dev/null 2>&1" > /var/spool/cron/www-data
chmod 700 /var/spool/cron/www-data

service mysql start
service enable mysql
mysql_secure_installation

#Creating Database for Faveo
echo -n 'Please set Database Name for Faveo: '
read db_name

echo -n 'Please Database UserName for Faveo: '
read db_user

echo -n 'Please set Database User Password for Faveo: '
read db_pass


mysql -u root -p -e "CREATE DATABASE ${db_name};GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_user}'@'localhost' IDENTIFIED BY '${db_pass}';FLUSH PRIVILEGES;"


#Enable web services
systemctl enable apache2
systemctl restart apache2

#Install Faveo throgh CLI
#cd /var/www/faveo/faveo-helpdesk
#php artisan install:faveo
#php artisan install:db

echo "Faveo installed successfully"
echo "You can access it on browser with your server IP/Domain"
echo "Set up database details, given at the time of installtion"
