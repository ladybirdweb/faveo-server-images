---
layout: single
type: docs
permalink: /docs/installation/providers/community/cpanel/
redirect_from:
  - /theme-setup/
last_modified_at: 2020-06-09
toc: true
title: "Installing Faveo Helpdesk on cPanel"
---
<img alt="cPanel" src="https://en.wikipedia.org/wiki/CPanel#/media/File:CPanel_logo.svg" width="120"  />

Faveo is a self-hosted software where you can install the software by yourself on your own servers. While the installer provides step by step guide during the installation, it's important and helpful to have general knowledge about Web servers, PHP and MySQL.

Before getting started make sure your server meets following minimum requirement required to install and use Faveo as listed [here](docs/system-requirement/requirement/)

Faveo can run on [cPanel](https://cpanel.net/).

-   [Installation steps](#installation-steps)
    -   [1. Upload Faveo](#1-upload-faveo)
    -   [2. Setup the database](#2-setup-the-database)
    -   [3. Install Faveo](#3-gui-faveo-installer)
    -   [4. Configure cron job](#4-configure-cron-job)
    -   [5. Final step](#final-step)


<a id="installation-steps" name="installation-steps"></a>
## Installation steps

<a id="1-upload-faveo" name="1-upload-faveo"></a>
### 1. Upload Faveo
Please download Faveo Helpdesk from [https://billing.faveohelpdesk.com](https://billing.faveohelpdesk.com) and upload the .zip files in the folder of your choice on your server.


<img alt="" src="https://lh6.googleusercontent.com/QvogNHnM9veEU-FO2RBah-5BlD0bqhL3Tp_2Td2R2aunRBxwEbbKfCkmbb9DhW9TT9IwkFh8RdDScutANFZ01rHFrx8O5V_EU71NSbDgTjsrGLulJcv5b74Tc_FeoYHlD1TwVbMu"  />

<img alt="" src="https://lh6.googleusercontent.com/Tix0BlPoyjxHnYHEnNnen6bYjA1MByWDrLa_wvDZn3Kvgy2O564JzXwoNLZG9ZbOazgCSspzx61OwchYdyVBWl1GIE_tPohKfeSWnB4ZIMbbRkAe-QUawpBdmSYFCRryag0-ZZ1C"  />

Once you land to the File Manager > Public-HTML, Click on the Folder icon at the top left of CPanel, to create a new folder where your faveo need to be hosted.
 
<img alt="" src="https://lh4.googleusercontent.com/K6s9RwFFuKwf_xJxh27op-I8yZVauLZckirVkeP0UBFbVpz9qIVUO6WM3x5OBKjePGDWo0LZERLK4xDKE5nMu6iccF92c_mmBEk7gDv14-MkM4aiO_Z0JPJCtmLtgpGzsrgtOPai"  />

Click on Folder which you have created and upload the software .zip file. (Or) You can also create a subdomain to upload the file.

You can click on the Upload button in CPanel. (Or) You can also upload the file from FTP. (File Zilla)
 
<img alt="" src="https://lh4.googleusercontent.com/KtwiXeXp0U5ps9-wBBsdfLPzQ_6bBEpifNBT-tUkYcYF0LVLey7G0AOZ6xcZ-RMBV0GQ9Tf0_6rMpob6fDzXBiiwAl4rErmNAszxSNJ7qRz7CNqS8WPs8fe_HP9FCsPy3_nSUFo4"  />

Select the .zip file of the software from your local system. Once it is uploaded click on the “Go back to home/….” and Right-click on the .zip file and extract it.

<img alt="" src="https://lh3.googleusercontent.com/-G70yy2sOPWNWW8e9mVqA1vSs0xRIrxr9AeWipZtoMtig9403C_JiJNChrfUiTjCRdDf1cTLnVLSYphV5d4HvSDBYMaYI3jkmfgtf0JkuGgdlw3PaaOWTjXGG2YKmQU-NLJkYuis"  />

<img alt="" src="https://lh3.googleusercontent.com/lS7h_sWqffJV9hHM7gFDaKN_rvoNNkxsKmIcylVfqIyEhm2KLbmR5srjo2EqCuCB1f920XPLt62QUdKZJN6oSbXZK8ASq4m2ZwIkZzRQQG43F_-2qqhbhyJh5TIYLk1dxGmUz_m0"  />

Once the file is extracted with the folder delete the .zip file.

<img alt="" src="https://lh6.googleusercontent.com/aakdQj86xOzfvi9wgGaRFN71TkpMIQRfAYCRx4I68XssU9fkkcvH9OJvzvd8tkIScnhkZONtedAFo6UWSTUY8nYCtI_YuNsjcW2kBjbadyKAj3kSVz2LExid9_XY_4xz7lpLkND4"  />

Double click on the extracted folder and select all the files, Right-click on it and you will get an option “Move” click on the option and move the files to the main folder. 

<a id="2-setup-the-database" name="2-setup-the-database"></a>
### 2. Setup the database

Navigate to CPanel > MySQL and Database and click on it.

<img alt="" src="https://lh4.googleusercontent.com/aLfs9EGYVnk3m2iPALGwmK_bOqns5mJSD2AQE-LOQDLioZWCBzx_dDsWWE2cuqjfLIspPj52U6QHHJ31AMfS_vkCIkjufhjEb_4LMN1vBYXUR1EJ4BXhyv5hhHsHOOVzEGXN9Lc-"  />

Once you land to the page Create a New Database.

<img alt="" src="https://lh5.googleusercontent.com/Wi-ZYJObYIE0LnjSx-tzu113Ze-J6raxZCNLPgK2Kbh5hrkMNjaLb9nhUSzS61ldK697OeBudr_ZcYKYMwIRjRzDgXHhlCqzMrS-OqqoyF5EWHz7uyHSU-W_9XzUjsd65SDlpFmI"  />

Create a new user for the database by registering the user name in the specified box.

<img alt="" src="https://lh6.googleusercontent.com/ZAAs160phqKUZReeOoUKoHgoArdebNwxMait4rAn5eFEXn1AsyOU29w2l8igfBHBTcLAjQS7hHCVIbPb6KjQP2dSb7VgCe5Z6HG9PXFyMFTz-6rhjR3EZF6s6XsM7Yu2oGZa8QMg"  />

You can register the Password of your own in the specified boxes. (Or) you can use the Password generator to generate a new password for the user.

Now click on the Create User button to create a user and set the access for the user.

<img alt="" src="https://lh6.googleusercontent.com/HFGhvCd3mWw8LlKhi2R8bQik4ZhL9K6Ui_8-FIxEd5sdDSlUiH3zhiwR_pp7kOBpjAEE4W9phbFu6DzV3B4JfQP3DvWvZsW5lFyRq1rKlM0cAbpLuazcwN7x8cqtoRZjscdXrM6M"  />

In Manage User Privileges, you can give access privileges (Choose All Privileges checkbox) ) to the newly created user and click on the Make Changes button save the details. Click on “Go back” to get the database page.

Now link the newly created user with the Database you have created, under Add New User to Database. Select the Database name from the list for which the user needs to be added and select the user name to add with the DB.

<img alt="" src="https://lh5.googleusercontent.com/IZIPudyrGRC92QQXVAQiIpTozEuJeseyj9r4q-23AvDu_etpKkp3tVzFgatr1D7NPqmVW_q1tPo9Hw_oh4d6lpJo9KhOp60Ba-nH-198LyIKEUxskkl1FjeajVS90vUS9HqUCg6x"  />

<a id="3-gui-faveo-installer" name="3-gui-faveo-installer"></a>
### 3. Install Faveo

Now you can install Faveo via [GUI](/docs/installation/installer/gui) Wizard or [CLI](/docs/installation/installer/cli)

<a id="4-configure-cron-job" name="4-configure-cron-job"></a>
### 4. Configure cron job

Faveo requires some background processes to continuously run. 
Basically those crons are needed to receive emails

Go to CPanel > Crons Jobs > Add New Cron Job to set the cron URL

<img alt="" src="https://lh6.googleusercontent.com/SDTOXrj74XAcbuRVAFGhCwqXJ_y7WRG7GzRqy3x7FGMmpzmszahkM7udnnERWLkuCugdqwrNe5UXDWqk443GhIlM9VEV2yhhxk-N-ntJmgpmqIWAp3l1AK13Xpsth3hP1wxr-W8E"  />


<a id="final-step" name="final-step"></a>
### 5. Final step

The final step is to have fun with your newly created instance, which should be up and running to `http://localhost` or the domain you have configured Faveo with.