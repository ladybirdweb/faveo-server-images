---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/memcached/
redirect_from:
  - /theme-setup/
last_modified_at: 2023-11-20
last_modified_by: TamilSelvan M
toc: true
title: Installing Memcached
---

### Installing PHP extension

```
sudo apt-get install -y php8.1-memcached
```

```
sudo systemctl restart apache2
```

### Installing Memcached

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