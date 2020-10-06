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
Faveo can also be configured with Redis. This will help improve system performance as emails can be qued. We will go through the steps to configure Redis for Faveo.

## Faveo Redis configuration

### Step 1: Open Admin panel and go to Queues icon

<img alt="Ubuntu" src="https://camo.githubusercontent.com/916cff00e405944d97932ccf87ab39c7c4e040c7/68747470733a2f2f7777772e666176656f68656c706465736b2e636f6d2f757365722d6d616e75616c2f696d616765732f666176656f72656469732f696d67312e706e67" />

### Step 2: Goto Admin Panel->Queues and click on "redis" and input the values as driver="redis" queue="default"

<img src="https://support.faveohelpdesk.com/uploads/2020/10/5/redis.png" alt="" />

### Step 3: Open Queues Click on Activate for redis.

<img alt="Ubuntu" src="https://camo.githubusercontent.com/71e0e53ac0683de2fd02ba938b6d1ed0a0ceec95/68747470733a2f2f7777772e666176656f68656c706465736b2e636f6d2f757365722d6d616e75616c2f696d616765732f666176656f72656469732f696d67322e706e67"  />

These steps will configure Faveo with Redis
Advance Configuration

Redis advanced configuration can be done in app/Config/queue.php.

There are 4 parameters in redis configuration section.

- **Driver :** It has to be redis 
- **Connection :** It can be connection type (default) 
- **Queue :** Name of the queue. You can define the name of the queue 
- **Expire :** Queue expiring time (by default 60) 
