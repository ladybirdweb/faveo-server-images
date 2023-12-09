---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/memcached/
redirect_from:
  - /theme-setup/
last_modified_at: 2023-12-09
last_modified_by: Mohammad_Asif
toc: true
title: Installing Memcached
---
<img alt="Memcached" src="https://cdn.icon-icons.com/icons2/2699/PNG/512/memcached_logo_icon_170963.png" width="200"  />


- [<strong>Introduction :</strong>](#introduction-) 
    - [<strong>1. Debian and Derivatives</strong>](#1-debian-and-derivatives)
    - [<strong>2. Red Hat and Derivatives:</strong>](#2-redhat-and-derivatives)

<a id="introduction-" name="introduction-"></a>

## <strong>Introduction:</strong>

Memcached is free & open source, high-performance, distributed memory object caching system, generic in nature, but intended for use in speeding up dynamic web applications by alleviating database load. Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls, API calls, or page rendering.

---

<a id="1-debian-and-derivatives" name="1-debian-and-derivatives"></a>

### <strong>Debian and Derivatives</strong>

Debian and Derivates include Debian 11 (Bullseye), Debian 12 (Bookworm),  Ubuntu 20.04 (Focal Fosa) and Ubuntu 22.04 (Jammy Jellyfish).

#### Installing PHP extension

```
apt-get install -y libapache2-mod-php8.1 php8.1-memcached
```

#### Installing Memcached

```
sudo apt update
```

```
sudo apt-get install -y memcached libmemcached-tools
```

```
sudo systemctl start memcached
sudo systemctl enable memcached
```

```
sudo systemctl restart apache2
```

Verify that Memcached is currently bound to the local IPv4 127.0.0.1 interface and listening only for TCP connections by using the ss command:

```
sudo ss -plunt
```

You should receive output like the following:

```sh
Output
Netid      State       Recv-Q      Send-Q           Local Address:Port             Peer Address:Port      Process                                         
. . .
tcp        LISTEN      0           1024                 127.0.0.1:11211                 0.0.0.0:*          users:(("memcached",pid=8889,fd=26))
. . .
```

#### Adding an Authenticated User
You will need to install the *sasl2-bin* package, which contains administrative programs for the SASL (Simple Authentication and Security Layer) user database. This tool will allow you to create an authenticated user or users. Run the following command to install it:

```
sudo apt install sasl2-bin
```

Next, create the directory and file that Memcached will check for its SASL configuration settings using the mkdir command:

```
sudo mkdir -p /etc/sasl2
```

Now create the SASL configuration file using nano or your preferred editor:

```
sudo nano /etc/sasl2/memcached.conf
```

Add the following lines:

```
log_level: 5
mech_list: plain
sasldb_path: /etc/sasl2/memcached-sasldb2
```

Now you will create a SASL database with user credentials. You’ll use the *saslpasswd2* command with the -c flag to create a new user entry in the SASL database.

```
sudo saslpasswd2 -a memcached -c -f /etc/sasl2/memcached-sasldb2 faveo
```

Finally, give the memcache user and group ownership over the SASL database with the following chown command:

```
sudo chown memcache:memcache /etc/sasl2/memcached-sasldb2
```


---


<a id="2-redhat-and-derivatives" name="2-redhat-and-derivatives"></a>

### <strong>2. Red Hat and Derivatives</strong>

Red Hat and Derivatives include Alma 8, Alma 9, Rocky 8, Rocy 9, RHEL 8 and RHEL 9

#### Installing PHP extension

```
yum -y install php-pecl-memcached php-pecl-memcache -y
```

#### Installing Memcached

```
sudo dnf update -y
```

```
sudo dnf install memcached -y
```

```
sudo systemctl start memcached
sudo systemctl enable memcached
```

```
systemctl restart httpd.service
```
