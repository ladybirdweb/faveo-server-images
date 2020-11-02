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
#While loop for Arguments
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


getAttention() {
echo "";
read -rsp $'\E[1;37;41m Press any key to continue... \E[0m\n' -n1 key
}
apt-get update -y
apt-get install nano -y
apt-get install unzip -y
apt-get install wget -y
apt-get install zip -y



useradd -r www-data
usermod -G www-data www-data
mkdir -p /home/www-data

apt-get install -y software-properties-common
add-apt-repository ppa:ondrej/php -y


echo 
echo "###################################"
echo "   Installling PHP and Apache     "
echo "###################################"
echo

apt-get install -y curl git apache2
apt-get install -y php7.3 php7.3-mysql php7.3-curl php7.3-json php7.3-cgi php7.3-xsl
apt-get install php7.3-zip -y
apt-get install php7.3-imap -y
apt-get install php7.3-mbstring -y
apt-get install php7.3-zip -y
apt-get install php7.3-bcmath -y
apt-get install php7.3-ldap -y
apt-get install php7.3-soap -y
apt-get install php7.3-gd -y
apt install php libapache2-mod-php7.3 -y
apt-get install redis-server -y
apt-get install php7.3-redis -y

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



curl https://billing.faveohelpdesk.com/download/faveo\?order_number\=$orderno\&serial_key\=$license --output faveo.zip

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


echo
echo "###################################"
echo "     Installling Mysql server      "
echo "###################################"
echo

service mysql start
service enable mysql

apt install expect -y

SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Press y|Y for Yes, any other key for No:\"
send \"\r\"
expect \"New password:\"
send \"$db_root_pw\r\"
expect \"Re-enter new password:\"
send \"$db_root_pw\r\"
expect \"Remove anonymous users? (Press y|Y for Yes, any other key for No) :\"
send \"y\r\"
expect \"Disallow root login remotely? (Press y|Y for Yes, any other key for No) :\"
send \"y\r\"
expect \"Remove test database and access to it? (Press y|Y for Yes, any other key for No) :\"
send \"y\r\"
expect \"Reload privilege tables now? (Press y|Y for Yes, any other key for No) :\"
send \"y\r\"
expect eof
")

echo "$SECURE_MYSQL"



mysql -u root -p$db_root_pw -e "CREATE DATABASE $db_name;GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'localhost' IDENTIFIED BY '$db_user_pw';FLUSH PRIVILEGES;"


#Enable web services
systemctl enable apache2
systemctl restart apache2



echo
echo "######################################################"
echo "   Installing Redis and supervisor configuration      "
echo "######################################################"
echo

sed -i "s/supervised no*/supervised systemd/" /etc/redis/redis.conf

sudo systemctl start redis-server.service
sudo systemctl restart redis-server.service
sudo systemctl enable redis-server.service
sudo apt-get install supervisor -y

cat << EOF > /etc/supervisor/conf.d/faveo-worker.conf
[program:faveo-worker]
process_name=%(program_name)s_%(process_num)02d
command=php  /var/www/faveo/faveo-helpdesk/artisan queue:work redis --sleep=3 --tries=3
autostart=true
autorestart=true
numprocs=8
redirect_stderr=true
stdout_logfile=/var/www/faveo/faveo-helpdesk/storage/logs/worker.log

[program:faveo-recur]
process_name=%(program_name)s_%(process_num)02d
command=php  /var/www/faveo/faveo-helpdesk/artisan queue:work redis --queue=recurring --sleep=3 --tries=3
autostart=true
autorestart=true
numprocs=1
redirect_stderr=true
stdout_logfile=/var/www/faveo/faveo-helpdesk/storage/logs/worker.log

[program:faveo-Reports]
process_name=%(program_name)s_%(process_num)02d
command=php  /var/www/faveo/faveo-helpdesk/artisan queue:work redis --queue=reports --sleep=3 --tries=3
autostart=true
autorestart=true
user=www-data
numprocs=1
redirect_stderr=true
stdout_logfile=/var/www/faveo/faveo-helpdesk/storage/logs/reports-worker.log

[program:faveo-Horizon]
process_name=%(program_name)s
command=php /var/www/faveo/faveo-helpdesk/artisan horizon
autostart=true
autorestart=true
user=www-data
redirect_stderr=true
stdout_logfile=/var/www/faveo/faveo-helpdesk/storage/logs/horizon-worker.log
EOF

service supervisor restart
sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl start faveo-worker:*
sudo supervisorctl start faveo-recur:*




echo
echo "###################################################"
echo " Installing Let's Encrypt SSL                      "
echo "###################################################"
echo
sudo add-apt-repository ppa:certbot/certbot -y
apt-get install python-certbot-apache -y

certbot certonly --noninteractive --webroot --agree-tos -m $email -d $domainname -w $host_root_dir

sudo certbot renew --dry-run





echo
echo "##################################"
echo "    Faveo installed successfully  "
echo "##################################"
echo
echo "Access Faveo page on browser https://$domainname or with your server IP"
echo "Set up database details, given at the time of installtion"
echo 
