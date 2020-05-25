# Installing Faveo (Generic) <!-- omit in toc -->

Faveo can be installed on a variety of platforms. The choice of the platform is yours.

- [Requirements](#requirements)
- [Installation instructions for specific platforms](#installation-instructions-for-specific-platforms)
  - [Generic Linux instructions](#generic-linux-instructions)
  

<a id="markdown-requirements" name="requirements"></a>
## Requirements

If you don't want to use Docker, the best way to setup the project is to use the same configuration that [Homestead](https://laravel.com/docs/homestead) uses. Basically, Faveo depends on the following:

-   **Apache** (with mod_rewrite enabled) or **Nginx** or **IIS**
-   **Git**
-   **PHP 7.3.x** with the following extensions: curl, dom, gd, json, mbstring, openssl, pdo_mysql, tokenizer, zip
-   **Composer**
-   **MySQL 5.7.x** or MariaDB **10.3+**
-   Optional: Redis or Beanstalk

<a id="markdown-installation-instructions-for-specific-platforms" name="installation-instructions-for-specific-platforms"></a>
## Installation instructions for specific platforms

The preferred OS distribution is Cent OS 8, simply because all the development is made on it and we know it works. However, any OS that lets you install the above packages should work.

<a id="markdown-generic-linux-instructions" name="generic-linux-instructions"></a>
### Generic Linux instructions For Community version
* [Generic Instructions](/docs/installation/providers/community/generic.md)
* [Ubuntu](/docs/installation/providers/community/ubuntu.md)
* [Debian](/docs/installation/providers/community/debian.md)

### Generic Linux instructions For Freelancer, paid and Enterprise version
* [Generic Instructions](/docs/installation/providers/enterprise/generic.md)
* [Ubuntu](/docs/installation/providers/enterprise/ubuntu.md)
* [Debian](/docs/installation/providers/enterprise/debian.md)


