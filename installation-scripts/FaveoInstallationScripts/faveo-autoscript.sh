#!/bin/bash
#
#  Faveo Helpdesk Auto Installation Script
#  Tested with Ubuntu 16.04,18.04,20.04, Centos 7,8 Stream, Rockey 8 Stream, Debian Version faveo 4.10.0
#
#  Copyright (C) 2020 Ladybird Web Solution Pvt Ltd
#
#  Author Thirumoorthi Duraipandi & Viswash Haxoor
# Email
#
#  This script is intended to be run on a fresh Faveo installation
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


# Colour variables for the script.
red=`tput setaf 1`

green=`tput setaf 2`

yellow=`tput setaf 11`

skyblue=`tput setaf 14`

white=`tput setaf 15`

reset=`tput sgr0`

# Faveo Banner.

echo -e "$skyblue                                                                                                                         $reset"
sleep 0.05
echo -e "$skyblue                                        _______ _______ _     _ _______ _______                                          $reset"
sleep 0.05   
echo -e "$skyblue                                       (_______|_______|_)   (_|_______|_______)                                         $reset"
sleep 0.05
echo -e "$skyblue                                        _____   _______ _     _ _____   _     _                                          $reset"
sleep 0.05
echo -e "$skyblue                                       |  ___) |  ___  | |   | |  ___) | |   | |                                         $reset"
sleep 0.05
echo -e "$skyblue                                       | |     | |   | |\ \ / /| |_____| |___| |                                         $reset"
sleep 0.05
echo -e "$skyblue                                       |_|     |_|   |_| \___/ |_______)\_____/                                          $reset"
sleep 0.05
echo -e "$skyblue                                                                                                                         $reset"
sleep 0.05 
echo -e "$skyblue                               _     _ _______ _       ______ ______  _______  ______ _     _                            $reset"
sleep 0.05     
echo -e "$skyblue                             (_)   (_|_______|_)     (_____ (______)(_______)/ _____|_)   | |                            $reset"
sleep 0.05
echo -e "$skyblue                              _______ _____   _       _____) )     _ _____  ( (____  _____| |                            $reset"
sleep 0.05
echo -e "$skyblue                             |  ___  |  ___) | |     |  ____/ |   | |  ___)  \____ \|  _   _)                            $reset"
sleep 0.05
echo -e "$skyblue                             | |   | | |_____| |_____| |    | |__/ /| |_____ _____) ) |  \ \                             $reset"
sleep 0.05
echo -e "$skyblue                             |_|   |_|_______)_______)_|    |_____/ |_______|______/|_|   \_)                            $reset"
sleep 0.05
echo -e "$skyblue                                                                                                                         $reset"
sleep 0.05
echo -e "$skyblue                                                                                                                         $reset"
                                                                                        
                                                                                        
                                                                                        
echo -e "$yellow                   This is a automated Installation Script for Faveo Helpdesk products which runs on Linux Distro's $reset"
echo -e "                                                                                                          "
sleep 0.5
echo -e "$yellow    At the end of this script you will get the details for the faveo GUI configuration please copy those information for future use $reset"
sleep 0.5
# Detect Debian users running the script with "sh" instead of bash.

if readlink /proc/$$/exe | grep -q "dash"; then
	echo '&red This installer needs to be run with "bash", not "sh". $reset'
	exit 1
fi

# Checking for the Super User.

if [[ $EUID -ne 0 ]]; then
   echo -e "$red This script must be run as root $reset"
   exit 1
fi

# Detect OS
# $os_version are needed to install the dependency packages.
# Below the OS will be detected and the Version check will be done for the Faveo Requirement.

echo -e "$yellow Checking for the OS & Version $reset"
sleep 0.5
if grep -qs "ubuntu" /etc/os-release; then
	os="ubuntu"
	os_version=$(grep 'VERSION_ID' /etc/os-release | cut -d '"' -f 2 | tr -d '.')
    Os_Version=$(hostnamectl | grep 'Operating System')
	group_name="nogroup"
    sleep 1
    echo -e "                                 "
    echo -e "[OS Detected] : $green $Os_Version $reset"
    sleep 1
    echo -e "                                 "
    echo -e "Supported OS Version [CHECK :$green OK $reset]"

elif [[ -e /etc/debian_version ]]; then
	os="debian"
	os_version=$(grep -oE '[0-9]+' /etc/debian_version | head -1)
	group_name="nogroup"
    Os_Version=$(hostnamectl | grep 'Operating System')
	group_name="nogroup"
    sleep 1
    echo -e "                                 "
    echo -e "[OS Detected] : $green $Os_Version $reset"
    sleep 1
    echo -e "                                 "
    echo -e "Supported OS Version [CHECK :$green OK $reset]"

