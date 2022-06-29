---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/windows-iis/
redirect_from:
  - /theme-setup/
last_modified_at: 2022-06-29
last_modified_by: Mohammad_Asif
toc: true
title: Installing Faveo Helpdesk Freelancer, paid and Enterprise on Windows
---

<img alt="Windows" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Windows_logo_and_wordmark_-_2021.svg/250px-Windows_logo_and_wordmark_-_2021.svg.png" width="200"  />

Faveo can run on the [Windows Server](https://www.microsoft.com/en-au/windows-server).

[<strong>Installation Steps:</strong>](#installation-steps)


<b>1. Install IIS Server </b>

To install IIS Server open Server Manager and locate the *Manage* button on the top right corner click on it and select  *Add Roles and Features*.

- A wizard will open displaying the overview, click on *Next*, and under *Installation Type* select *Role-based and Feature-based installation* and select *Next*. 

- Leave the default in *Server Selection* and click *Next*. 

- Now under *Server Roles* search and enable the checkbox for *Web Server IIS* click on the *Add Features* window and proceed by clicking *Next*.



<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/Server-roles.png" width=400px; height=250px;>

- In the *Features* section locate the *.NET Framework 3.5 and .NET Framework 4.7* select the packages as shown in the below image:

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/netframeworl.png" width=400px; height=250px;>


- In the *Role Services* section locate the *Appplication Development* select the package *CGI* and click *Next*.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/cgi.png" width=400px; height=250px;>



- Click *Next* thrice to confirm the settings and finally click on *Install*. It will get the IIS installed on the server. To verify the installation, you can type the following URL in the browser

```
http://localhost/
```

<b> 2. Install PHP 7.3 </b>

-   [Click Here](https://windows.php.net/downloads/releases/archives/) to download PHP 7.3 NTS x64 zip file. Extract the zip file & rename it to *php7.3*. Now move the renamed *php7.3* folder to *C:\Program Files*.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/php.png" width=400px; height=250px;>

-   Open *php7.3* folder, find *php.ini-development* & rename it to *php.ini* to make it php configuration file.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/phpconfig.png" width=400px; height=250px;>

-   Open *php.ini* using Notepad++, add the below lines at the end of this file & save the file:

Faveo-Changes
```
error_log=C:\Windows\temp\PHP73x64_errors.log
upload_tmp_dir=C:\Windows\temp
session.save_path=C:\Windows\temp
cgi.force_redirect=0
cgi.fix_pathinfo=1
fastcgi.impersonate=1
fastcgi.logging=0
max_execution_time=300
date.timezone=Asia/Kolkata
extension_dir="C:\Program Files\php7.3\ext\"
```

ExtensionList
```
extension=php_mysqli.dll
extension=php_mbstring.dll
extension=php_gd2.dll
extension=php_gettext.dll
extension=php_curl.dll
extension=php_exif.dll
extension=php_xmlrpc.dll
extension=php_openssl.dll
extension=php_soap.dll
extension=php_pdo_mysql.dll
extension=php_pdo_sqlite.dll
extension=php_imap.dll
extension=php_tidy.dll
extension=php_fileinfo.dll
extension=php_ldap.dll
extension=php_redis.dll
```

<b> 3. Add Handler Mapping </b>


- Open Server Manager, locate *Tools* on the top right corner  of Dashboard, Click on it and select *Internet Information Services (IIS) Manager*.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/iis.png" width=800px; height=250px;>


- Now in the Left Panel of the IIS Manager window select your server then you will find the *Handler Mappings*. Open *Handler Mappings*, Click on *Add Module Mapping* in the Right Panel, a new window will appear. Add the below in respective boxes & click *OK*.

- RequestPath
```
*.php
```
- Module
```
FastCgiModule
```
- Executable (Optional)
```
"C:\Program Files\php7.3|php-cgi.exe"
```
- Name
```
"FastCGI"
```


<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/Handlermapings.png" width=400px; height=250px;>

- Open notepad and copy the below lines and save the file under the path *C:\inetpub\wwwroot* as *index.php*. Make sure while saving you select all file types otherwise you will end up having the file as index.php.txt
```
<?php
phpinfo();
?>
```

- Now in  IIS Manager window find the *Default Document*. Open *Default Document*, Click on *Add* in the Right Panel, a new window will appear. Add *index.php* as Name & click *OK*.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/indexphp.png" width=400px; height=250px;>

<b> 4. Install MariaDB-10.3/MySQL 5.7 </b>

-   [Click here ](https://downloads.mariadb.org/mariadb/) to download  *MariaDB-10.3* from the official MariaDB website.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/mariadb.png" width=400px; height=250px;>

- Execute the installer to perform the required installation steps and set the root password.

- [MySQL documentation](/docs/installation/providers/enterprise/mysql-windows)

<b>5. Download & Enable cacert.pem File in PHP Configuration File </b>

- [Click here](https://www.faveohelpdesk.com/user-manual/windows_installation/pem_file.zip)  to download *cacaert.pem* file. This is required to avoid the “cURL 60 error” which is one of the Probes that Faveo checks.
- Extract the *cacert.pem* file and copy it to *C:\Program Files\php7.3* path.
- Edit the *php.ini* located in *C:\Program Files\php7.3*, Uncomment *curl.cainfo* and add the location of cacert.pem to it as below:

```
curl.cainfo = "C:\Program Files\php7.3\cacert.pem"
```

<b>  6.  Install Ioncube Loader </b>

- [Click here](https://downloads.ioncube.com/loader_downloads/ioncube_loaders_win_nonts_vc15_x86-64.zip)  to download Ioncube Loader zip file, Extract the zip file

- Copy the *ioncube_loader_win_7.3.dll* file from extracted Ioncube folder and paste it in the PHP extension directory *C:\Program Files\php7.3\ext.*

- Add the below line in your php.ini file at the tarting to enable Ioncube.

```
zend_extension = "C:\Program Files\php7.3\ext\ioncube_loader_win_7.3.dll"
```


<b>7. Upload Faveo </b>

- Download the Faveo Helpdesk from https://billing.faveohelpdesk.com and upload it to the below directory.

```
C:\inetpub\wwwroot\
```

- Give full permissions to *IIS_IUSRS* and *Users* for the wwwroot folder.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/Permission.png" width=400px; height=250px;>

<b>8. Configure Faveo in IIS Manager </b>

- Open IIS Manager and in the left pane, Explore till you find *Default Web Site*, select it.
- Then in the right pane, you will see the *Basic Settings* option click on it, a new window will open as  shown below:


- Set the *Physical Path* value to: 

```
"%SystemDrive%\inetpub\wwwroot\public"
``` 


<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/BasicSettings.png" width=400px; height=250px;>

<b> 9. Configure web.config file for IIS </b>

- Open notepad and copy the below lines and save the file under the path *C:\inetpub\wwwroot\public* as *web.config*. Make sure while saving you select all file types.

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

<b>10. Setting up the Database </b>

Open MariaDB 10.3 Command Line Client and run the below command.

- Create a database called ‘faveo’.

```sql
CREATE DATABASE faveo;
```

- Create a user called ‘faveo’ and its password ‘strong password’.

```sql
CREATE USER 'faveo'@'localhost' IDENTIFIED BY 'strongpassword';
```

- We have to authorize the new user on the faveo DB so that he is allowed to change the database.

```sql
GRANT ALL ON faveo.* TO 'faveo'@'localhost';
```

- And finally, we apply the changes and exit the database.

```sql
FLUSH PRIVILEGES;
exit
```

<b>10. Configure IIS webserver </b>

By default, IIS configures PHP only to accept GET, POST, and HEAD request types. Since Faveo makes use of other requests types (such as DELETE and PUT), you must manually change the PHP handler to allow them.

- Open *IIS Manager*, Click on your Server Name which should load the dashboard with a handful of icons.

- Double-click on the *Handler Mappings* icon to bring up the Handler Mappings screen.

<img src="https://support.faveohelpdesk.com/uploads/2020/9/28/Screenshot-2014-06-04-15.01.17.png" width=400px; height=250px; />

- Then double-click on the *Handler* for PHP files to bring up the *Edit Module Mapping* window:

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/Verbs1.png" width=400px; height=250px;>

 **Edit Verbs**

- Click on the *Request Restrictions* button, then switch to the ***Verbs*** tab. Switch the radio button to *All Verbs*, then click *OK* to close the window, then *OK* again to close the other.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/Verbs2.png" width=400px; height=250px;>

- **Note:** You may be prompted with an alert to *fix* the path to the PHP executable. If so, just put double-quotation marks around the path that already exists in the *Executable* box and it will save successfully.

<b>11 Setting up Bindings</b>

- To Open the Faveo on your domain, you must set the binding.

- Open IIS Manager and in the left pane, Explore till you find *Default Web Site*, select it.

- Then in the right pane, you will see the *Bindings* option click on it, a new window will open select HTTP and edit the hostname to your concerned Domain as  shown below:

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/Bindings1.png" width=400px; height=250px;>

- Now you can open the browser and enter the IP or Domain Name to open Faveo.


**Disable WebDav (Optional)**

To test the successful configuration perform some delete operations in Faveo if the Delete operation fails then the above steps are not sufficient at this point you may need to remove WebDav:

- Go to *Control Panel > Uninstall Program > Turn Windows features on or off > IIS > World Wide Web Services > Common HTTP feature > WebDAV Publishing*.


<b>12 Configure Task Scheduler</b>

- To open Task scheduler press *Win+R* and type *taskschd.msc*.
- On the Right pane of the Task scheduler select *Create Basic Task* enter a *Name* for the task and click *Next*.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/TaskScheduler.png" width=400px; height=250px;>

- Under *Task Trigger*, section select *Daily* and click *Next* and leave the default values in *Daily* section tick the *Synchronize across time zones* and proceed *Next*.

- Now under the *Action* section select *Start a program* and click *Next*. 


- In *Start a program* copy the below value into the *program/script field*.
```
C:\Windows\System32\cmd.exe
```
- Add the following highlighted values to the Argument :

- This is for faveo incoming mail,esacalation, faveo update check.
```
c:\inetpub\wwwroot\faveo\artisan" schedule:run
```

- This is for the reports.
```
c:\inetpub\wwwroot\faveo\artisan queue:listen database --queue=reports
```

- This is for recurring.
```
c:\inetpub\wwwroot\faveo\artisan" queue:listen database --queue=recurring
```

- This is for outgoing mail
```
c:\inetpub\wwwroot\faveo\artisan queue:work database
```


<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/Taskschd.gif" width=400px; height=250px;>

- Finally under the *Finish* section select the *checkbox* to open the properties window after finish and click the *Finish* button.

- In the properties, window selects the *Triggers* tab, click on *Edit* and select the checkbox for *Repeat task every* set values to run every *5 minutes*, for a duration of *indefinitely* and click on *OK*.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/TaskTrigger.png" width=400px; height=250px;>


<b>13. Redis Installation</b>

Redis is an open-source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.

This  will improve system performance and is highly recommended.

- [Redis Installation documentation](/docs/installation/providers/enterprise/redis-windows)



<b>14. SSL Installation</b>

Secure Sockets Layer (SSL) is a standard security technology for establishing an encrypted link between a server and a client. Let’s Encrypt is a free, automated, and open certificate authority.

Faveo Requires HTTPS so the SSL is a must to work with the latest versions of faveo, so for the internal network and if there is no domain for free you can use the Self-Signed-SSL.

- [Let’s Encrypt SSL installation documentation](/docs/installation/providers/enterprise/windows-iis-ssl)

- [Self-Signed SSL installation documentation](/docs/installation/providers/enterprise/self-signed-ssl-windows)


<b>15. Install Faveo</b>

Now you can install Faveo via [GUI](/docs/installation/installer/gui) Wizard or [CLI](/docs/installation/installer/cli)
