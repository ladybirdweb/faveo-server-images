---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/litespeed-ubuntu/
redirect_from:
  - /theme-setup/
last_modified_at: 2023-09-21
last_modified_by: TamilSelvan_M
toc: true
title: Installing Faveo Helpdesk on Ubuntu With litespeed Web Server
---





<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/litespeed-webserver-logo.png?raw=true" height="120" />

Faveo can run on [Ubuntu 20.04 (Focal Fosa), Ubuntu 22.04 (Jammy Jellyfish)](http://releases.ubuntu.com/22.04/).

  - [<strong>Installation steps :</strong>](#s1)
    - [<strong>1. LOMP Installation</strong>](#s2)
    - [<strong>2. Install some Utility packages</strong>](s3)
    - [<strong>3. Upload Faveo</strong>](#s4)
    - [<strong>4. Configure Litespeed webserver</strong>](#s5)
    - [<strong>5. Setup the database</strong>](#s6)
    - [<strong>6. SSL Installation</strong>](#s7)
    - [<strong>7. Configure cron job</strong>](#s8)
    - [<strong>8. Redis Installation</strong>](#s9)
    - [<strong>9. Install Faveo</strong>](#s10)
    - [<strong>10. Faveo Backup</strong>](#s11)
    - [<strong>11. Final step</strong>](#s12)

<a id="s1" name="installation-steps-"></a>
# Installation steps
Faveo depends on the following:

- <strong>Web Server</strong>  Litespeed 
- <strong>PHP 8.1+</strong> with the following extensions: curl, dom, gd, json, mbstring, openssl, pdo_mysql, tokenizer, zip
- <strong>MySQL 8.0+ or MariaDB 10.6+</strong>
- <strong>SSL</strong> ,Trusted CA Signed or Slef-Signed SSL


<a id="s2" name="steps-1"></a>
### 1. LLMP Installation

The LLMP stack is an acronym for Linux, LiteSpeed, MariaDB, and PHP. 

In this tutorial, you will set up a LLMP server running on Ubuntu 22.04. At the time of writing, the current versions are PHP 8.1, MariaDB 10.6, and LiteSpeed 6.0.6.

Run the following commands as sudoers or Login as root user by typing the command below

```
sudo su
```
### 1.a. Update your package list

```
apt update && apt upgrade -y
```
### 1.b.  Installing LiteSpeed

#### Production license:
- Licenses can be leased or purchased at the [LiteSpeed store](https://store.litespeedtech.com/store/cart.php).

- A serial number will be sent to you in the confirmation email after you order has been successfully processed. Each serial number allows for one server installation.
Save the serial number as "serial.no"; in the installation directory (where install.sh is located). 

- The LiteSpeed products registration server will use this file to retrieve your license key during the installation process.

#### Download

Download the LiteSpeed Web Server tarball from the [LiteSpeed Technologies website](http://www.litespeedtech.com/download/litespeed-web-server-download?_gl=1*u0zddr*_gcl_au*MTkxMTg0MjY4OS4xNjg5NjA5ODM1).

Run the following commands from SSH as root:

```
cd /root
wget http://www.litespeedtech.com/packages/6.0/lsws-6.0.6-ent-x86_64-linux.tar.gz
```
#### Unpack
Use the following command to unpack the tarball:

```
tar zxfv  lsws-6.0.6-ent-x86_64-linux.tar.gz
```

#### Run Installation Script
Access the unpacked folder:

```
cd lsws-6.0.6
```
Create a serial.no file containing your paid license serial number or your trial key:

```
echo "YOUR_SERIAL_NO" > serial.no
```
Replace YOUR_SERIAL_NO with your actual license serial number or trial key. (Double quotes are optional in this context.)

Run the install script:

```
./install.sh
```
The installer will ask you a number of questions covered in detail [here](http://www.litespeedtech.com/docs/webserver/install?_gl=1*1k1862b*_gcl_au*MTkxMTg0MjY4OS4xNjg5NjA5ODM1).

Read the End User License Agreement and type "Yes" to confirm your agreement.

```cpp
Copyright (c) 2002-2003 Lite Speed Technologies Inc. All rights reserved.

IMPORTANT: In order to continue installation you must agree with above 
           license terms by typing "Yes" with capital "Y"! 

Do you agree with above license? Yes

```
Press "Enter" to confirm default.

```cpp
Please specify the destination directory. You must have permissions to 
create and manage the directory. It is recommended to install the web server 
at /opt/lsws, /usr/local/lsws or in your home directory like '~/lsws'.

ATTENTION: The user 'nobody' must be able to access the destination
           directory.

Destination [/usr/local/lsws]: 
```

Administrator's username and password for the WebAdmin interface.
```cpp
Please specify the user name of the administrator.
This is the user name required to log into the administration web interface.

User name [admin]: admin

```
```cpp
Please specify the administrator's password.
This is the password required to log into the administration web interface.

Password: 
Retype password: 
```

Please specify administrators' email addresses.

```cpp

It is recommended to specify a real email address,
Multiple email addresses can be set by a comma 
delimited list of email addresses. Whenever something
abnormal happened, a notification will be sent to 
emails listed here.

Email addresses [root@localhost]: admin@demo.com

```

What control panel, if any, you will use with LSWS. Select <code>0</code>

```cpp
Will you use LiteSpeed Web Server with a hosting control panel?

    0. NONE
    1. cPanel
    2. DirectAdmin
    3. Plesk
    4. Hsphere
    5. Interworx
    6. Lxadmin
    7. ISPManager
Please select (0-7) [0]? 0

```

Press "Enter" to skip default value.

```cpp
As you are the root user, you must choose the user and group
whom the web server will be running as. For security reason, you should choose
a non-system user who does not have login shell and home directory such as
'nobody'.

User [nobody]:    
```
```cpp
User 'nobody' is the member of following group(s):  nogroup
Group [nogroup]: 
```

TCP port for normal web service. Change <code>8088</code> to <code>80</code>.

```cpp
Please specify the port for normal HTTP service.
Port 80 is the standard HTTP port, only 'root' user is allowed to use 
port 80, if you have another web server running on port 80, you need to
specify another port or stop the other web server before starting LiteSpeed
Web Server.
You can access the normal web page at http://<YOUR_HOST>:<HTTP_PORT>/

HTTP port [8088]: 80
```

Press "Enter" to skip default value.

```cpp
Please specify the HTTP port for the administration web interface,
which can be accessed through http://<YOUR_HOST>:<ADMIN_PORT>/

Admin HTTP port [7080]: 
```

Whether to set up LiteSpeed PHP. 

```cpp
You can setup a global script handler for PHP with the pre-built PHP engine
shipped with this package now. The PHP engine runs as Fast CGI which  
outperforms Apache's mod_php. 
You can always replace the pre-built PHP engine with your customized PHP 
engine.

Setup up PHP [Y/n]: N
```

Enter <code>N</code> to skip installing Choot and AWStats Add-on

```
This installation script will try to setup the initial chroot environment 
automatically.

However, it is not easy to setup a chroot environment and you CGI program may
break. So we do not recommend enabling it for the first time user.
It can be enabled later by running this installation script again.

Enable chroot [y/N]: N
```
```cpp
AWStats Integration

AWStats is a popular log analyzer that generates advanced web server 
statistics. LiteSpeed web server seamlessly integrates AWStats into 
its Web Admin Interface. AWStats configuration and statistics update
have been taken care of by LiteSpeed web server.

Note: If AWStats has been installed already, you do not need to
      install again unless a new version of AWStats is available.

Would you like to install AWStats Add-on module [y/N]? N
```
Enter <code>Y</code> to restart server 

```cpp
Would you like to have LiteSpeed Web Server started automatically
when the server restarts [Y/n]? Y
```

```cpp
[OK] The startup script has been successfully installed!
Would you like to start it right now [Y/n]? Y
```
Root user can also choose to run LiteSpeed Web Server automatically at system startup as a service. Then you're done! The installer can start up the server.

### 1.d. Connecting to the Server

In this step, you will connect to your server.

LiteSpeed should have started automatically after it was installed. You can verify if it started with the <code>systemctl status</code> command:

```
sudo systemctl status lsws
```

You will receive the following output:

**Output**
```cpp
● lshttpd.service - LiteSpeed HTTP Server
     Loaded: loaded (/etc/systemd/system/lshttpd.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2022-03-16 08:59:09 UTC; 2min 26s ago
    Process: 32997 ExecStart=/usr/local/lsws/bin/lswsctrl start (code=exited, status=0/SUCCESS)
   Main PID: 33035 (litespeed)
     CGroup: /system.slice/lshttpd.service
             ├─33035 litespeed (lshttpd - main)
             ├─33044 litespeed (lscgid)
             └─33073 litespeed (lshttpd - #01)
```
The active (running) message indicates that LiteSpeed is running.

The server should now be running. Press <code>CTRL+C</code> to exit the service output.

If your server is not running, you can start the server using systemctl:

```
sudo systemctl start lsws
```



Before visiting it in your browser, you will need to open some ports on your firewall, which you can achieve with the **ufw* command:

```
sudo ufw allow 8088,7080,443,80/tcp
```

The first port, 80, is the default port for LiteSpeed’s example site. After allowing it with ufw, it should now be accessible to the public. In your web browser, navigate to your server’s IP address or domain name, followed by :8088 to specify the port:

```
http://server_domain_or_IP
```
Your browser will load the default LiteSpeed web page, which will match the following image:

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-80.png?raw=true" />

You can look around the example website to explore the features offered by the web server.

To see the GUI-based Admin Panel, access port <code>7080</code>:


```
http://your_server_ip:7080
```
You will likely see a page warning you that the SSL certificate from the server cannot be validated. Because this is a self-signed certificate, this message is expected. Click through the available options to proceed to the site. In Chrome, you must click <code>Advanced</code> and then <code>Proceed to…</code> .

You will be prompted to enter the administrative username and password that you selected with the admpass.sh script in the previous step:

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-7080.png?raw=true" />

Once authenticated, you will be presented with the LiteSpeed administration interface:

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-admin-page.png?raw=true" />

The majority of your configuration for the web server will take place via this dashboard.


<a id="s3" name="steps-2"></a>
### 2. Install some Utility packages

```
apt install -y git wget curl unzip nano zip
```
### 2.a. PHP 8.1+

First add this PPA repository:

```
add-apt-repository ppa:ondrej/php
```

Then install php 8.1 with these extensions:

```
apt update
apt install -y php8.1 libapache2-mod-php8.1 php8.1-mysql \
    php8.1-cli php8.1-common php8.1-fpm php8.1-soap php8.1-gd \
    php8.1-opcache  php8.1-mbstring php8.1-zip \
    php8.1-bcmath php8.1-intl php8.1-xml php8.1-curl  \
    php8.1-imap php8.1-ldap php8.1-gmp php8.1-redis
```

### 2.b. Setting Up IonCube

```
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz 
tar xvfz ioncube_loaders_lin_x86-64.tar.gz 
```
Copy the ion-cube loader to Directory. Replace your yourpath below with actual path that was shown with the output of first command below, and restart the both nginx and php.

```
php -i | grep extension_dir
cp ioncube/ioncube_loader_lin_8.1.so /usr/lib/php/'replaceyourpath'
sed -i '2 a zend_extension = "/usr/lib/php/'replaceyourpath'/ioncube_loader_lin_8.1.so"' /etc/php/8.1/fpm/php.ini
sed -i '2 a zend_extension = "/usr/lib/php/'replaceyourpath'/ioncube_loader_lin_8.1.so"' /etc/php/8.1/cli/php.ini
systemctl restart lsws
systemctl restart php8.1-fpm
```

### 2.c. MySQL

The official Faveo installation uses Mysql as the database system and this is the only official system we support. While Laravel technically supports PostgreSQL and SQLite, we can’t guarantee that it will work fine with Faveo as we’ve never tested it. Feel free to read Laravel’s documentation on that topic if you feel adventurous.

Install Mysql 8.0 or MariaDB 10.6. Note that this only installs the package, but does not setup Mysql. This is done later in the instructions:

### For Ubuntu 18.04

```cpp
sudo apt update
sudo apt install software-properties-common -y
curl -LsS -O https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
sudo bash mariadb_repo_setup --mariadb-server-version=10.6
sudo apt update
sudo apt install mariadb-server mariadb-client
sudo systemctl enable mariadb
```

### For Ubuntu 20.04

```cpp
sudo apt install dirmngr ca-certificates software-properties-common gnupg gnupg2 apt-transport-https curl -y
curl -fsSL http://repo.mysql.com/RPM-GPG-KEY-mysql-2022 | gpg --dearmor | sudo tee /usr/share/keyrings/mysql.gpg > /dev/null
echo 'deb [signed-by=/usr/share/keyrings/mysql.gpg] http://repo.mysql.com/apt/ubuntu focal mysql-8.0' | sudo tee -a /etc/apt/sources.list.d/mysql.list
echo 'deb-src [signed-by=/usr/share/keyrings/mysql.gpg] http://repo.mysql.com/apt/ubuntu focal mysql-8.0' | sudo tee -a /etc/apt/sources.list.d/mysql.list
sudo apt update
sudo apt install mysql-community-server -y
sudo systemctl start mysql
sudo systemctl enable mysql
```

### For Ubuntu 22.04

```
sudo apt update
sudo apt install mariadb-server mariadb-client -y
sudo systemctl start mariadb
sudo systemctl enable mariadb
```

Secure your MySql installation by executing the below command. Set Password for mysql root user, remove anonymous users, disallow remote root login, remove the test databases and finally reload the privilege tables.

```
mysql_secure_installation 
```
phpMyAdmin(Optional): Install phpMyAdmin. This is optional step. phpMyAdmin gives a GUI to access and work with Database

```
apt install phpmyadmin
```

### 2.d. Install wkhtmltopdf

Wkhtmltopdf is an open source simple and much effective command-line shell utility that enables user to convert any given HTML (Web Page) to PDF document or an image (jpg, png, etc).

It uses WebKit rendering layout engine to convert HTML pages to PDF document without losing the quality of the pages. Its is really very useful and trustworthy solution for creating and storing snapshots of web pages in real-time.


### For Ubuntu 18.04 and 20.04

```cpp
apt-get -y install wkhtmltopdf
```

### For Ubuntu 22.04

```cpp
echo "deb http://security.ubuntu.com/ubuntu focal-security main" | sudo tee /etc/apt/sources.list.d/focal-security.list
        apt-get update; apt install libssl1.1 -y
        wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.focal_amd64.deb 
    
        dpkg -i wkhtmltox_0.12.6-1.focal_amd64.deb
        apt --fix-broken install -y

```

Once the softwares above are installed:


<a id="s4" name="steps-3"></a>
### 3. Upload Faveo

#### For Faveo Freelancer, Paid and Enterprise Version

Please download Faveo Helpdesk from [https://billing.faveohelpdesk.com](https://billing.faveohelpdesk.com/) and upload it to below directory

Navigate to the virtual host root which is /usr/local/lsws/Example/html

```
cd /usr/local/lsws/DEFAULT/html
mkdir faveo
```
#### Extracting the Faveo-Codebase zip file

```
unzip "faveo.zip" -d faveo
```
#### For Faveo Community Version

You may install Faveo by simply cloning the repository. In order for this to work with Apache, you need to clone the repository in a specific folder:

```
cd /usr/local/lsws/DEFAULT/html
git clone https://github.com/ladybirdweb/faveo-helpdesk.git faveo
```

You should check out a tagged version of Faveo since master branch may not always be stable. Find the latest official version on the [release page](https://github.com/ladybirdweb/faveo-helpdesk/releases)

Give proper permissions to the project directory by running:You should check out a tagged version of Faveo since master branch may not always be stable. Find the latest official version on the release page

Give proper permissions to the project directory by running:

```
chown -R nobody:nogroup faveo
cd faveo
find . -type f -exec chmod 644 {} \;
find . -type d -exec chmod 755 {} \;
```

<a id="s5" name="steps-4"></a>
### 4. Configure Litespeed webserver

### 4.a. LSPHP 8.1+ 

LiteSpeed hosts its code on its own repository. Add this repository to the apt package manager’s sources list with the following command:

```
sudo wget -O - https://repo.litespeed.sh | sudo bash
```

Update the list of repositories to ensure that the newly added repository is scanned by the apt package manager:

```
sudo apt update
```

Next, install the litespeed package:

```
sudo apt install lsphp81 lsphp81-curl lsphp81-imap lsphp81-mysql lsphp81-ldap lsphp81-redis lsphp81-ioncube 
```







Configuring LSPHP 8.1

Via <code><b>http://your_server_ip:7080</b></code>, log in to the Admin Panel (using the credentials you just set up) and navigate to the Server Configuration section. Then, click the External App tab.

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-server-external.png?raw=true" />

You will see the following screen:

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-server-external-new.png?raw=true" />

Here, you can configure your server to use any specific PHP processor. For this tutorial, we will use lsphp81.

- Name: <code>lsphp81</code>
- Address: <code>uds://tmp/lshttpd/lsphp80.sock</code>
- Max Connections: <code>35</code>
- Environment: <code>PHP_LSAPI_MAX_REQUESTS=50 
                     PHP_LSAPI_CHILDREN=35 
                     LSAPI_AVOID_FORK=200M</code>
- Initial Request Timeout (secs): <code>60</code>
- Retry Timeout : <code>0</code>
- Persistent Connection: <code>Yes</code>
- DEFAULT Response Buffering: <code>no</code>
- DEFAULT Start By Server: <code>Yes(Through CGI Daemon)</code>
- Command: <code>$SERVER_ROOT/lsphp81/bin/lsphp</code>
- Back Log: <code>100</code>
- Instances: <code>1</code>
- Priority: <code>0</code>
- Memory Soft Limit (bytes): <code>2047M</code>
- Memory Hard Limit (bytes): <code>2048M</code>
- Process Soft Limit: <code>1400</code>
- Process Hard Limit: <code>1500</code>

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-server-external-new-add.png?raw=true" />

navigate to the Server Configuration section. Then, click the Script Handler tab.

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-server-scripthandler.png?raw=true" />

- Suffixes: <code>php81</code>
- Handler Type: <code>Litespedd SAPI</code>
- Handler Name: <code>[Server Level]: lsphp81</code>

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-server-scripthandler-edit.png?raw=true" />

Then, click the PHP tab. Edit PHP Global Configuration.

- Detached Mode: <code>Yes</code>
- Control Panel: <code>Litespedd Native</code>

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-server-php-globalconfig.png?raw=true" />

Then, Edit PHP Handler Definition.

- Handler ID: <code>php81</code>
- Command: <code>$SERVER_ROOT/lsphp81/bin/lsphp</code>
- Handler Suffixes: <code>php</code>

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-server-php-handler.png?raw=true" />



Use the **Graceful Restart** button in the top right to restart the web server. The **Graceful Restart** button is highlighted in the upper right of the following screencapture:


Verify that your server is now using the specified PHP version by visiting the informational page at port <code>80</code>:

```
http://your_server_ip/phpinfo.php
```

After installing LSPHP 8.1, run the commands below to open PHP default config file.

```
nano /usr/local/lsws/lsphp81/etc/php/8.1/litespeed/php.ini
```
Then make the changes on the following lines below in the file and save. The value below are great settings to apply in your environment.

```
file_uploads = On
allow_url_fopen = On
short_open_tag = On
memory_limit = 256M
cgi.fix_pathinfo = 0
upload_max_filesize = 100M
post_max_size = 100M
max_execution_time = 360
```

### 4.b Setting Up a Virtual Host

Moving next to configure the rewrite module which is an essential requirement for the WordPress features. Go to the Virtual Hosts and click on the view icon.

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-virtualhost-view.png?raw=true" />

Click on the **General** tab and edit the *General options* with the edit icon at the top right corner.

In the **Document Root** field, type <code>$VH_ROOT/html/faveo</code>

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-virtualhost-general.png?raw=true" />

Then again on the **General** tab of *Virtual Hosts* configuration, click the edit icon next to the *Index Files* section.

In the **Index Files** field, add *index.php* at the beginning of the section. Then click the save button at the top right corner.

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-virtualhost-general-index.png?raw=true" />


Then again on the General tab of Virtual Hosts configuration, click the edit icon next to the **ht access** section.

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-virtualhost-htaccess.png?raw=true" />

Next, go to the **Script Handler tab** of the *Virtual Hosts* configuration view and edit the *Script Handler Definition* options.

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-virtualhost-scripthandler.png?raw=true" />

Next, go to the **Rewrite tab** of the *Virtual Hosts* configuration view and edit the *Rewrite Control* options.

Set **Enable Rewrite** and Auto Load from *.htaccess* to Yes and click the save icon at the top right corner.


<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-virtualhost-rewrite.png?raw=true" />





Once you’ve configured the litespeed server, Click the gracefully restart icon to apply the changes.



<a id="s6" name="steps-5"></a>
### 5. Setup the database

Log in with the root account to configure the database.

```
mysql -u root -p
```

Create a database called ‘faveo’.

```
CREATE DATABASE faveo;
```

Create a user called ‘faveo’ and its password ‘strongpassword’.

```
CREATE USER 'faveo'@'localhost' IDENTIFIED BY 'strongpassword';
```
We have to authorize the new user on the faveo db so that he is allowed to change the database.

```
GRANT ALL ON faveo.* TO 'faveo'@'localhost';
```

And finally we apply the changes and exit the database.

```
FLUSH PRIVILEGES;
exit
```


<a id="s7" name="steps-6"></a>
### 6. SSL Installation

Secure Sockets Layer (SSL) is a standard security technology for establishing an encrypted link between a server and a client. Let’s Encrypt is a free, automated, and open certificate authority.

Faveo Requires HTTPS so the SSL is a must to work with the latest versions of faveo, so for the internal network and if there is no domain for free you can use the Self-Signed-SSL.

[Let’s Encrypt SSL installation documentation](https://github.com/tamilselvan-lws/Documents/blob/main/Let's%20Encrypt%20SSL%20-%20LSWS.md)



<a id="s8" name="steps-7"></a>
### 7. Configure cron job

Faveo requires some background processes to continuously run. Basically those crons are needed to receive emails To do this, setup a cron that runs every minute that triggers the following command php artisan schedule:run.Verify your php ececutable location and replace it accordingly in the below command.

```
sudo crontab -e
```
```
* * * * * /usr/bin/php -q /usr/local/lsws/Example/html/faveo/artisan schedule:run 2>&1
```
```
sudo crontab -l
```

<a id="s9" name="steps-8"></a>
### 8. Redis Installation

Redis is an open-source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.

This is an optional step and will improve system performance and is highly recommended.

[Redis installation documentation](https://github.com/tamilselvan-lws/Documents/blob/main/Redis.md)


<a id="s10" name="steps-9"></a>
### 9. Install Faveo
At this point if the domainname is propagated properly with your server’s IP you can open Faveo in browser just by entering your domainname. You can also check the Propagation update by Visiting this site www.whatsmydns.net.

Now you can install Faveo via [GUI](https://docs.faveohelpdesk.com/docs/installation/installer/gui) Wizard or [CLI](https://docs.faveohelpdesk.com/docs/installation/installer/cli)


<a id="s11" name="steps-10"></a>
### 10. Faveo Backup
At this stage, Faveo has been installed, it is time to setup the backup for Faveo File System and Database. [Follow this article](https://docs.faveohelpdesk.com/docs/helper/backup) to setup Faveo backup.


<a id="s12" name="steps-11"></a>
### 11. Final step
The final step is to have fun with your newly created instance, which should be up and running to <code>http://localhost</code> or the domain you have configured Faveo with.