elif [[  -e /etc/rocky-release || -e /etc/centos-release ]]; then
	os="centos"
	os_version=$(grep -shoE '[0-9]+'  /etc/rocky-release /etc/centos-release | head -1)
	group_name="nobody"
    Os_Version=$(hostnamectl | grep 'Operating System')
	group_name="nogroup"
    sleep 1
    echo -e "                                 "
    echo -e "[OS Detected] : $green $Os_Version $reset"
    sleep 1
    echo -e "                                 "
    echo -e "Supported OS Version [CHECK :$green OK $reset]"
elif [[  -e /etc/rocky-release ]]; then
	os="rocky"
	os_version=$(grep -shoE '[0-9]+'  /etc/rocky-release | head -1)
	group_name="nobody"
    Os_Version=$(hostnamectl | grep 'Operating System')
	group_name="nogroup"
    sleep 1
    echo -e "                                 "
    echo -e "[OS Detected] : $green $Os_Version $reset"
    sleep 1
    echo -e "                                 "
    echo -e "Supported OS Version [CHECK :$green OK $reset]"

# If the required OS and version is not detected the below response will be passed to the user.

else
	echo "$red This installer seems to be running on an unsupported distribution.
Supported distros are Ubuntu, Debian, Rocky Linux, CentOS and Fedora.$reset"
	exit
fi

if [[ "$os" == "ubuntu" && "$os_version" -lt 1804 ]]; then
    echo "$os_version"
	echo "$red Ubuntu 16.04 or higher is required to use this installer.
This version of Ubuntu is too old and unsupported.$reset"
	exit
fi

if [[ "$os" == "debian" && "$os_version" -lt 10 ]]; then
    echo "$os_version"
	echo "$red Debian 9 or higher is required to use this installer.
This version of Debian is too old and unsupported.$reset"
	exit
fi

if [[ "$os" == "centos" && "$os_version" -lt 7 ]]; then
    echo "$os_version"
	echo "$red CentOS 7 or higher is required to use this installer.
This version of CentOS is too old and unsupported.$reset"
	exit
fi

# Prerequisties for the Faveo installation like the Domain, email, License and order numbers are taken below:

sleep 0.5
echo -e "                               "
echo -e "$skyblue Please provide the Below details which is required for the Faveo installaion $reset"
sleep 0.5 

Get_Faveo_Prerequisties ()
{
echo -e "                                 "
echo "$yellow Domain Name$reset";
echo -e "                                 "
read DomainName
sleep 0.5
echo -e "                                 "
echo "$yellow Email $reset";
echo -e "                                 "
read Email
sleep 0.5
echo "$yellow You can find the License and Order No from https://billing.faveohelpdesk.com $reset"
echo -e "                                   "
echo "$yellow License Code $reset";
echo -e "                                 "
read LicenseCode
sleep 0.5
echo -e "                                 "
echo "$yellow Order Number $reset";
echo -e "                                 "
read OrderNumber
sleep 0.5
echo -e "                                 "
echo -e "\n";
echo -e "Confirm the Entered Helpdesk details:\n";
sleep 0.05
echo -e "-------------------------------------\n"
sleep 0.05
echo -e "                                 "
echo "Domain Name :$yellow $DomainName $reset";
sleep 0.05
echo -e "                                 "
echo "Email:$yellow $Email $reset";
sleep 0.05
echo -e "                                 "
echo "License Code:$yellow $LicenseCode $reset";
sleep 0.05
echo -e "                                 "
echo "Order Number:$yellow $OrderNumber $reset";
sleep 0.05
}
# Executing function to fetch the above detais.

Get_Faveo_Prerequisties
sleep 0.5

# Checking the Details with functions below.

echo -e "\n";
read -p "Continue ($green y $reset/$red n $reset)?" REPLY
if [[ ! $REPLY =~ ^(yes|y|Yes|YES|Y) ]]; then
    echo -e "                           "
    read -p "Do you wish to Re-enter Continue ($green y $reset/$red n $reset)?" REPLY2
    if [[ ! $REPLY2 =~ ^(yes|y|Yes|YES|Y) ]]; then
        exit 1;
    else
        Get_Faveo_Prerequisties
    fi;
    read -p "Is the above details are correct ($green y $reset/$red n $reset)?" REPLY3
    if [[ ! $REPLY3 =~ ^(yes|y|Yes|YES|Y) ]]; then
        echo "Please restart the script"
        exit 1;
    else
        echo -e "        "
        echo "$skyblue Proceeding the Installation $reset"
        echo -e "          "
    fi
else 
    echo -e "           "
    echo "Proceeding Further"
fi;

sleep 0.5

# DNS Propagation checking with DIG command.

