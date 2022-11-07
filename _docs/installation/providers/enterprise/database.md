---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/database/
redirect_from:
  - /theme-setup/
last_modified_at: 2022-11-04
last_modified_by: Mohammad_Asif
toc: true
title: Configuring Database Queue Driver on Windows Server
---


<img alt="Windows" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Windows_logo_and_wordmark_-_2021.svg/250px-Windows_logo_and_wordmark_-_2021.svg.png" width="200"  /> 



[<strong>Configuring Database Queue Driver on Windows Server</strong>](#Configuring-Database-Queue-Driver-on-Windows-Server)


- To open Task scheduler press *Win+R* and type *taskschd.msc*.
- On the Right pane of the Task scheduler select *Create Basic Task* enter a *Name* for the task and click *Next*.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/TaskScheduler.png?raw=true" alt="" style=" width:400px ; height:250px ">

- Under *Task Trigger*, section select *Daily* and click *Next* and leave the default values in *Daily* section tick the *Synchronize across time zones* and proceed *Next*.

- Now under the *Action* section select *Start a program* and click *Next*. 


- In *Start a program* copy the below value into the *program/script field*.
```
C:\Windows\System32\cmd.exe
```

- Add the following highlighted values to the Argument :


- This is for the reports.
```
For IIS
/c php "c:\inetpub\wwwroot\artisan" queue:listen database --queue=reports
For Apache
/c php "c:\Apache24\htdocs\artisan" queue:listen database --queue=reports
```

- This is for recurring.
```
For IIS
/c php "c:\inetpub\wwwroot\artisan" queue:listen database --queue=recurring
For Apache
/c php "c:\Apache24\htdocs\artisan" queue:listen database --queue=recurring
```

- This is for outgoing mail.
```
For IIS
/c php "c:\inetpub\wwwroot\artisan" queue:work database
For Apache
/c php "c:\Apache24\htdocs\artisan" queue:work database
```

- This is for Faveo Notifications.
```
For IIS
/c php "c:\inetpub\wwwroot\artisan" queue:listen database --queue=high_priority_notify,notify
For Apache
/c php "c:\Apache24\htdocs\artisan" queue:listen database --queue=high_priority_notify,notify
```


<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/Taskschd.gif?raw=true" alt="" style=" width:400px ; height:250px ">

- Finally under the *Finish* section select the *checkbox* to open the properties window after finish and click the *Finish* button.

- In the properties window, select the *Triggers* tab, click on *Edit* and select the checkbox for *Repeat task every* set values to run every *5 minutes*, for a duration of *indefinitely* and click on *OK*.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/TaskTrigger.png?raw=true" alt="" style=" width:400px ; height:250px ">

- Similarly add two more Triggers *At log on* & *At startup up*, set values to run every *5 minutes*, for a duration of *indefinitely* and click on *OK*.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/trigger.png" alt="" style=" width:400px ; height:250px ">

**Note:** Database queue driver must be used only in windows server. C Panel or Linux users should not use database as queue driver.

