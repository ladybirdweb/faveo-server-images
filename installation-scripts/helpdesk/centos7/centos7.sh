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

echo 
echo "###################################"
echo "   Installling PHP and Apache     "
echo "###################################"
echo
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


# While loop for arguments
while test $# -gt 0; do
        case "$1" in
                -domainname)
                    shift
                    domainname=$1         
                    shift 
                    ;;
                -email)
                    shift
                    email=$1
                    shift
                    ;;
                -host_root_dir)
                    shift
                    host_root_dir=$1
                    shift
                    ;;
                -license)
                    shift
                    license=$1
                    shift
                    ;;
                -orderno)
                    shift
                    orderno=$1
                    shift
                    ;;
                -db_root_pw)
                    shift
                    db_root_pw=$1
                    shift
                    ;;
                -db_name)
                    shift
                    db_name=$1
                    shift
                    ;;
                -db_user)
                    shift
                    db_user=$1
                    shift
                    ;;
                -db_user_pw)
                    shift
                    db_user_pw=$1
                    shift
                    ;;
                *)
                echo "$1 is not a recognized flag!"
                exit 1;
                ;;
        esac
done  


curl https://billing.faveohelpdesk.com/download/faveo\?order_number\=$orderno\&serial_key\=$license --output faveo.zip

mkdir -p /var/www/faveo/faveo-helpdesk
cp faveo.zip /var/www/faveo/faveo-helpdesk
cd /var/www/faveo/faveo-helpdesk
unzip faveo.zip
chown -R apache:apache /var/www/
chmod -R 755 /var/www
chcon -R -t httpd_sys_rw_content_t /var/www/faveo/faveo-helpdesk


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

echo
echo "###################################"
echo "     Installling Mysql server      "
echo "###################################"
echo

yum install expect -y

SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"\r\"
expect \"Change the root password?\"
send \"y\r\"
expect \"New password:\"
send \"$db_root_pw\r\"
expect \"Re-enter new password:\"
send \"$db_root_pw\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

echo "$SECURE_MYSQL"


mysql -u root -p$db_root_pw -e "CREATE DATABASE $db_name;GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'localhost' IDENTIFIED BY '$db_user_pw';FLUSH PRIVILEGES;"


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

echo
echo "######################################################"
echo "   Installing Redis and supervisor configuration      "
echo "######################################################"
echo
#Installl Redis and supervisor


sed -i "s/supervised no*/supervised systemd/" /etc/redis.conf

systemctl start redis.service

systemctl enable redis


yum install -y supervisor

systemctl enable supervisord
systemctl start supervisord


mv /etc/supervisord.conf /etc/supervisord.conf.bkp
wget https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/installation-scripts/helpdesk/centos7/supervisord.conf

mv supervisord.conf /etc/supervisord.conf


systemctl restart supervisord 

sudo supervisorctl reread 

sudo supervisorctl update

sudo supervisorctl start faveo-worker:*

#Installing Lets Ecncrypt SSL
echo 
echo "##############################################################################"
echo "                 Installing Let's Encrypt SSL                                 "
echo "##############################################################################"

yum install epel-release mod_ssl -y
yum install python-certbot-apache -y

certbot certonly --noninteractive --webroot --agree-tos -m $email -d $domainname -w $host_root_dir
certbot --apache -d $domainname

echo "0 0 * * 1 /usr/bin/certbot renew >> /var/log/sslrenew.log"  > /var/spool/cron/root

echo
echo "##################################"
echo "    Faveo installed successfully  "
echo "##################################"
echo
echo "Access Faveo page on browser https://$domainname or with your server IP"
echo "Set up database details, given at the time of installtion"
echo 