echo -e "$yellow Installing precheck tools for faveo $reset"

apt update && apt install dnsutils git wget curl unzip nano netcat zip -y || yum update -y && yum install unzip wget nano yum-utils curl openssl zip git nc bind-utils -y >/dev/null 2>&1

sleep 0.5
echo -e "                                                               "
echo -e "$yellow Checking whether the domain is propagated to the server's public IP. $reset"
echo -e "                                       "

# Checking the server public IP:

PublicIP=$(curl -s ifconfig.me) 

# checking the domian propagated IP:

echo -e "               "
DomainIP=$(dig $DomainName +short)
echo -e "               "

# Condition for comparing the IP's:

echo -e "$yellow Checking wether Public IP is propagated to the Domain $reset"

if [[ $PublicIP != $DomainIP ]]; then
    echo -e "$yellow Please make sure the Domain is propagated to the server pubic IP and try again, The server IP is $red $PublicIP $reset and The domain is propagated to $red $DomainIP $reset $reset";
    echo -e "               "
    exit 1
else
    echo -e "$yellow The Domain is Propagated to the Server Public IP CHECK :$green OK $reset $reset"
    echo -e "               "
    echo "$skyblue Proceeding the Installation $reset"
    echo -e "               "
fi
sleep 0.5

# Faveo installation if the OS is Ubuntu.

