---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/windows/
redirect_from:
  - /theme-setup/
last_modified_at: 2020-06-09
toc: true
title: Installing Faveo Helpdesk Freelancer, paid and Enterprise on Windows
---

# Installing Faveo Helpdesk Freelancer, paid and Enterprise on Windows <!-- omit in toc -->

<img alt="Ubuntu" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/Windows_logo_%E2%80%93_2012_%28dark_blue%29.svg/65px-Windows_logo_%E2%80%93_2012_%28dark_blue%29.svg.png" width="65"  />

Faveo can run on [Windows Server](https://www.microsoft.com/en-au/windows-server).

-   [Prerequisites](#prerequisites)
-   [Installation steps](#installation-steps)
    -   [1. Upload Faveo](#1-upload-faveo)
    -   [2. Setup the database](#2-setup-the-database)
    -   [3. Configure IIS webserver](#5-configure-apache-webserver)
    -   [4. Install Faveo](#3-gui-faveo-installer)
    -   [5. Configure Task Scheduler](#4-configure-cron-job)
    -   [6. SSL Installation](#ssl-installation)
    -   [7. Final step](#final-step)


<a id="prerequisites" name="prerequisites"></a>
## Prerequisites

Faveo depends on the following:

-   **IIS**
-   **PHP 7.3+** 
-   **MariaDB 10.3+**
-   **Task Scheduler+**
-   **Utility Tools** WinRar.

### <b> Step 1: Install IIS server </b>
To install IIS Server open Server Manager and locate the Manage button on top right corner click on it and select -> Add Roles and Features
- A wizard will open disaplying the overview click on next and under "Installation Type" select Role-based and Feature-based installation and select next. Leave the deafult in "Sever Selection" and click next. Now under "Server Roles" search and enable checkbox for "Web Server IIS" and click on Add Features window and proceed by clicking next.


<img src="https://camo.githubusercontent.com/9419f38c09fee84514e6e8c8e118cd5fe1e7a822/68747470733a2f2f7777772e666176656f68656c706465736b2e636f6d2f757365722d6d616e75616c2f696d616765732f666176656f696e7374616c6c6174696f6e77696e646f77732f312e6a7067" alt="" />


-   - In "Features" section locate the .NET Framework 3.5 and .NET Framework 4.7 select the packages as show in the below image.
    
   
<img src="https://support.faveohelpdesk.com/uploads/2020/9/15/features-selection.png" alt="Features_selection"/>
Click next -> next -> thrice to confirm the settings and finally click on Install . It will get the IIS installed on the server. To verify the installation, you can type the following url in the browser

```
http://localhost
```

### <b> Step 2: Install PHP-7.3 </b>

- To make the installation easy and smooth, we will be using Web platform Installer. It is a special tool provided by Microsoft for quick installation of most of our requirement. You can download from following link and install it.

[Click here to download Web platform installer](https://www.microsoft.com/web/downloads/platform.aspx)

- After installation locate "Tools" in the  Server Manager Dashboard on the top right corner click on it and select "Internet Information Services (IIS) Manager"
- Now in the Left Pane of the IIS Manager window select your server then you will find the "Web Platform Installer" if it is installed from the previous step.  
- Open the Web Platform Installer and search the following Extensions to add.

   PHP 7.3  
   URLRewrite  
   MySQL Connector/Net

<img src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/05/1589806536webplatform.png" alt="" />



- Click on install and accept the license agreement the installation should take few minutes to complete.

- Download and install PHP Manager from the below link
-   [Click here to download PHP Manager](https://www.faveohelpdesk.com/user-manual/windows_installation/phpmanager.zip)

- Extract the ZIP file and install PHP Manager.

### <b>Step 3: Install MariaDB-10.3 </b>

- Download and install MariaDB-10.3 from the official MariaDB website.
"https://downloads.mariadb.org/mariadb/10.3.13/"

- Execute the installer and peform the required installation steps and set the root password.



###  <b>Step 4: Copy and Enable cacert.pem file in php.ini. </b>
This is required to avoid "cURL 60 error" which is one of the Probes that Faveo checks. In other words this is a neccessary  step to run Faveo on IIS Server.

#### <b> - Step 4(a) </b>
Download and Extract the "cacert.pem" file and copy it to the PHP root directory. Usually found in the below mentioned location. If it is differnt in your server copy it to that location.

(C:\Program Files\PHP\v7.3)

[Click here to download cacaert.pem file](https://www.faveohelpdesk.com/user-manual/windows_installation/pem_file.zip)

#### <b> - Step 4(b) </b>
Edit the php.ini file which is found inside the PHP root directory.
Uncomment and add the location of cacert.pem to "curl.cainfo".

```
curl.cainfo = "C:\Program Files\PHP\v7.3\cacert.pem"
```

Note: The location of PHP 7.3 in IIS Server is following. You will need this location to add extensions in your websites.

<img src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/05/1589806641php.png" alt="" />

### <b> Step 5: Install Ioncube Loader </b>

#### <b> - Step 5(a) </b>
Download the Ioncube loader from the below link and extract

[Click here to download IonCube](https://downloads.ioncube.com/loader_downloads/ioncube_loaders_win_nonts_vc15_x86-64.zip)

#### <b> - Step 5(b) </b>

- Copy the "ioncube_loader_win_7.3.dll" from extracted Ioncube folder and paste it in PHP extension diectory. which can be found here
"C:\Program Files\PHP\v7.3\ext\" 

<img src="https://support.faveohelpdesk.com/uploads/2020/9/15/ioncube-dll.png" alt="ioncube-dll"/>

- Copy the "loader-wizard.php" from the extracted Ioncube folder and paste it in the IIS Root Directory. which can be found here "C:\inetpub\wwwroot\"

<img src="https://support.faveohelpdesk.com/uploads/2020/9/15/loader-wizard.png" alt="loader-wizard"/>

### <b>Step 6: Configure the php.ini file. </b>
- Add the below line in your php.ini file to enable Ioncube.

```
zend_extension = "C:\Program Files\PHP\v7.3\ext\ioncube_loader_win_7.3.dll"
```

- Make sure the below lines present in the php.ini file if not add or uncomment the respective lines.

```
extension=php_mysqli.dll
extension=php_pdo_mysql.dll
extension=php_ldap.dll
extension=phpfileinfo.dll
```

- Run the below URL to verify the ionCube Installation.
Note: If you didn't get the below output try restarting the IIS Server.

```
localhost/loader-wizard.php
```

<img src="https://camo.githubusercontent.com/b41798cb16af8fd8a4c3fde2f7c2121ecb874777/68747470733a2f2f666176656f68656c706465736b2e636f6d2f757365722d6d616e75616c2f696d616765732f666176656f5f70726f5f696e7374616c6c6174696f6e5f77696e646f77732f696f6e637562656c6f6164657275726c2e6a7067" alt="" />


<a id="installation-steps" name="installation-steps"></a>
## <b> Step 6: Faveo Installation </b> 

Once all the above softwares are installed:

<a id="1-upload-faveo" name="1-upload-faveo"></a>
<b>1. Upload Faveo </b>
Please download Faveo Helpdesk from [https://billing.faveohelpdesk.com](https://billing.faveohelpdesk.com) and upload it to below directory

```
c:/inetpub/wwwroot/
```
<b> 2. Give Permissions to the Faveo folder </b>

We need to give full write permission to "IIS_IUSRS" and "Users" for  wwwroot folder.

```
c:/inetpub/wwwroot/
```

<img src="https://camo.githubusercontent.com/f133d3f80548c359f3b4f54b109422bfd428b406/68747470733a2f2f7777772e666176656f68656c706465736b2e636f6d2f757365722d6d616e75616c2f696d616765732f666176656f696e7374616c6c6174696f6e77696e646f77732f31312e6a7067" alt="" />


<b> 3. Configure Faveo in IIS Manager. </b>
- Open IIS Manager and in the left pane explore till you find default_website select it and in the right pane you will see the "Basic Settings" option click on it and set the Pyhsical Path value to
"%SystemDrive%\inetpub\wwwroot\public" 

<img src="https://camo.githubusercontent.com/37530a227e367268afd3106b89f1e1dd343e1fdf/68747470733a2f2f7777772e666176656f68656c706465736b2e636f6d2f757365722d6d616e75616c2f696d616765732f666176656f696e7374616c6c6174696f6e77696e646f77732f362e6a7067" alt="" />

<b> 4. Configure web.config file for IIS </b>

Open notepad and copy the below and the save the file under c:\inetpub\wwwroot\public as web.config and make sure while saving you select all file types otherwise you will end up having the file as web.config.txt which is not acceptable because the file type should be "CONFIG File".


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

<a id="2-setup-the-database" name="2-setup-the-database"></a>

#### <b> 5. Setting up the Database. </b>

Open MariaDB 10.3 Command Line Client and run the below commands.

Create a database called 'faveo'.

```sql
CREATE DATABASE faveo;
```

Create a user called 'faveo' and its password 'strongpassword'.

```sql
CREATE USER 'faveo'@'localhost' IDENTIFIED BY 'strongpassword';
```

We have to authorize the new user on the faveo db so that he is allowed to change the database.

```sql
GRANT ALL ON faveo.* TO 'faveo'@'localhost';
```

And finally we apply the changes and exit the database.

```sql
FLUSH PRIVILEGES;
exit
```

<a id="5-configure-apache-webserver" name="5-configure-apache-webserver"></a>

<b> 6. Configure IIS webserver </b>



By default, IIS configures PHP only to accept GET, POST and HEAD request types. Since Faveo makes use of other requests types (such as DELETE and PUT), you must manually change the PHP handler to allow them.

<b>Step 1: Open IIS Manager </b>

Open the Start menu and type "IIS" in to the find box. You should see an application called "Internet Information Services (IIS) Manager".

 

<b>Step 2: Select your computer in the "Connections" pane</b>

On the left, there is a "Connections" pane. You should see your computer listed here. Click on your computer name which should load the a dashboard with a handful of icons.
 
<img src="https://support.faveohelpdesk.com/uploads/2020/9/28/Screenshot-2014-06-04-14.59.44.png" alt=""/>

<b>Step 3: Open PHP Handler Mapping</b>

Double-click on the Handler Mappings icon to bring up the Handler Mappings screen.

<img src="https://support.faveohelpdesk.com/uploads/2020/9/28/Screenshot-2014-06-04-15.01.17.png" alt="" />

Then double-click on the handler for PHP files to bring up the "Edit Module Mapping" window:

<img src="https://support.faveohelpdesk.com/uploads/2020/9/28/Screenshot-2014-06-04-15.03.15.png" alt="" />

<b>Step 4: Edit Verbs</b>

Click on the "Request Restrictions" button, then switch to the [Verbs] tab. Switch the radio button to "All Verbs", then click "OK" to close the window, then "OK" again to close the other window.

<img src="https://support.faveohelpdesk.com/uploads/2020/9/28/Screenshot-2014-06-04-15.04.02.png" alt="" />

Note: You may be prompted with an alert to "fix" the path to the PHP executable. If so, just put double-quotation marks around the path that already exists in the "Executable" box and it will save successfully.


To Open the Faveo on your domain , you must set the binding.
Go to Bindings option on right pane and select “HTTP” and edit the hostname to your concern.

Now you can open the browser and enter the IP or Domain Name to open Faveo. To test the successfull configuration perform some create delete operations in Faveo if the Delete operation fails then the above steps is not sufficient at this point you may need to perform the below steps too.

Disable WebDav (Optional)

Perform  this step only if you have problem with delete option in Faveo ec=pven after following the previous steps.

To remove WebDav, go to Control Panel -> Uninstall Program -> Turn Windows features on or off -> IIS -> World Wide Web Services -> Common HTTP feature -> WebDAV Publishing.

<a id="3-gui-faveo-installer" name="3-gui-faveo-installer"></a>
<b>  Install Faveo </b>

Now you can install Faveo via [GUI](/docs/installation/installer/gui) Wizard or [CLI](/docs/installation/installer/cli)


<a id="4-configure-cron-job" name="4-configure-cron-job"></a>
### <b>Step 7: Configure Task Scheduler </b>

To open Taskscheduler press ctrl + R and Type "taskschd.msc".

To Setup Schedule task for Faveo. Open Task scheduler on server and follow this steps

On the Right pane of  Task scheduler select “create basic task” and enter a name for the task and click next.

Under Trigger section select daily and click next and leave the default values in daily section and proceed next.

Now under Action section select start a program and click next and in Start a program copy the below value in to the program/script field.

```
C:\Windows\System32\cmd.exe
```

Add following value in Argument :

```
/c php "c:\inetpub\wwwroot\faveo\artisan" schedule:run
```
Finally under Finish section select the checkbox to open the properties window after finish and click finish button.

In the properties window select the Triggers tab and click on Edit and select the checkbox for "Repeat task every" and set values to run every 5 minutes for indefinitely and click on OK.



<a id="ssl-installation" name="ssl-installation"></a>
### <b>Step 8: SSL Installation </b>

Secure Sockets Layer (SSL) is a standard security technology for establishing an encrypted link between a server and a client. Let's Encrypt is a free, automated, and open certificate authority.

This is an optional step and will improve system security and is highly recommended.

[Let’s Encrypt SSL installation documentation](/docs/installation/providers/enterprise/windows-iis-ssl)

<a id="final-step" name="final-step"></a>
### <b>Step 9: Final step</b>

The final step is to have fun with your newly created instance, which should be up and running to `http://localhost` or the domain you have configured Faveo with.
