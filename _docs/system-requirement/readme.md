# Faveo Helpdesk System Requirements 

-   [1. Php Versions](#php-versions)
    -   [PHP Extensions](#php-extensions)
    -   [PHP Settings](#php-settings)
-   [2. File Permissions](#file-permissions)
    -   [Linux](#linux)
    -   [IIS - Windows](#iis)
-   [3. Database](#database)
    -   [Version](#version)
    -   [User Privileges](#user-privileges)
-   [4. Web Server](#web-server)
-   [5. Firewall Requirements](#firewall-requirements)

Faveo requires a fairly standard PHP & MySQL server setup in order to be installed and function correctly. If you require any assistance with setting up Faveo or determining if your system can support Faveo, please contact us.

<a id="php-versions" name="php-versions"></a>
## 1. PHP Version
PHP versions 7.3.x are supported.

For assistance installing a new version of PHP please contact your hosting provider or server administrator.

<a id="php-extensions" name="php-extensions"></a>
### a. PHP Extensions
- BCMath
- Ctype
- cURL
- DOM
- FileInfo
- GD (requires libpng and libjpeg)
- Iconv
- ionCube Loaders v10.3 and above for PHP 7.3.x
- JSON
- Mbstring
- OpenSSL
- PDO (with MySQL Client Driver 5.6.0+ or MySQLnd 5.0.9)
- Tokenizer
- XML (with libxml2 version 2.7.0 or above)
- IMAP - When using email download to pull in department tickets
- LDAP - When using LDAP operator authentication

PHP extensions differ depending on your server, your host and other system variable. For assistance installing missing extensions, please contact your hosting provider or server administrator.

<a id="php-settings" name="php-settings"></a>
### b. PHP Settings
Your PHP configuration must adhere to the following settings:

- ``` ! allow_url_fopen``` **Enabled**
To use Gravatar and other Faveo features, ```allow_url_fopen``` must be enabled in your PHP configuration.
- **IPv6 Support**
If your server has IPv6 networking support, this should be enabled by default. However if not please ensure you have the php-sockets extension enabled and PHP has been compiled with the ```--enable-ipv6``` flag.
- **PNG & JPG Support**
If the PHP GD extension has been manually compiled, please ensure the ```--with-png-dir``` and ```--with-jpeg-dir``` flags are provided.
- **Disabled functions**
If you're running under a particularly strict environment, please ensure that the following functions are not listed under the ```disable_functions``` directive: ```ini_set```
- **Memory Limit**
A minimum of 128MB addressable memory is required to install and use Faveo. We recommend at least 256 MB.
For assistance on modifying your PHP configuration, please contact your hosting provider or server administrator.

<a id="file-permissions" name="file-permissions"></a>
## 2. File Permissions
The following directories (and directories within recursively) must be writable by the PHP/Web Server process.

- storage/
- config/
- bootstrap/cache/

<a id="linux" name="linux"></a>
### a. Linux
We recommend setting the above directories to 755 permissions. You may also need to adjust the owner and group of the directories.

```sh
chmod -R 755 /path/to/directory
chown -R www-data:www-data /path/to/directory
```

If you're using CentOS, it has SELinux enabled by default which has measures in place to prevent httpd from writing to files, beyond the normal file permissions. You need to apply httpd_sys_rw_content_t to the directories:
```sh
chcon -Rv --type=httpd_sys_rw_content_t /path/to/directory
```

<a id="iis" name="iis"></a>
### b. IIS (Windows)
Right click on the folder containing the Faveo files, click Properties and then the Security tab. Click Edit... and then Add..., enter IUSRS and click Check Names. Click OK, and check the Full Control checkbox in the permissions. Do the same for the IIS_IUSRS group too.

<a id="database" name="database"></a>
## 3. Database
<a id="version" name="version"></a>
### a. Version
MySQL Server <b>5.7.x, 8.0.x</b> supported. <b>MariaDB 10.3 - 10.4</b> also supported.

<a id="user-privileges" name="user-privileges"></a>
### b. User Privileges
For day to day use, the following database privileges are required.

- DELETE
- INSERT
- LOCK TABLES
- SELECT
- UPDATE

For installing and upgrading the system, as well as activation and deactivation of plugins, the following additional privileges are required.

- ALTER
- CREATE
- DROP
- INDEX

<a id="settings" name="settings"></a>
### c. Settings
We recommend the following MySQL configuration directives are changed:

- max_allowed_packet - we recommend greater than 20MB to ensure large emails and embedded images are correctly handled.
For assistance on modifying your MySQL configuration, please contact your hosting provider or server administrator.

<a id="web-server" name="web-server"></a>
## 4. Web Server
Faveo supports Apache, nginx and IIS web server, in all cases you must enable the mod_rewrite module for SEO friendly URLs.

Apache works out of the box, however for nginx and IIS you will need to install the rewrite rules.

Depending on the web server you are running, you may need to configure it further to run SupportPal correctly - for example, ensuring all the HTTP request verbs (DELETE, GET, OPTIONS, POST and PUT) are enabled. Below is a list of common web servers and steps required for them.

### a. Apache
Apache is supported out of the box.

### b. Nginx
On nginx, please create a new virtual host for Faveo. The below is an example virtual host but will need editing for your specific environment (paths may vary):
[faveo.conf](/installation-scripts/web-server/nginx/faveo.conf)

### c. IIS
On IIS, please create a web.config file in the root of your installation directory with the below contents:
[web.config](/installation-scripts/web-server/iis/web.config)

**Required Extension(s)**
The [URL Rewrite extension](https://www.iis.net/downloads/microsoft/url-rewrite) is required for the below web.config file to function correctly, otherwise a 500.19 error is likely to be shown when visiting Faveo (see Understanding HTTP Error 500.19).

Please replace the follow constants in the below code snippet:
**<faveo_base_url>** with your installation base URL
**<absolute_path_to_php_cgi.exe>** with the absolute path to your PHP cgi executable

<a id="firewall-requirements" name="firewall-requirements"></a>
## 5. Firewall Requirements
Please open outbound access to billing.faveohelpdesk.com