Ubuntu_Installation () 
{
    # updating the Ubuntu package repo and server.

    echo -e "$yellow Updating server Repo and Packages $reset"

    apt update && apt upgrade -y

    if [[ $? != 0 ]]; then
    echo -e "$red The script failed at server and repo update $reset"
    fi
    sleep 0.5
    # installing apache2 and Utility packages.

    echo -e "$yellow Installing Apache and Utility packages $reset"


    apt install apache2 -y
    systemctl start apache2
    systemctl enable apache2
    a2enmod ssl
    systemctl restart apache2
    apt install -y git wget curl unzip nano zip

    if [[ $? != 0 ]]; then
    echo -e "$red Failed at installing apache2 and Utility packages $reset."
    fi
    sleep 0.5
    # Checking for required ports whether it is open or not.

    echo -e "$yellow Checking for the Port 80 and 443 Http and Https Faveo requires those Ports for the Installation $reset" 
    echo -e "       "

    
    nc -z $DomainName 80

    if [[ $? != 0 ]]; then
        echo "$red The Port 80 is Not open. Please open the required Ports and restart the script $reset";  
        echo -e "               "
        exit 1
    else
        echo "$yellow The Port 80 Open CHECK :$green OK $reset $reset"
        echo -e "               "
        echo "$skyblue Proceeding the Installation $reset"
        echo -e "               "
    fi

    nc -z $DomainName 443

    if [[ $? != 0 ]]; then
        echo "$red The Port 443 is Not open. Please open the required Ports and restart the script $reset";
        echo -e "               "
        exit 1
    else
        echo "$yellow The Port 443 Open CHECK :$green OK $reset $reset"
        echo -e "               "
        echo "$skyblue Proceeding the Installation $reset"
        echo -e "               "
    fi

    if [[ $? != 0 ]]; then
    echo -e "Failed at installing apache2 and Utility packages."
    fi
    sleep 0.5
    # Adding PHP 7.3 PPA repository and installing PHP and required extensions, 

    echo -e "$yesllow Installing PHP 7.3 and PHP Extensions $reset"

    if [[ "$os" == "debian" ]]; then
    apt update
    apt install -y php7.3 libapache2-mod-php7.3 php7.3-mysql \
    php7.3-cli php7.3-common php7.3-fpm php7.3-soap php7.3-gd \
    php7.3-json php7.3-opcache  php7.3-mbstring php7.3-zip \
    php7.3-bcmath php7.3-intl php7.3-xml php7.3-curl  \
    php7.3-imap php7.3-ldap php7.3-gmp php7.3-redis
    
    fi

    if [[ "$os" == "ubuntu" ]]; then
    apt-get install -y software-properties-common
    add-apt-repository ppa:ondrej/php -y

    apt update
    apt install -y php7.3 libapache2-mod-php7.3 php7.3-mysql \
    php7.3-cli php7.3-common php7.3-fpm php7.3-soap php7.3-gd \
    php7.3-json php7.3-opcache  php7.3-mbstring php7.3-zip \
    php7.3-bcmath php7.3-intl php7.3-xml php7.3-curl  \
    php7.3-imap php7.3-ldap php7.3-gmp php7.3-redis
    fi

    if [[ $? != 0 ]]; then
    echo -e "$red Failed at Adding PHP 7.3 PPA repository and installing PHP and required extensions. $reset"
    fi
    sleep 0.5
    # Editing php.ini file.
    echo -e "$yellow Editing php.ini file to Faveo requirements $reset"
    if [[ "$os" == "debian" ]]; then
    sed -i 's/file_uploads =.*/file_uploads = On/g' /etc/php/7.3/fpm/php.ini
    sed -i 's/allow_url_fopen =.*/allow_url_fopen = On/g' /etc/php/7.3/fpm/php.ini
    sed -i 's/short_open_tag =.*/short_open_tag = On/g' /etc/php/7.3/fpm/php.ini
    sed -i 's/memory_limit =.*/memory_limit = 256MB/g' /etc/php/7.3/fpm/php.ini
    sed -i 's/;cgi.fix_pathinfo=.*/cgi.fix_pathinfo = 0/g' /etc/php/7.3/fpm/php.ini
    sed -i 's/upload_max_filesize =.*/upload_max_filesize = 100M/g' /etc/php/7.3/fpm/php.ini
    sed -i 's/post_max_size =.*/post_max_size = 100M/g' /etc/php/7.3/fpm/php.ini
    sed -i 's/max_execution_time =.*/max_execution_time = 360/g' /etc/php/7.3/fpm/php.ini
    fi

    if [[ "$os" == "ubuntu" ]]; then
    sed -i 's/file_uploads =.*/file_uploads = On/g' /etc/php/7.3/fpm/php.ini
    sed -i 's/allow_url_fopen =.*/allow_url_fopen = On/g' /etc/php/7.3/fpm/php.ini
    sed -i 's/short_open_tag =.*/short_open_tag = On/g' /etc/php/7.3/fpm/php.ini
    sed -i 's/memory_limit =.*/memory_limit = 256MB/g' /etc/php/7.3/fpm/php.ini
    sed -i 's/;cgi.fix_pathinfo=.*/cgi.fix_pathinfo = 0/g' /etc/php/7.3/fpm/php.ini
    sed -i 's/upload_max_filesize =.*/upload_max_filesize = 100M/g' /etc/php/7.3/fpm/php.ini
    sed -i 's/post_max_size =.*/post_max_size = 100M/g' /etc/php/7.3/fpm/php.ini
    sed -i 's/max_execution_time =.*/max_execution_time = 360/g' /etc/php/7.3/fpm/php.ini
    sed -i 's/max_execution_time =.*/max_execution_time = 360/g' /etc/php/7.3/apache2/php.ini

    fi

    if [[ $? != 0 ]]; then
    echo -e "$red Failed at Editing php.ini file. $reset"
    fi
    sleep 0.5
    # Setting Up IONCube.
    echo -e "$yellow Setting up IonCube loader $reset"



    wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
    tar xvfz ioncube_loaders_lin_x86-64.tar.gz 

    PhpExtDir=$(php -i | grep "PHP Extension =>")
    phpdir=$(grep -oE '[0-9]*' <<<$PhpExtDir)
    cp ioncube/ioncube_loader_lin_7.3.so /usr/lib/php/''$phpdir''
    sed -i '2 a zend_extension = "/usr/lib/php/'$phpdir'/ioncube_loader_lin_7.3.so"' /etc/php/7.3/apache2/php.ini
    sed -i '2 a zend_extension = "/usr/lib/php/'$phpdir'/ioncube_loader_lin_7.3.so"' /etc/php/7.3/cli/php.ini
    sed -i '2 a zend_extension = "/usr/lib/php/'$phpdir'/ioncube_loader_lin_7.3.so"' /etc/php/7.3/fpm/php.ini

    systemctl restart apache2 

    if [[ $? != 0 ]]; then
    echo -e "$red Failed at Setting Up IONCube. $reset"
    fi
    sleep 0.5
    # Installing MySql DB.

    echo -e "$yellow Installing MySql Database $reset"


    if [[ "$os" == "ubuntu" && "$os_version" -lt 2004 ]]; then
        wget https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
        echo "b9e90cde27affc2a44f9fc60e302ccfcacf71f4ae02071f30d570e6048c28597 mariadb_repo_setup" \
            | sha256sum -c -        
        chmod +x mariadb_repo_setup
        sudo ./mariadb_repo_setup \
            --mariadb-server-version="mariadb-10.3"
        apt-get update
        DEBIAN_FRONTEND=noninteractive apt-get install mariadb-server -y
        systemctl start mysql
        systemctl enable mysql
    
    else
        apt install -y mariadb-server-10.3
        systemctl start mariadb
        systemctl enable mariadb
    fi

    if [[ "$os" == "debian" ]]; then

    apt install -y mariadb-server
    systemctl start mariadb
    systemctl enable mariadb

    fi

    if [[ $? != 0 ]]; then
    echo -e "$red Failed at Installing MySql DB. $reset"
    fi

    sleep 0.5
    # Faveo Upload:

    echo -e "$yellow Uploading Faveo Code $reset"


    mkdir -p /var/www/faveo
    cd /var/www/faveo
     
    curl https://billing.faveohelpdesk.com/download/faveo\?order_number\=$OrderNumber\&serial_key\=$LicenseCode --output faveo.zip 

    unzip -q "faveo.zip" -d /var/www/faveo 

    # Faveo Folder permissions:

    chown -R www-data:www-data /var/www/faveo
    find . -type f -exec chmod 644 {} \;
    find . -type d -exec chmod 755 {} \;

    if [[ $? != 0 ]]; then
    echo -e "$red Failed at Faveo Upload. $reset"
    fi
    sleep 0.5
    # Creating and setting up DB.

    echo -e "$yellow Creating DB and user for Faveo $reset"


    touch /var/www/DB-password

    db_user_pw=$(openssl rand -base64 12)  
    echo -e "$db_user_pw" >> /var/www/DB-password

	mysql -uroot  -e "CREATE DATABASE faveo ;"
	mysql -uroot  -e "CREATE USER faveo@localhost IDENTIFIED BY '$db_user_pw';"
	mysql -uroot  -e "GRANT ALL PRIVILEGES ON faveo.* TO 'faveo'@'localhost';"
	mysql -uroot  -e "FLUSH PRIVILEGES;"

    if [[ $? != 0 ]]; then
    echo -e "$red Failed at faveo DB creation. $reset"
    fi
    sleep 0.5
    # Creating and enabling apache virtual host.
    echo -e "$yellow Creating apache virtual host for faveo $reset"

    touch /etc/apache2/sites-available/faveo.conf

    echo -e "<VirtualHost *:80>
    ServerName $DomainName 
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/faveo/public

    <Directory /var/www/faveo/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/faveo-error.log
    CustomLog ${APACHE_LOG_DIR}/faveo-access.log combined
# Uncomment the below lines and replace the Server-IP and Domainame to configure IP to Domainname rewrite rule
#    RewriteEngine on
#    RewriteCond %{HTTP_HOST} ^--Server-IP--
#    RewriteRule (.*) http://--Domainname--
</VirtualHost>" >> /etc/apache2/sites-available/faveo.conf

    a2enmod rewrite
    a2dissite 000-default.conf
    a2ensite faveo.conf
    a2enmod proxy_fcgi setenvif
    a2enconf php7.3-fpm

    systemctl restart php7.3-fpm
    systemctl restart apache2

    if [[ $? != 0 ]]; then
    echo -e "$red Failed at apache vhost creation $reset"
    fi
    sleep 0.5
    # Creating cron job for faveo.
    echo -e "$yellow Creating cron for Faveo $reset"


    echo "* * * * * www-data /usr/bin/php /var/www/faveo/artisan schedule:run 2>&1" | sudo tee /etc/cron.d/faveo
    sleep 0.5
    # Installing redis to the server.

    echo -e "$yellow Installing Redis for Faveo $reset"

    apt-get install redis-server -y
    systemctl start redis-server
    systemctl enable redis-server


    if [[ $? != 0 ]]; then
    echo -e "$red Failed at redis installation $reset"
    fi
    sleep 0.5
    # Installing and adding supervisor configuration
    
    echo -e "$yellow Installing supervisor and supervisor configuration $reset"

    apt-get install supervisor -y

    touch /etc/supervisor/conf.d/faveo-worker.conf

    echo -e "[program:faveo-worker]
process_name=%(program_name)s_%(process_num)02d
command=php  /var/www/faveo/artisan queue:work redis --sleep=3 --tries=3
autostart=true
autorestart=true
user=www-data
numprocs=8
redirect_stderr=true
stdout_logfile=/var/www/faveo/storage/logs/worker.log

[program:faveo-recur]
process_name=%(program_name)s_%(process_num)02d
command=php  /var/www/faveo/artisan queue:work redis --queue=recurring --sleep=3 --tries=3
autostart=true
autorestart=true
user =www-data
numprocs=1
redirect_stderr=true
stdout_logfile=/var/www/faveo/storage/logs/worker.log

[program:faveo-Reports]
process_name=%(program_name)s_%(process_num)02d
command=php  /var/www/faveo/artisan queue:work redis --queue=reports --sleep=3 --tries=3
autostart=true
autorestart=true
user=www-data
numprocs=1
redirect_stderr=true
stdout_logfile=/var/www/faveo/storage/logs/reports-worker.log

[program:faveo-Horizon]
process_name=%(program_name)s
command=php /var/www/faveo/artisan horizon
autostart=true
autorestart=true
user=www-data
redirect_stderr=true
stdout_logfile=/var/www/faveo/storage/logs/horizon-worker.log
" >> /etc/supervisor/conf.d/faveo-worker.conf

    systemctl restart supervisor 

    if [[ $? != 0 ]]; then
    echo -e "$red Failed at supervisor configuration $reset"
    fi
    sleep 0.5

    # SSL installation.

    echo -e "$yellow Installing SSL for Faveo $reset"

    if [[ "$os" == "ubuntu" && "$os_version" -lt 2004 ]]; then
    apt install python-certbot-apache -y
    else
    apt install python3-certbot-apache -y
    fi    

    certbot run -n --apache --agree-tos -d $DomainName  -m  $Email --redirect -q

    if [[ $? != 0 ]]; then
    echo -e "$red Failed to obtain SSL certificates $reset"
    fi

    if [[ "$os" == "debian" ]]; then
    apt install python-certbot-apache -y
    fi    

    certbot run -n --apache --agree-tos -d $DomainName  -m  $Email --redirect -q

    if [[ $? != 0 ]]; then
    echo -e "$red Failed to obtain SSL certificates $reset"
    fi
    sleep 0.5

    echo "45 2 * * 6 /etc/letsencrypt/ && ./certbot renew && /etc/init.d/apache2 restart " | sudo tee /etc/cron.d/faveo-ssl
    sleep 0.5
 
   echo "$skyblue Faveo installation went successfully with out any error you can access the faveo on you domain in the browser. $reset"
   sleep 0.5

}



