---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/windows-iis/
redirect_from:
  - /theme-setup/
last_modified_at: 2023-06-20
last_modified_by: Mohammad_Asif
toc: true
title: Installing Faveo Helpdesk on Windows Server
---
<style>p>code, a>code, li>code, figcaption>code, td>code {background: #dedede;}</style>

<img alt="Windows" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Windows_logo_and_wordmark_-_2021.svg/250px-Windows_logo_and_wordmark_-_2021.svg.png" width="200"  />

Faveo can run on the [Windows Server](https://www.microsoft.com/en-au/windows-server).


- [<strong>Installation steps:</strong>](#installation-steps)

  - [<strong>1.Install IIS Server</strong>](#1Install-IIS-Server)
  - [<strong> 2. Install PHP 8.1 </strong>](#2Install-PHP-8.1)
  - [<strong> 3. Create FastCGI Handler Mapping </strong>](#3Create-FastCGI-Handler-Mapping)
  - [<strong> 4. Install MariaDB 10.6/MySQL 8.0 </strong>](#4Install-MariaDB-10.6/MySQL-8.0)
  - [<strong> 5. Install Ioncube Loader </strong>](#5Install-Ioncube-Loader)
  - [<strong> 6. Install wkhtmltopdf </strong>](#6Install-wkhtmltopdf)
  - [<strong> 7. Upload Faveo </strong>](#7Upload-Faveo)
  - [<strong> 8. Configure Faveo in IIS Manager </strong>](#8Configure-Faveo-in-IIS-Manager)
  - [<strong> 9. Configure web.config file for IIS </strong>](#9Configure-web.config-file-for-IIS)
  - [<strong> 10. Setting up the Database </strong>](#10Setting-up-the-Database)
  - [<strong> 11. Setting up Bindings </strong>](#11Setting-up-Bindings)
  - [<strong> 12. Set Cron & Configure Queue Driver </strong>](#12Configure-Task-Scheduler)
  - [<strong> 13. SSL Installation </strong>](#13SSL-Installation)
  - [<strong> 14. Install Faveo </strong>](#14Install-Faveo)
  - [<strong>15. Faveo Backup</strong>](#15-faveo-backup)

The Installation steps listed above are to be followed to install Faveo on your Windows-IIS Server.

Before we follow the installation steps <a href="https://notepad-plus-plus.org/downloads/" target="_blank" rel="noopener">Notepad++</a>  ,  <a href="https://www.win-rar.com/download.html?&L=0" target="_blank" rel="noopener">Winrar</a> &  <a href="https://7-zip.org/download.html" target="_blank" rel="noopener">7-Zip</a> must be installed.

<a id="1Install-IIS-Server" name="1Install-IIS-Server"></a>

### <strong>1. Install IIS Server</strong>

To install IIS Server open Server Manager and locate the <b><code>Manage</code></b> button on the top right corner click on it and select  <b><code>Add Roles and Features</code></b>.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/servermanager.png" alt="" style=" width:550px ; height:120px ">

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/addroles.png" alt="" style=" width:550px ; height:120px ">

- A wizard will open displaying the overview, click on <b><code>Next</code></b>, and under <b><code>Installation Type</code></b> select <b><code>Role-based and Feature-based installation</code></b> and select <b><code>Next</code></b>. 

- Leave the default in <b><code>Server Selection</code></b> and click <b><code>Next</code></b>. 

- Now under <b><code>Server Roles</code></b> search and enable the checkbox for <b><code>Web Server IIS</code></b> click on the <b><code>Add Features</code></b> window and proceed by clicking <b><code>Next</code></b>.



<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/Server-roles.png?raw=true" alt="" style=" width:400px ; height:250px ">


- In the <b><code>Features</code></b> section locate the <b><code>.NET Framework 3.5 and .NET Framework 4.7</code></b> select the packages as shown in the below image:

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/netframeworl.png?raw=true" alt="" style=" width:400px ; height:250px ">


- In the <b><code>Role Services</code></b> section locate the <b><code>Application Development</code></b> select the package <b><code>CGI</code></b> and click <b><code>Next</code></b>.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/cgi.png?raw=true" alt="" style=" width:400px ; height:250px ">



- Click <b><code>Next</code></b> thrice to confirm the settings and finally click on <b><code>Install</code></b>. It will get the IIS installed on the server. To verify the installation, you can type the following URL in the browser

```
http://localhost/
```

<a id="2Install-PHP-8.1" 
name="2Install-PHP-8.1"></a>

### <strong>2. Install PHP 8.1</strong>

-   <a href="https://windows.php.net/downloads/releases/archives/" target="_blank" rel="noopener">Click Here</a> to download php 8.1.9 NTS 64bit file. Extract the zip file & "rename it to <b><code>php8.1</code></b>. Now move the renamed <b><code>php8.1</code></b> folder to <b><code>C:\php8.1</code></b>.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/GUI-images/php819.png" alt="" style=" width:400px ; height:150px ">

-   Open <b><code>php8.1</code></b> folder, find <b><code>php.ini-development</code></b> & rename it to <b><code>php.ini</code></b> to make it php configuration file.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/phpconfig.png?raw=true" alt="" style=" width:400px ; height:250px ">

-   Open <b><code>php.ini</code></b> using Notepad++, add the below lines at the end of this file & save the file:

Required configuration changes for Faveo Helpdesk.
```
error_log=C:\Windows\temp\PHP81x64_errors.log
upload_tmp_dir="C:\Windows\Temp"
session.save_path="C:\Windows\Temp"
cgi.force_redirect=0
cgi.fix_pathinfo=1
fastcgi.impersonate=1
fastcgi.logging=0
max_execution_time=300
date.timezone=Asia/Kolkata
extension_dir="C:\php8.1\ext\"
upload_max_filesize = 100M
post_max_size = 100M
memory_limit = 256M
```

Uncomment these extensions.
```
extension=bz2
extension=curl
extension=fileinfo
extension=gd2
extension=imap
extension=ldap
extension=mbstring
extension=mysqli
extension=soap
extension=sockets
extension=sodium
extension=openssl
extension=pdo_mysql
```
### <strong>2.a. Update the Environment Variable for PHP Binary</strong>
- Right click on This PC, go to Properties > Advanced System Settings > Environment Variables.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/env1.png" alt="" style=" width:500px ; height:200px ">

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/env2.png" alt="" style=" width:500px ; height:300px ">

- Now click on Path > Edit > New & add copied path C:\php8.1\ here and click OK in all 3 tabs.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/envpath.png" alt="" style=" width:500px ; height:300px ">

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/env6.png" alt="" style=" width:500px ; height:300px ">

### <strong>2.b. Enable cacert.pem File in PHP Configuration File</strong>

-   <a href="https://www.faveohelpdesk.com/user-manual/windows_installation/pem_file.zip)" target="_blank" rel="noopener">Click Here</a> to download <b><code>cacaert.pem</code></b> file. This is required to avoid the “cURL 60 error” which is one of the Probes that Faveo checks.
- Extract the <b><code>cacert.pem</code></b> file and copy it to <b><code>C:\php8.1</code></b> path.
- Edit the <b><code>php.ini</code></b> located in <b><code>C:\php8.1</code></b>, Uncomment <b><code>curl.cainfo</code></b> and add the location of cacert.pem to it as below:

```
curl.cainfo = "C:\php8.1\cacert.pem"
```


<a id="3Create-FastCGI-Handler-Mapping" 
name="3Create-FastCGI-Handler-Mapping"></a>

### <strong>3. Create FastCGI Handler Mapping</strong>


- Open Server Manager, locate <b><code>Tools</code></b> on the top right corner  of the Dashboard, Open <b><code>Internet Information Services (IIS) Manager</code></b>.
<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/iis.png?raw=true" alt="" style=" width:550px ; height:150px ">


- Now in the Left Panel of the IIS Manager select the server then you will find the <b><code>Handler Mappings</code></b> it will populate the available options to configure.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/handlermap.png" alt="" style=" width:400px ; height:250px ">

- Open <b><code>Handler Mappings</code></b>, Click on <b><code>Add Module Mapping</code></b> in the Right Panel, Add Module Mapping window will appear. Add the below values in the respective fields.


- RequestPath
```
<b><code>.php
```
- Module
```
FastCgiModule
```
- Executable (Optional)
```
"C:\php8.1\php-cgi.exe"
```
- Name
```
"FastCGI"
```

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/modulemapping.png" alt="" style=" width:400px ; height:250px ">

By default, IIS configures PHP only to accept GET, POST, and HEAD request types. Since Faveo makes use of other requests types (such as DELETE and PUT), you must manually change the PHP handler to allow them.

- Click on the <b><code>Request Restrictions</code></b> button, then switch to the <b><code>Verbs</code></b> tab. Switch the radio button to <b><code>All Verbs</code></b>, then click <b><code>OK</code></b> to close the window, then <b><code>OK</code></b> again to close the other.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/Verbs2.png?raw=true" alt="" style=" width:400px ; height:250px ">

**Note:** You may be prompted with an alert to <b><code>fix</code></b> the path to the PHP executable. If so, just put double-quotation marks around the path that already exists in the <b><code>Executable</code></b> box and it will save successfully.

- Open notepad and copy the below lines and save the file under the path <b><code>C:\inetpub\wwwroot</code></b> as <b><code>index.php</code></b>. Make sure while saving you select all file types otherwise you will end up having the file as index.php.txt
```
<?php
phpinfo();
?>
```

- Now go back to the main server configuration and select <b><code>Default Document</code></b>. Open <b><code>Default Document</code></b>, Click on <b><code>Add</code></b> from the Right Panel, a new window will appear. Add the value <b><code>index.php</code></b> and click <b><code>OK</code></b>.


<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/defaultdoc.png" alt="" style=" width:400px ; height:250px ">
<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/indexphp.png?raw=true" alt="" style=" width:400px ; height:250px ">

- Now if you visit "http://localhost" in the browser you should be able to see PHP Info page.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/phpinfo.png?raw=true" alt="" style=" width:400px ; height:250px ">

**Note:** If you don't see the above php page and see the error page like below, you need to install the relevant C++ Redistributable for Visual Studio.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/GUI-images/error-iis.png" alt="" style=" width:400px ; height:250px ">

#### Install Visual Studio (Conditional Step)
- <a href="https://docs.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-170" target="_blank" rel="noopener" > Click Here</a> to download the Visual Studio.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/apache4.png" alt="" style=" width:500px ; height:250px ">

- Execute the installer to perform the required installation.
- Accept the License Agreement terms and click <b><code>Install</code></b>.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/apache4a.png" alt="" style=" width:500px ; height:250px ">

- Click <b><code>Close</code></b> to finish the installation.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/apache4b.png" alt="" style=" width:500px ; height:250px ">



<a id="4Install-MariaDB-10.6/MySQL-8.0" 
name="4Install-MariaDB-10.6/MySQL-8.0"></a>


### <strong>4. Install MariaDB 10.6/MySQL 8.0</strong>

- An open-source relational database management system(RDBMS) can be chosen among the MariaDB and MySQL.

- [MariaDB documentation](/docs/installation/providers/enterprise/mariadb-windows)
- [MySQL documentation](/docs/installation/providers/enterprise/mysql-windows)



<a id="5Install-Ioncube-Loader" 
name="5Install-Ioncube-Loader"></a>

### <strong>5. Install Ioncube Loader</strong>

-   <a href="https://downloads.ioncube.com/loader_downloads/ioncube_loaders_win_nonts_vc16_x86-64.zip" target="_blank" rel="noopener">Click Here</a> to download Ioncube Loader zip file, Extract the zip file.

- Copy the <b><code>ioncube_loader_win_8.1.dll</code></b> file from extracted Ioncube folder and paste it in the PHP extension directory <b><code>C:\php8.1\ext.</code></b>

- Add the below line in your php.ini file at the starting to enable Ioncube.

```
zend_extension = "C:\php8.1\ext\ioncube_loader_win_8.1.dll"
```

<a id="6Install-wkhtmltopdf" 
name="6Install-wkhtmltopdf"></a>

### <strong>6. Install wkhtmltopdf</strong>

Wkhtmltopdf is an open source simple and much effective command-line shell utility that enables user to convert any given HTML (Web Page) to PDF document or an image (jpg, png, etc). It uses WebKit rendering layout engine to convert HTML pages to PDF document without losing the quality of the pages. Its is really very useful and trustworthy solution for creating and storing snapshots of web pages in real-time.

-   <a href="https://wkhtmltopdf.org/downloads.html" target="_blank" rel="noopener">Click Here</a> to download 64-bit wkhtmltopdf-0.12.6-1.exe installer file.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/wkhtmltopdf.png" alt="" style=" width:400px ; height:250px ">

- Run the downloaded <b><code>wkhtmltopdf-0.12.6-1.exe installer</code></b>.

- Click <b><code>I Agree</code></b> on the license agreement screen.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/wkhtmltopdf1.png" alt="" style=" width:400px ; height:250px ">

- Specify the installation destination folder or leave it as default location and click <b><code>Install</code></b>

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/wkhtmltopdf2.png" alt="" style=" width:400px ; height:250px ">

- When installation is complete, click the <b><code>Close</code></b> button.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/wkhtmltopdf3.png" alt="" style=" width:400px ; height:250px ">

- Now copy wkhtmltox.dll located at C:\Program Files\wkhtmltopdf\bin and paste it in C:\php8.1\ext

- Update the Environmet variable for wkhtmltopdf. <b><code>Refer to section (2.a) for adding Environment Variable</code></b>

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/envwkhtml.png" alt="" style=" width:400px ; height:250px ">


<a id="7Upload-Faveo" 
name="7Upload-Faveo"></a>

### <strong>7. Upload Faveo</strong>

- Download the Faveo Helpdesk from <b><code>https://billing.faveohelpdesk.com</code></b> and extract the contents inside IIS Root Directory.
```
C:\inetpub\wwwroot\
```

- Right click on <b><code>wwwroot</code></b> directory and in the security tab click on edit and add user <b><code>IUSR</code></b>. Give full permissions to <b><code>IIS_IUSRS</code></b>, <b><code>IUSR</code></b> and <b><code>Users</code></b> for the wwwroot folder.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/Permission.png?raw=true" alt="" style=" width:400px ; height:250px ">

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/permissioniis.png" alt="" style=" width:400px ; height:250px ">

<a id="8Configure-Faveo-in-IIS-Manager" 
name="8Configure-Faveo-in-IIS-Manager"></a>

### <strong>8. Configure Faveo in IIS Manager</strong>

- Open IIS Manager and in the left pane, Explore till you find <b><code>Default Web Site</code></b>, select it.
- Then in the right panel, you will see the <b><code>Basic Settings</code></b> option click on it, a new window will open as  shown below:


- Set the <b><code>Physical Path</code></b> value to: 

```
"%SystemDrive%\inetpub\wwwroot\public"
``` 


<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/BasicSettings.png?raw=true" alt="" style=" width:400px ; height:200px ">

<a id="9Configure-web.config-file-for-IIS" 
name="9Configure-web.config-file-for-IIS"></a>

### <strong>9. Configure web.config file for IIS</strong>

- Open notepad and copy the below lines and save the file under the path <b><code>C:\inetpub\wwwroot\public</code></b> as <b><code>web.config</code></b>. Make sure while saving you select all file types.

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

-   <a href="https://www.iis.net/downloads/microsoft/url-rewrite" target="_blank" rel="noopener">Click Here</a> to download URL Rewrite. Click on <b><code>Install this Extension</code></b> execute the installer and click <b><code>Install</code></b>.
- URL Rewrite enables Web administrators to create powerful rules to implement URLs that are easier for users to remember and easier for search engines to find.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/URL-Rewrite.png" alt="" style=" width:400px ; height:200px ">

<a id="10Setting-up-the-Database" 
name="10Setting-up-the-Database"></a>

### <strong>10. Setting up the Database</strong>

Open MariaDB 10.6 Command Line Client from the start menu and enter the password that you set while installing. Run the below commands to create a database and database user for Faveo Helpdesk.

- Create a database called ‘faveo’.

```sql
CREATE DATABASE faveo;
```

- Create a user called ‘faveo’ and change the <b><code>strongpassword</code></b> with the password of your choice.

```sql
CREATE USER 'faveo'@'localhost' IDENTIFIED BY 'strongpassword';
```

- Grant access to the faveo user to faveo Database.

```sql
GRANT ALL ON faveo.* TO 'faveo'@'localhost';
```

- And finally, we apply the changes and exit the database.

```sql
FLUSH PRIVILEGES;
exit
```


<a id="11Setting-up-Bindings" 
name="11Setting-up-Bindings"></a>

### <strong>11. Setting up Bindings</strong>

- To Open the Faveo on your domain, you must set the binding.

- Open IIS Manager and in the left panel, Explore till you find <b><code>Default Web Site</code></b>, select it.

- Then in the right panel, you will see the <b><code>Bindings</code></b> option click on it, a new window will open select HTTP and edit the hostname to your concerned Domain as  shown below:

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/bindingnew.png" alt="" style=" width:400px ; height:250px ">

- Now you can open the browser and enter the IP or Domain Name to open Faveo.


**Disable WebDav (Optional)**

To test the successful configuration perform some delete operations in Faveo if the Delete operation fails then the above steps are not sufficient at this point you may need to remove WebDav:

- Go to <b><code>Control Panel > Uninstall Program > Turn Windows features on or off > IIS > World Wide Web Services > Common HTTP feature > WebDAV Publishing</code></b>.


<a id="12Configure-Task-Scheduler" 
name="12Configure-Task-Scheduler"></a>

### <strong>12. Set Cron & Configure Queue Driver</strong>

- To open Task scheduler press <b><code>Win+R</code></b> and type <b><code>taskschd.msc</code></b>.
- On the Right pane of the Task scheduler select <b><code>Create Basic Task</code></b> enter a <b><code>Name</code></b> for the task and click <b><code>Next</code></b>.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/TaskScheduler.png?raw=true" alt="" style=" width:400px ; height:250px ">

- Under <b><code>Task Trigger</code></b>, section select <b><code>Daily</code></b> and click <b><code>Next</code></b> and leave the default values in <b><code>Daily</code></b> section tick the <b><code>Synchronize across time zones</code></b> and proceed <b><code>Next</code></b>.

- Now under the <b><code>Action</code></b> section select <b><code>Start a program</code></b> and click <b><code>Next</code></b>. 


- In <b><code>Start a program</code></b> copy the below value into the <b><code>program/script field</code></b>.
```
C:\Windows\System32\cmd.exe
```
- Add the following highlighted values to the Argument :

- This is for faveo incoming mail, esacalation, faveo update check.
```
/c php "c:\inetpub\wwwroot\artisan" schedule:run
```

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/Taskschd.gif?raw=true" alt="" style=" width:400px ; height:250px ">

- Finally under the <b><code>Finish</code></b> section select the <b><code>checkbox</code></b> to open the properties window after finish and click the <b><code>Finish</code></b> button.

- In the properties window, select the <b><code>Triggers</code></b> tab, click on <b><code>Edit</code></b> and select the checkbox for <b><code>Repeat task every</code></b> set values to run every <b><code>5 minutes</code></b>, for a duration of <b><code>indefinitely</code></b> and click on <b><code>OK</code></b>.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/TaskTrigger.png?raw=true" alt="" style=" width:400px ; height:250px ">

- Similarly add two more triggers <b><code>At log on</code></b> & <b><code>At startup up</code></b>, set values to run every <b><code>5 minutes</code></b>, for a duration of <b><code>indefinitely</code></b> and click on <b><code>OK</code></b>.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/trigger.png" alt="" style=" width:400px ; height:250px ">

**Queue Drivers**

A queue driver is the handler for managing how to run a queued job, identifying whether the jobs succeeded or failed, and trying the job again if configured to do so. There are different queue lists are available to be used by the system:

- Sync (Activated by default)
- Database (this will use the database used by the application to act as a queue)
- Redis

- **Sync**, or synchronous, is the default queue driver which runs a queued job within your existing process. With this driver enabled, you effectively have no queue as the queued job runs immediately. When a small number of incoming and outgoing mail functionalities are operated by the system, this sync method can be used. 

- **Database** driver stores queued jobs in the database. In Database queue multiple users need to work on a pool of records in a queue to process them. The records in the queue are in an unprocessed state. After the user worked on any record, that record is in completed state and is removed from the queue.
- Database Queue option lets the emails queue to execute using First in First out (FIFO) method and sends emails to the clients one by one.
- In Database, Read and Write operations are slow because of storing data in secondary memory.

- [Database Configuring documentation](/docs/installation/providers/enterprise/database) 

- **Redis** is an open-source (BSD licensed), in-memory data structure store, used as a database, cache and message broker. This  will improve system performance and is highly recommended.
- In Redis, Read and Write operations are extremely fast because of storing data in primary memory.

- [Redis Installation documentation](/docs/installation/providers/enterprise/redis-windows)

**Note:** Database queue driver must be used only in windows server. C Panel or Linux users should not use database as queue driver.

<a id="13SSL-Installation" 
name="13SSL-Installation"></a>

### <strong>13. SSL Installation</strong>

Secure Sockets Layer (SSL) is a standard security technology for establishing an encrypted link between a server and a client. Let’s Encrypt is a free, automated, and open certificate authority.

Faveo Requires HTTPS so the SSL is a must to work with the latest versions of faveo, so for the internal network and if there is no domain for free you can use the Self-Signed-SSL.

- [Let’s Encrypt SSL installation documentation](/docs/installation/providers/enterprise/windows-iis-ssl)

- [Self-Signed SSL installation documentation](/docs/installation/providers/enterprise/self-signed-ssl-windows)


<a id="14Install-Faveo" 
name="14Install-Faveo"></a>

### <strong>14. Install Faveo</strong>

Now you can install Faveo via [GUI](/docs/installation/installer/gui) Wizard or [CLI](/docs/installation/installer/cli)


<a id="15-faveo-backup" name="16-faveo-backup"></a>

### <strong>15. Faveo Backup</strong>


At this stage, Faveo has been installed, it is time to setup the backup for Faveo File System and Database. [Follow this article](/docs/helper/backup) to setup Faveo backup.
