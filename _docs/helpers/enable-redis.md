---
layout: single
type: docs
permalink: /docs/helper/enable-redis/
redirect_from:
  - /theme-setup/
last_modified_at: 2020-06-09
toc: true
title: "Enable Redis in Faveo"
---

## Introduction

Faveo can also be configured with Redis. This will help improve system performance as emails can be qued. We will go through the steps to configure Redis for Faveo.

## Faveo Redis configuration

### Step 1: Open Admin panel and go to Queues icon

<img alt="Ubuntu" src="https://camo.githubusercontent.com/916cff00e405944d97932ccf87ab39c7c4e040c7/68747470733a2f2f7777772e666176656f68656c706465736b2e636f6d2f757365722d6d616e75616c2f696d616765732f666176656f72656469732f696d67312e706e67" />

### Step 2: Open Queues, You will see Redis option in last. Click on Activate

<img alt="Ubuntu" src="https://camo.githubusercontent.com/71e0e53ac0683de2fd02ba938b6d1ed0a0ceec95/68747470733a2f2f7777772e666176656f68656c706465736b2e636f6d2f757365722d6d616e75616c2f696d616765732f666176656f72656469732f696d67322e706e67"  />

These steps will configure Faveo with Redis
Advance Configuration

Redis advanced configuration can be done in app/Config/queue.php.

There are 4 parameters in redis configuration section.

**Driver :** It has to be redis 
**Connection :** It can be connection type (default) 
**Queue :** Name of the queue. You can define the name of the queue 
**Expire :** Queue expiring time (by default 60) 

## Install and configure Redis, Supervisor and Worker for Faveo on Ubuntu 18.04 <!-- omit in toc -->

<img alt="Ubuntu" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Logo-ubuntu_cof-orange-hex.svg/120px-Logo-ubuntu_cof-orange-hex.svg.png" width="120" height="120" />

## Introduction
This document will list steps on how to install Redis, Supervisor and Worker for faveo.

We will install following dependencies in order to make Redis work:

- Redis
- PHP extension for Redis
- supervisor

##  Install Redis
```
sudo apt-get install redis-server
```

## Install PHP extension for Redis
```
sudo apt-get install php-redis

```

## Start, Enable and restart the Redis-service
```
sudo systemctl start redis-server.service

sudo systemctl restart redis-server.service

sudo systemctl enable redis-server.service
```

## Install and Configure Supervisor
```
sudo apt-get install supervisor

```
## Copy paste the below configuration.( Change the directories according to your configuration)

```
nano /etc/supervisor/conf.d/faveo-worker.conf
```
```
[program:faveo-worker]
process_name=%(program_name)s_%(process_num)02d
command=php  /var/www/faveo/artisan queue:work redis --sleep=3 --tries=3
autostart=true
autorestart=true
numprocs=8
redirect_stderr=true
stdout_logfile=/var/www/faveo/storage/logs/worker.log

[program:faveo-recur]
process_name=%(program_name)s_%(process_num)02d
command=php  /var/www/faveo/artisan queue:work redis --queue=recurring --sleep=3 --tries=3
autostart=true
autorestart=true
numprocs=1
redirect_stderr=true
stdout_logfile=/var/www/faveo/storage/logs/worker.log

[program:faveo-Reports]
process_name=%(program_name)s_%(process_num)02d
command=php  /var/www/faveo/artisan queue:work redis --queue=reports --sleep=3 --tries=3
autostart=true
autorestart=true
user=www-data
numprocs=1
redirect_stderr=true
stdout_logfile=/var/www/faveo/storage/logs/reports-worker.log

[program:faveo-Horizon]
process_name=%(program_name)s
command=php /var/www/faveo/artisan horizon
autostart=true
autorestart=true
user=www-data
redirect_stderr=true
stdout_logfile=/var/www/faveo/storage/logs/horizon-worker.log

```
## Restart the Supervisor

```
service supervisor restart

sudo supervisorctl reread

sudo supervisorctl update

```
## Start your worker
Replace the worker name according to your configuration

```
sudo supervisorctl start faveo-worker:*
```
To Check Supervisor status use the below command
```
systemctl status supervisor.service
```

## Enable Redis in Faveo
After Redis installation is complete, follow these instruction to configure Redis with Faveo. [Configuration of Redis with Faveo](https://support.faveohelpdesk.com/show/enable-redis-in-faveo)