CentOS_Installation  ()
{
    # Update your Packages and install some utility tools
    echo -e "$yellow Updating server repo and Packages $reset"
    yum update -y && yum install unzip wget nano yum-utils curl openssl zip git tar -y
   
    if [[ $? != 0 ]]; then
    echo -e "$red failed at server and repo update $reset"
    fi
    sleep 0.5

    # Install php-7.3 Packages
    echo -e "$yellow Installing PHP and PHP Extensions $reset"


    if [[ "$os" == "centos" && "$os_version" -lt 8 ]]; then
	yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	yum install -y https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
	yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
	yum-config-manager --enable remi-php73
	yum -y install php php-cli php-common php-fpm php-gd php-mbstring php-pecl-mcrypt php-mysqlnd php-odbc php-pdo php-xml  php-opcache php-imap php-bcmath php-ldap php-pecl-zip php-soap php-redis
    
    else
	yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
	yum install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm
	dnf module install php:remi-7.3 -y
	yum -y install php php-cli php-common php-fpm php-gd php-mbstring php-pecl-mcrypt php-mysqlnd php-odbc php-pdo php-xml  php-opcache php-imap php-bcmath php-ldap php-pecl-zip php-soap php-redis

    fi



    if [[ $? != 0 ]]; then
    echo -e "$red Failed at Adding PHP 7.3 PPA repository and installing PHP and required extensions. $reset"
    fi
    sleep 0.5

    # Install and run Apache Install and Enable Apache Server
    echo -e "$yellow Installing Apache $reset"
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    yum install mod_ssl -y
    systemctl restart httpd

    if [[ $? != 0 ]]; then
    echo -e "$red Failed at installing apache2 and Utility packages. $reset"
    fi    
    sleep 0.5

    # Checking for required ports whether it is open or not.

    echo -e "$yellow Checking for the Port 80 and 443 Http and Https Faveo requires those Ports for the Installation $reset" 
    echo -e "       "

    nc -z $DomainName 80

    if [[ $? != 0 ]]; then
        echo "$red The Port 80 is Not open. Please open the required Ports and restart the script $reset";  
        echo -e "               "
        exit 1
    else
        echo "$yellow The Port 80 Open CHECK :$green OK $reset $reset"
        echo -e "               "
        echo "$skyblue Proceeding the Installation $reset"
        echo -e "               "
    fi

    nc -z $DomainName 443

    if [[ $? != 0 ]]; then
        echo "$red The Port 443 is Not open. Please open the required Ports and restart the script $reset";
        echo -e "               "
        exit 1
    else
        echo "$yellow The Port 443 Open CHECK :$green OK $reset $reset"
        echo -e "               "
        echo "$skyblue Proceeding the Installation $reset"
        echo -e "               "
    fi

    sleep 0.5
    
    # Setting Up ionCube
    echo -e "$yellow Installing IonCube $reset"
    wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
    tar xfz ioncube_loaders_lin_x86-64.tar.gz

    cp ioncube/ioncube_loader_lin_7.3.so /usr/lib64/php/modules 
    sed -i '2 a zend_extension = "/usr/lib64/php/modules/ioncube_loader_lin_7.3.so"' /etc/php.ini
    sed -i "s/max_execution_time = .*/max_execution_time = 300/" /etc/php.ini

    if [[ $? != 0 ]]; then
    echo -e "$red Failed at Setting Up IONCube. $reset"
    fi
    sleep 0.5

    # Installing MySql DB.
    echo -e "$yellow Installing MySql DB $reset"
    
    if [[ "$os" == "centos" && "$os_version" -lt 8 ]]; then
    touch /etc/yum.repos.d/mariadb.repo
    echo -e "[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.3/centos73-amd64/
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1" >> /etc/yum.repos.d/mariadb.repo

    yum install MariaDB-server MariaDB-client -y
    systemctl enable mysql.service
    systemctl start mysql.service
    
    else
	dnf module -y install mariadb:10.3
	systemctl start mariadb
	systemctl enable mariadb
    fi 

    if [[ "$os" == "rocky" && "$os_version" -lt 8 ]]; then
    touch /etc/yum.repos.d/mariadb.repo
    echo -e "[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.3/centos73-amd64/
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1" >> /etc/yum.repos.d/mariadb.repo

    yum install MariaDB-server MariaDB-client -y
    systemctl enable mysql.service
    systemctl start mysql.service
    
    else
	dnf module -y install mariadb:10.3
	systemctl start mariadb
	systemctl enable mariadb
    fi 
    

    if [[ $? != 0 ]]; then
    echo -e "$red Failed to install MariaDB. $reset"
    fi
    sleep 0.5

    # Faveo Upload:
    echo -e "$yellow Uploading Faveo $reset"
    mkdir -p /var/www/faveo
    cd /var/www/faveo
     
    curl https://billing.faveohelpdesk.com/download/faveo\?order_number\=$OrderNumber\&serial_key\=$LicenseCode --output faveo.zip

    unzip -q "faveo.zip" -d /var/www/faveo 


    # Faveo Folder permissions:
    chown -R apache:apache /var/www/faveo
    find . -type f -exec chmod 644 {} \;
    find . -type d -exec chmod 755 {} \;

    if [[ $? != 0 ]]; then
    echo -e "$red Failed at Faveo Upload. $reset"
    fi
    sleep 0.5

    # Creating faveo DB.
    echo -e "$yellow Creating DB and user for Faveo $reset"

    touch /var/www/DB-password

    db_user_pw=$(openssl rand -base64 12) 
    echo -e "$db_user_pw" >> /var/www/DB-password

	mysql -uroot  -e "CREATE DATABASE faveo ;"
	mysql -uroot  -e "CREATE USER faveo@localhost IDENTIFIED BY '$db_user_pw';"
	mysql -uroot  -e "GRANT ALL PRIVILEGES ON faveo.* TO 'faveo'@'localhost';"
	mysql -uroot  -e "FLUSH PRIVILEGES;"

    if [[ $? != 0 ]]; then
    echo -e "$red Failed at faveo DB creation. $reset"
    fi
    sleep 0.5

    # Setting selinux to permissive mode.
    echo -e "$yellow Setting Selinux to permissive mode $reset"
    setenforce 0

    sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config

    #  Adding Rewrite engine to the apache config.

    ls /etc/httpd/modules | grep mod_rewrite 

    if [[ $? != 0 ]]; then
    echo -e "$red mod_rewrite is not in apache folder. $reset"
    fi

    grep -i LoadModule /etc/httpd/conf/httpd.conf | grep rewrite

    if [[ $? != 0 ]]; then
    echo -e "LoadModule rewrite_module modules/mod_rewrite.so" >> /etc/httpd/conf/httpd.conf
    fi   

    sed -i '125s/AllowOverride.*/AllowOverride All/g' /etc/httpd/conf/httpd.conf
    sleep 0.5

    # Creating apache config.
    echo -e "$yellow Creating apache virtual host for faveo $reset"

    touch /etc/httpd/conf.d/faveo.conf

    echo -e "<VirtualHost *:80> 
ServerName $DomainName 
ServerAdmin webmaster@localhost 
DocumentRoot /var/www/faveo/public 
<Directory /var/www/faveo> 
AllowOverride All 
</Directory> 
ErrorLog /var/log/httpd/faveo-error.log 
CustomLog /var/log/httpd/faveo-access.log combined
</VirtualHost>" >> /etc/httpd/conf.d/faveo.conf

    systemctl restart httpd

    if [[ $? != 0 ]]; then
    echo -e "$red Failed to edit apache config $reset"
    fi
    sleep 0.5

    # Configuring cron for faveo.
    echo -e "$yellow Creating cron for faveo $reset"

    echo "* * * * * apache /bin/php /var/www/faveo/artisan schedule:run 2>&1" | sudo tee /etc/cron.d/faveo
    sleep 0.5

    # Installing Redis to the server.
    echo -e "$yellow Installing redis for faveo $reset"
    yum install redis -y
    yum install -y php-redis
    systemctl start redis
    systemctl enable redis

    if [[ $? != 0 ]]; then
    echo -e "$red Failed to install redis $reset"
    fi
    sleep 0.5

    # Installing supervisor to the server.
    echo -e "$yellow Installing supervisor for faveo $reset"
    yum install -y supervisor
    systemctl start supervisord
    systemctl enable supervisord

    touch /etc/supervisord.d/faveo-worker.ini

    echo -e "[program:faveo-worker]
process_name=%(program_name)s_%(process_num)02d
command=php  /var/www/faveo/artisan queue:work redis --sleep=3 --tries=3
autostart=true
autorestart=true
user=apache
numprocs=8
redirect_stderr=true
stdout_logfile=/var/www/faveo/storage/logs/worker.log

[program:faveo-Recur]
process_name=%(program_name)s_%(process_num)02d
command=php  /var/www/faveo/artisan queue:work redis --queue=recurring --sleep=3 --tries=3
autostart=true
autorestart=true
user=apache
numprocs=1
redirect_stderr=true
stdout_logfile=/var/www/faveo/storage/logs/recur-worker.log

[program:faveo-Reports]
process_name=%(program_name)s_%(process_num)02d
command=php  /var/www/faveo/artisan queue:work redis --queue=reports --sleep=3 --tries=3
autostart=true
autorestart=true
numprocs=1
user=apache
redirect_stderr=true
stdout_logfile=/var/www/faveo/storage/logs/reports-worker.log

[program:faveo-Horizon]
process_name=%(program_name)s
command=php /var/www/faveo/artisan horizon
autostart=true
autorestart=true
user=apache
redirect_stderr=true
stdout_logfile=/var/www/faveo/storage/logs/horizon-worker.log" >> /etc/supervisord.d/faveo-worker.ini

    systemctl restart supervisord

    if [[ $? != 0 ]]; then
    echo -e "$red Failed to install and configure supervisor $reset"
    fi
    sleep 0.5

    # Installing SSL cerrtificates.
    echo -e "$yellow Installing SSL certificate for Faveo $reset"

    yum install epel-release mod_ssl

    if [[ "$os" == "centos" && "$os_version" -lt 8 ]]; then
    yum install python-certbot-apache -y
    else
    yum install python3-certbot-apache -y
    fi    
    if [[ "$os" == "rocky" && "$os_version" -lt 8 ]]; then
    yum install python-certbot-apache -y
    else
    yum install python3-certbot-apache -y
    fi    

    certbot run -n --apache --agree-tos -d $DomainName  -m  $Email --redirect -q

    if [[ $? != 0 ]]; then
    echo -e "$red Failed to obtain SSL certificates $reset"
    fi

    echo "45 2 * * 6 /etc/letsencrypt/ && ./certbot renew && /bin/systemctl restart httpd.service" | sudo tee /etc/cron.d/faveo-ssl
    sleep 0.5

    # Faveo installed without any issue.

    echo -e "$skyblue Faveo installation went successfully with out any error you can access the faveo on you domain in the browser. $reset"

    

}

