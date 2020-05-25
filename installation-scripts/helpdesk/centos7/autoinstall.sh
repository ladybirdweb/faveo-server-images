#!/bin/sh
#
#  Faveo Helpdesk CentOS 7 Auto Installation Script
#   Tested on Cent OS 7 & Faveo Helpdesk v3.3.1
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
yum -y update
yum -y install nano
yum -y install wget
yum -y install unzip
yum -y install zip

# Create firewall rules
FWZONE=$(firewall-cmd --get-default-zone)
firewall-cmd --zone=$FWZONE --add-service=http --permanent
firewall-cmd --zone=$FWZONE --add-service=https --permanent
firewall-cmd --reload

yum -y install epel-release
yum -y install https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm

#Add MariaDB REPO
cat <<EOF > /etc/yum.repos.d/MariaDB.repo
# MariaDB 10.3 CentOS repository list - created 2018-05-25 19:02 UTC
# http://downloads.mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.3/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
EOF

#Install php and httpd services
yum -y install yum-utils
yum-config-manager --enable remi-php73
yum install -y git curl openssl httpd
yum -y install MariaDB-server MariaDB-client
yum -y install php php-cli php-common php-fpm php-gd php-mbstring php-pecl-mcrypt php-mysqlnd php-odbc php-pdo php-xml  php-opcache php-imap php-bcmath php-ldap php-pecl-zip php-soap
yum install redis -y
yum install -y php-pecl-redis.x86_64


#Ioncube Installation
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
tar xfz ioncube_loaders_lin_x86-64.tar.gz

cp ioncube/ioncube_loader_lin_7.3.so /usr/lib64/php/modules
sed -i '2 a zend_extension = "/usr/lib64/php/modules/ioncube_loader_lin_7.3.so"' /etc/php.ini


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
chown -R apache:apache /var/www/
chmod -R 755 /var/www

cat <<EOF > /etc/httpd/conf.d/faveo-helpdesk.conf
<VirtualHost *:80>
ServerName localhost
ServerAdmin webmaster@localhost
DocumentRoot /var/www/faveo/faveo-helpdesk/public
<Directory /var/www/faveo/faveo-helpdesk>
AllowOverride All
</Directory>
ErrorLog /var/log/httpd/faveo-error.log
</VirtualHost>
EOF

curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
#mv composer.phar /usr/bin/composer
#chmod +x /usr/bin/composer

echo "* * * * * /usr/bin/php /var/www/faveo/faveo-helpdesk/artisan schedule:run >> /dev/null 2>&1" > /var/spool/cron/apache
systemctl enable mariadb
systemctl start mariadb
mysql_secure_installation

echo -n 'Please set Database Name for Faveo: '
read db_name

echo -n 'Please Database UserName for Faveo: '
read db_user

echo -n 'Please set Database User Password for Faveo: '
read db_pass


mysql -u root -p -e "CREATE DATABASE ${db_name};GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_user}'@'localhost' IDENTIFIED BY '${db_pass}';FLUSH PRIVILEGES;"

#Change Execution Time
sed -i "s/max_execution_time = .*/max_execution_time = 120/" /etc/php.ini

#fix to run with SELinux enforcing
#semanage fcontext -a -t httpd_sys_content_t "/var/www/faveo/faveo-helpdesk(/.*)?"
#restorecon -R /var/www/faveo/faveo-helpdesk
setenforce 0

#Restart Webservice and database
systemctl enable httpd
systemctl restart httpd 
systemctl restart mysql


echo "Faveo installed successfully"
echo "You can access it on browser with your server IP/Domain"
echo "Set up database details, given at the time of installtion"