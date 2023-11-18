---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/plesk-redis/
redirect_from:
  - /theme-setup/
last_modified_at: 2023-11-3
last_modified_by: TamilSelvan_M
toc: true
title: Redis Installation on Ubuntu with Plesk Panel
---

<style>p>code, a>code, li>code, figcaption>code, td>code {background: #dedede;}</style>

<img alt="Wamp" src="https://contabo.com/blog/wp-content/uploads/2019/11/Plesk-OBSIDIAN-logo_positive-1024x341.png" width="200"  /> 

## Introduction
This document will list steps on how to install Redis, Supervisor and Worker for Faveo.

We will install following dependencies in order to make Redis work:

- Redis
- PHP extension for Redis
- supervisor

Switch to root user or run the following commands as sudoers.

```sh
sudo su
```

##  Install Redis and PHP redis extension.
```
apt-get install redis-server
```

## Start, Enable and restart the Redis-service
```
systemctl start redis-server
systemctl enable redis-server
```

## Install and Configure Supervisor
```
apt-get install supervisor
```
## Copy paste the below configuration.( Change the directories according to your configuration)

```
nano /etc/supervisor/conf.d/faveo-worker.conf
```
Pick a editor of your choice copy the following and replace <code><b>"–DOMAINNAME–"</b></code> 

```bash
[program:faveo-Horizon]
process_name=%(program_name)s
command=/opt/plesk/php/8.1/bin/php /var/www/vhosts/"–DOMAINNAME–"/httpdocs/artisan horizon
autostart=true
autorestart=true
user=root
redirect_stderr=true
stdout_logfile=/var/www/vhosts/"–DOMAINNAME–"/httpdocs/storage/logs/horizon-worker.log
```
## Restart the Supervisor to reread the new configuration.

```sh
systemctl restart supervisor 
```


To check the Status of workers use the below command
```sh
supervisorctl
```

## Enable Redis in Faveo
After Redis installation is complete, follow these [instructions](/docs/helper/enable-redis) to configure Redis with Faveo. 