if [[ $os = ubuntu ]]; then

Ubuntu_Installation

fi

if [[ $os = centos ]]; then

CentOS_Installation

fi

if [[ $os = debian ]]; then

Ubuntu_Installation

fi

if [[ $os = rocky ]]; then

CentOS_Installation

fi

sleep 1

echo -e "                                                                                                       "
echo -e "                                                                                                       "

echo -e "Please copy the below information somwhere safe for the future usage and configuring faveo on GUI"
sleep 1
echo -e "                                                                                                       "
sleep 0.05
echo -e "------------------------------------------------------------------------------------------------"
sleep 0.05
echo -e "|                                                                                              |"
sleep 0.05
echo -e "| $skyblue Faveo URL $reset                        $green               $DomainName    $reset  |"
sleep 0.05
echo -e "|                                                                                              |"
sleep 0.05
echo -e "| $skyblue Faveo DB User $reset                    $green               faveo   $reset         |"
sleep 0.05
echo -e "|                                                                                              |"
sleep 0.05
echo -e "| $skyblue Faveo DB Name  $reset                   $green               faveo  $reset          |"
sleep 0.05
echo -e "|                                                                                              |"
sleep 0.05
echo -e "| $skyblue Faveo DB User Passwd  $reset            $green               $db_user_pw $reset     |"
sleep 0.05
echo -e "|                                                                                              |"
sleep 0.05
echo -e "------------------------------------------------------------------------------------------------"