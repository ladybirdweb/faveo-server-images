# Installing Faveo Helpdesk Freelancer, paid and Enterprise on Windows <!-- omit in toc -->


<img alt="Ubuntu" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/Windows_logo_%E2%80%93_2012_%28dark_blue%29.svg/65px-Windows_logo_%E2%80%93_2012_%28dark_blue%29.svg.png" width="65"  />

Faveo can run on [Windows Server 2019](https://www.microsoft.com/en-au/windows-server).

-   [Prerequisites](#prerequisites)
-   [Installation steps](#installation-steps)
    -   [1. Upload Faveo](#1-upload-faveo)
    -   [2. Setup the database](#2-setup-the-database)
    -   [3. Configure IIS webserver](#5-configure-apache-webserver)
    -   [4. Install Faveo](#3-gui-faveo-installer)
    -   [5. Configure Task Scheduler](#4-configure-cron-job)
    -   [6. Final step](#final-step)


<a id="prerequisites" name="prerequisites"></a>
## Prerequisites

Faveo depends on the following:

-   **IIS**
-   **PHP 7.3+** with the following extensions: curl, dom, gd, json, mbstring, openssl, pdo_mysql, tokenizer, zip
-   **MySQL 5.7+** or **MariaDB 10.3+**
-   **Task Scheduler+**

### Step 1: Install IIS server
To install IIS, open windows manager and go to Manage button on top. Click add/remover role and select IIS in server Roles and click next..

Select the Server Roles

-   File and Storage Services
-   Web Server(IIS)

<img src="https://camo.githubusercontent.com/9419f38c09fee84514e6e8c8e118cd5fe1e7a822/68747470733a2f2f7777772e666176656f68656c706465736b2e636f6d2f757365722d6d616e75616c2f696d616765732f666176656f696e7374616c6c6174696f6e77696e646f77732f312e6a7067" alt="" />
Select the Features

-   .NET Framework 3.5 (Full package)
-   .NET Framework 4.5 (Full Package)
    
    <img src="https://camo.githubusercontent.com/067c8e6308a463f326fbbaaaa35d43c6c51a730c/68747470733a2f2f7777772e666176656f68656c706465736b2e636f6d2f757365722d6d616e75616c2f696d616765732f666176656f696e7374616c6c6174696f6e77696e646f77732f322e6a7067" alt="" />

Click Next and confirm the settings. It will get the IIS installed on the server. To verify the installation, you can type the following url in the browser

```
http://localhost
```

### Step 2: Download & install Web platform installer

To make the installation easy and smooth, we will be using Web platform Installer. It is a special tool provided by Microsoft for quick installation of most of our requirement. You can download it from following link

[Click here to download Web platform installer](https://www.microsoft.com/web/downloads/platform.aspx)


### Step 3: Installation of Packages

Open the Web Platform Installer and search the following Extensions to add

-   PHP 7.3
-   PHP Manager for IIS
-   URLRewrite
-   MySQL for Windows 5.7
-   MySQL Connector/Net

<img src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/05/1589806536webplatform.png" alt="" />

-   [Alternative Link For Downloading PHP Manager](https://www.faveohelpdesk.com/user-manual/windows_installation/phpmanager.zip)

Click on install. It will ask you to set password for mysql ‘root’ user. Enter some strong password and remember it for later use.

The installation should take few minutes to complete

### Step 4: Enable Cacert.pem file in php.ini file

#### Step 4(a)
Download and extract the pem file save it inside your php directory

(C:\Program Files\iis express\PHP\v7.3)

[Alternative Link For Downloading pem file](https://www.faveohelpdesk.com/user-manual/windows_installation/pem_file.zip)

#### Step 4(b)
Uncomment the below line and add the directory of the file in your php.ini file

```
curl.cainfo = "C:\Program Files\iis express\PHP\v7.3\cacert.pem"
```

Note: The location of PHP 7.3 in IIS Server is following. You will need this location to add extensions in your websites.

<img src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/05/1589806641php.png" alt="" />

### Step 5: Install Ioncube Loader

#### Step 5(a)
Download the Ioncube loader from the below link and extract

[Alternative Link For Downloading IonCube](http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_win_nonts_vc14_x86-64.zip0)

#### Step 5(b)
Copy the ioncube folder contents and paste it in your document root and ext folderinside your php folder

<img src="https://camo.githubusercontent.com/7b51511f7442ea3ee1171a17756fc0f5d035b849/68747470733a2f2f666176656f68656c706465736b2e636f6d2f757365722d6d616e75616c2f696d616765732f666176656f5f70726f5f696e7374616c6c6174696f6e5f77696e646f77732f696f6e637562656c6f616465726c6f6164657277697a617264646f63756d656e74726f6f742e6a7067" alt="" />
<img src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/05/1589806754php1.png" alt="" />
<img src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/05/1589806764php2.png" alt="" />

#### Step 5(c)
Add the below line in your php.ini file

```
zend_extension = "C:\Program Files\iis express\PHP\v7.3\ext\ioncube/ioncube_loader_win_7.3.dll"
```

Uncomment the below MySQL extension's in php.ini file

```
extension=php_mysqli.dll
extension=php_pdo_mysql.dll 
```

#### Step 5(d)
Run the below URL

```
your_domain_name/loader-wizard.php
```

<img src="https://camo.githubusercontent.com/b41798cb16af8fd8a4c3fde2f7c2121ecb874777/68747470733a2f2f666176656f68656c706465736b2e636f6d2f757365722d6d616e75616c2f696d616765732f666176656f5f70726f5f696e7374616c6c6174696f6e5f77696e646f77732f696f6e637562656c6f6164657275726c2e6a7067" alt="" />


<a id="installation-steps" name="installation-steps"></a>
## Installation steps

Once the softwares above are installed:

<a id="1-upload-faveo" name="1-upload-faveo"></a>
### 1. Upload Faveo
Please download Faveo Helpdesk from [https://billing.faveohelpdesk.com](https://billing.faveohelpdesk.com) and upload it to below directory

```
c:/inetpub/wwwroot/
```

<a id="2-setup-the-database" name="2-setup-the-database"></a>
### 2. Setup the database

Open MySQL 5.5 Command Line Client and run the below commands.

```sql
CREATE DATABASE faveo;

GRANT ALL PRIVILEGES ON faveo.* TO 'faveouser'@'localhost' IDENTIFIED BY 'faveouserpass';

FLUSH PRIVILEGES;

quit 
```

<a id="5-configure-apache-webserver" name="5-configure-apache-webserver"></a>
### 3. Configure IIS webserver

1. Configure web.config file for IIS

Copy the Contents Below and save the file under /faveo/public/ as web.config.

```
<?xml version="1.0" encoding="UTF-8"?>

<configuration>

    <system.webServer>

        <rewrite>

            <rules>

                <rule name="Imported Rule 1" stopProcessing="true">

                    <match url="^" ignoreCase="false" />

                    <conditions logicalGrouping="MatchAll">

                        <add input="{REQUEST_FILENAME}" matchType="IsDirectory" ignoreCase="false" negate="true" />

                        <add input="{REQUEST_FILENAME}" matchType="IsFile" ignoreCase="false" negate="true" />

                    </conditions>

                    <action type="Rewrite" url="index.php" />

                </rule>

            </rules>

        </rewrite>

    </system.webServer>

</configuration>
```

2. Give Permissions to the Faveo folder

We need to give full write permission to following folders

```
/storage

/public

/bootstrap/cache
```

<img src="https://camo.githubusercontent.com/f133d3f80548c359f3b4f54b109422bfd428b406/68747470733a2f2f7777772e666176656f68656c706465736b2e636f6d2f757365722d6d616e75616c2f696d616765732f666176656f696e7374616c6c6174696f6e77696e646f77732f31312e6a7067" alt="" />


Open IIS and go to default website.

Click on Basic Setting on the right pane. And set the path of root folder to following

```
C:\inetpub\wwwroot\faveo\public
```
<img src="https://camo.githubusercontent.com/37530a227e367268afd3106b89f1e1dd343e1fdf/68747470733a2f2f7777772e666176656f68656c706465736b2e636f6d2f757365722d6d616e75616c2f696d616765732f666176656f696e7374616c6c6174696f6e77696e646f77732f362e6a7067" alt="" />
To Open the Faveo on your your domain , you must set the binding.

Go to Bindings option on right pane and select “HTTP” and edit the hostname to your concern.

 

Now you can open the browser and enter the IP or Domain Name to open Faveo

<a id="3-gui-faveo-installer" name="3-gui-faveo-installer"></a>
### 4. Install Faveo

Now you can install Faveo via [GUI](https://support.faveohelpdesk.com/show/web-gui-installer) Wizard or [CLI](https://support.faveohelpdesk.com/show/cli-installer).


<a id="4-configure-cron-job" name="4-configure-cron-job"></a>
### 5. Configure Task Scheduler

In Windows there is a task scheduler. You open it by pressing 

<img src="" alt="" />
 + R and Type "taskschd.msc".

To Setup Schedule task for Faveo. Open Task scheduler on server and follow this steps

Right click Task scheduler and select “create basic task” and enter a name 

Select the Task Running options Daily

In program/script field enter the following value:

```
C:\Windows\System32\cmd.exe
```

Add following value in Argument :

```
/c php "c:\inetpub\wwwroot\faveo\artisan" schedule:run
```

<img src="https://camo.githubusercontent.com/a203455406db5105822688c8a495d5aec323c454/68747470733a2f2f7777772e666176656f68656c706465736b2e636f6d2f757365722d6d616e75616c2f696d616765732f666176656f696e7374616c6c6174696f6e77696e646f77732f77696e646f77732e706e67" alt="" />
After that, the schedule task would appear on the list. Right click the task and go to properties -> Triggers

Select the schedule and click Edit and set the cron to run every 10 minutes. You can change according to your needs.
<img src="" alt="" />

<a id="final-step" name="final-step"></a>
### 6. Final step

The final step is to have fun with your newly created instance, which should be up and running to `http://localhost`.