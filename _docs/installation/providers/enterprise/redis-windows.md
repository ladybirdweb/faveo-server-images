---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/redis-windows/
redirect_from:
  - /theme-setup/
last_modified_at: 2022-06-29
last_modified_by: Mohammad_Asif
toc: true
title: Installing Redis on Windows Server
---


<img alt="Windows" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Windows_logo_and_wordmark_-_2021.svg/250px-Windows_logo_and_wordmark_-_2021.svg.png" width="200"  />   


<img alt="Windows" src="https://upload.wikimedia.org/wikipedia/en/6/6b/Redis_Logo.svg" width="200"  /> 

[<strong>Install Redis & Configure it with NSSM</strong>](#Install-Redis-&-Configure-it-with-NSSM)


<b>1. Install PHP 7.3 </b>

<a href="https://pecl.php.net/package/redis/5.1.1/windows" > Click here</a> to download  PHP 7.3 NTS x64 zip file.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/redis1.png" width=400px; height=250px;>

- Unzip the php-redis zip file, a folder will be created, go inside the folder, copy the *php_redis.dll* file and paste it in *C:\Program Files\php7.3\ext.* *(C:\php\ext incase of Apache WebServer).* 
- Now enable php redis extension in *php.ini* configuration located in *C:\Program Files\php7.3.*  *(C:\php incase of Apache WebServer).*

```
extension=php_redis.dll
```
- Now go to Server Manager, open IIS Server and restart it. *(or restart Apache incase of Apache WebServer)*



<b>2. Install Redis </b>

<a href="https://github.com/tporadowski/redis/releases" > Click here</a> to download last recent release of Redis.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/redis2.png" width=400px; height=250px;>

Execute the installer to perform the required installation steps
- Accept the terms in the License agreement.
- Add the Redis installation folder to the PATH environment variable.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/redis3.png" width=400px; height=250px;>

- Set the Max Memory Limit from 300-500 MB.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/redis4.png" width=400px; height=250px;>

The Redis installation is finished. 

- Now go to *windows menu > Run > Services*, This can be done by  following shortcut *win+R*, type *services.msc* & click *OK*, it will open a new Services tab. 
- Find *Redis* right click on it & go to *Properties > Recovery* a new tab will open. 

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/redis5.png" width=400px; height=250px;>

- Change *first failure, second failure & subsequent failure* from Take No Action to *Restart the Service* & click *OK*. 

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/redis6.png" width=400px; height=250px;>

Redis has been successfully installed, this can be confirmed in Command Prompt by typing *redis-cli*, a loopback address will be shown in the Command Prompt.

<b>3. Install NSSM </b>

<a href="https://github.com/ladybirdweb/faveo-server-images/raw/master/_docs/installation/providers/enterprise/windows-images/nssm-2.24.zip" > Click here</a> to download NSSM.

Unzip the *nssm-2.24* zip file, a folder nssm-2.24 with nssm files will be created.

Go inside the folder & copy the *nssm-2.24* folder & paste it in *C:\Program Files*.

Go inside the pasted *nssm-2.24* folder, go to *win64*, nssm will be present there, copy the nssm path i.e, *C:\Program Files\nssm-2.24\win64*. 

Paste this path in System Environmental Variables by following the below steps:

- Right click on *This PC*, go to *Properties > Advanced System Settings > Environment Variables.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/redis8.png" width=700px; height=250px;>

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/redis9.png" width=400px; height=250px;>

- Now click on *Path > Edit > New* & add copied path *C:\Program Files\nssm-2.24\win64* \ here and click *OK* in all 3 tabs.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/redis10.png" width=400px; height=250px;>

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/redis11.png" width=400px; height=250px;>

NSSM has been installed now, it can be confirmed in Command Prompt by typing *nssm*


<b>4. Configure NSSM </b>

Go to Command Prompt and configure Faveo-Mail-Worker, Faveo-Recurring & Faveo-Reports by typing the following commands:

**a. Faveo-Mail-Worker**

Type the below command in Command Prompt, this will open a new window.

```
nssm install faveo-mail-worker
```

- In Application section click on three dots and navigate to *C > Windows > System32* and search for *cmd*, click on the cmd as shown in the figure below, then click on *open*,  a path will be added.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/redis12.png" width=400px; height=250px;>

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/redis13.png" width=400px; height=250px;>


- Add  the below content as Arguments:

```
/c php "c:\inetpub\wwwroot\artisan" queue:work redis --sleep=3 --tries=3
```

- Go to *Details* and give Display Name as *faveo-mail-worker*. (*faveo-recurring* & *faveo-reports* for the remaing two.) 

- Now click on the right arrow and go to *I/O* and set *Output (stdout)* by clicking on three dots.

-  Navigate to *C:\inetpub\wwwroot\storage\logs*, provide a file name as *worker.log* (*recurring.log* & *reports.log* for the remaing two) and click *open* as shown in figure below, Output (stdout) will be added. 

- Now click on *Install Service* .

- (Do the Same for remaing two as well):

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/redis14.png" width=400px; height=250px;>

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/redis15.png" width=400px; height=250px;>

- Now go to *windows menu > Run > Services*, This can be done by  following shortcut *win+R*, type *services.msc* & click *OK*, it will open a new Services tab. 
- Find *Faveo-mail-worker* right click on it & go to *Properties > Recovery* a new tab will open.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/redis16.png" width=400px; height=250px;>


 - Change *first failure, second failure & subsequent failure* from Take No Action to *Restart the Service* & click *OK*.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/redis17.png" width=400px; height=250px;>

- Now click *faveo-mail-worker* and *start the service* as shown below: 

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/redis18.png" width=400px; height=250px;>


**Repeat the above steps for FAVEO RECURRING & FAVEO REPORTS**

The details to be filled for Faveo Mail Worker, Faveo Recurring & Faveo Reports are summarised below:

- **FAVEO MAIL WORKER**


Command
```
nssm install faveo-mail-worker
```

Path
```
C:\Windows\System32\cmd.exe
```

Startup Directory
```
C:\Windows\System32
```

Arguments
```
/c php "c:\inetpub\wwwroot\artisan" queue:work redis --sleep=3 --tries=3
```

Output(Stdout)
```
C:\inetpub\wwwroot\storage\logs\worker.log
```




- **FAVEO RECURRING**


Command
```
nssm install faveo-recurring
```

Path
```
C:\Windows\System32\cmd.exe
```

Startup Directory
```
C:\Windows\System32
```

Arguments
```
/c php "c:\inetpub\wwwroot\artisan" queue:work redis --queue=recurring --sleep=3 --tries=3
```

Output(Stdout)
```
C:\inetpub\wwwroot\storage\logs\recurring.log
```




- **FAVEO REPORTS**



Command
```
nssm install faveo-reports
```

Path
```
C:\Windows\System32\cmd.exe
```

Startup Directory
```
C:\Windows\System32
```

Arguments
```
/c php "c:\inetpub\wwwroot\artisan" queue:work redis --queue=reports --sleep=3 --tries=3
```

Output(Stdout)
```
C:\inetpub\wwwroot\storage\logs\reports.log
```



Now NSSM has been successfully configured.
