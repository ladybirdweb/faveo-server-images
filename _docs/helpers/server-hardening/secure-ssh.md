---
layout: single
type: docs
permalink: /docs/helpers/server-hardening/secure-ssh
redirect_from:
  - /theme-setup/
last_modified_at: 2024-09-12
last_modified_by: Mohammad_Asif
toc: true
title: "How to secure the server for SSH"
---


This article describes how to server for SSH access, enable and disable two-factor authentication for SSH on an unmanaged server.


---

> This article only applies to Linux servers. You must have root access to the server to follow these procedures.

## About two-factor authentication

- By default, when users access your unmanaged VPS, Cloud VPS, or dedicated server using SSH, they type a username and password to log in.

- Two-factor authentication provides an extra layer of security because, in addition to knowing the correct username and password, users must provide another piece of information. This piece of information is a temporary, numeric password generated independently on the server and on a mobile device, such as a smartphone or tablet.

- As a result, in order for a potential attacker to access your server, he or she would not only need to obtain something you know (your username and password), but also something you have (your mobile device). This two-factor approach to logins significantly enhances your server's security and makes brute-force attacks much more difficult.

## Enabling two-factor authentication for SSH

 To enable two-factor authentication with SSH on your server, do the following steps in the order in which they are presented.


### Step 1: Disable root logins for SSH

> If you haven't done so already, you should disable root SSH logins on your server and create a normal user account.

This article describes how to disable SSH logins for the root account. For security reasons, you should create a normal user account, and then disable SSH logins for the root account as soon as possible.

#### Step 1: Create a normal user account

Before you disable SSH logins for the root account, you must create a normal user account. (Otherwise, you will be unable to access your server when you disable the root account for SSH logins.)

##### CentOS and Fedora
To create a user and grant it administrative privileges on a server running CentOS or Fedora, follow these steps:
1. Log in to the server using SSH.

2. At the command prompt, type the following command. Replace username with the name of the user that you want to add:
```
useradd username
```

3. Type the following command, replacing username with the name of the user that you created in step 2:
```
passwd username
```

4. To grant administrative privileges to the user, type the following command:
```
visudo
```

This command opens the sudoers file for editing.

5. Add the following line to the file. Replace username with the name of the user that you created in step 2:
```
username ALL=(ALL) ALL
````

6. Now the user can run commands as the root user by prefixing the command with sudo. For example, the user can view the root home directory by typing the command sudo ls /root.

##### Debian and Ubuntu

To create a user and grant it administrative privileges on a server running Debian or Ubuntu, follow these steps:

1. Log in to the server using SSH.

2. At the command prompt, type the following command. Replace username with the name of the user that you want to add:
```
adduser username
```

3. Install the sudo package. To do this, type the following command:
```
apt-get install sudo
```

4. To add the user to the sudo group, type the following command. Replace username with the name of the user that you created in step 2.
```
usermod -a -G sudo username
```

5. Now the user can run commands as the root user by prefixing the command with sudo. For example, the user can view the root home directory by typing the command sudo ls /root.

### Step 2: Disable SSH logins for root

After you create a normal user, you can disable SSH logins for the root account. To do this, follow these steps:

1. Log in to the server as root using SSH.

2. Open the /etc/ssh/sshd_config file in your preferred text editor (nano, vi, etc.).

3. Locate the following line:
`PermitRootLogin yes
`

4. Modify the line as follows:
`PermitRootLogin no
`

5. Add the following line. Replace username with the name of the user you created in the previous procedure:
`AllowUsers username
`

> This step is crucial. If you do not add the user to the list of allowed SSH users, you will be unable to log in to your server!

6. Save the changes to the /etc/ssh/sshd_config file, and then exit the text editor.

7. Restart the SSH service using the appropriate command for your Linux distribution:

- For CentOS and Fedora, type:
```
systemctl restart sshd
```

- For Debian and Ubuntu, type:
```
service ssh restart
```

> While still logged in as root, try to log in as the new user using SSH in a new terminal window. You should be able to log in. If the login fails, check your settings. Do not exit your open root session until you are able to log in as the normal user in another window.


If the above is working then the new user creation and root user login is disabled successfully.



### Step 2: Install an authenticator app on a mobile device

If you haven't done so already, you should disable root SSH logins on your server and create a normal user account. For information about how to do this, please see this article.

> For Google Android and Apple iOS devices, A2 Hosting recommends the Google Authenticator app.
> For Windows Phone and other Microsoft Windows-based devices, you can use the Authenticator app or the Azure Authenticator app.


### Step 3: Enable two-factor authentication on the server

To enable two-factor authentication on the server, follow these steps:

1. Log in to your server using SSH.

2. As the root user, install the Google Authenticator package:
	
- For Debian and Ubuntu, type the following command:
```
apt-get install libpam-google-authenticator
```
	
-	For CentOS and Fedora, type the following command:
```
yum install google-authenticator
```

> Google develops and maintains the Google Authenticator code, but it does not collect any information from your server.

3. Stay logged in as the root user, and then in a separate window, log in to your server as a normal (that is, non-root) user.

4. At the command prompt, type the following command:
```
google-authenticator
```

5. At the Do you want authentication tokens to be time-based? prompt, type y and then press Enter.

6. The server generates a QR code image and emergency codes. On your mobile device, scan the QR code image and configure the account.

7. On the server, at the Do you want me to update your “/home/username/.google_authenticator” file? prompt, type y and then press Enter.

8. At the Do you want to disallow multiple uses of the same authentication token? prompt, type y and then press Enter.

9. At the By default, tokens are good for 30 seconds… prompt, type n and then press Enter.

10. At the Do you want to enable rate-limiting? prompt, type y and then press Enter.

11. As the root user, open the /etc/pam.d/sshd file in your preferred text editor.

-	Add the following line to the top of the file:
```
auth required pam_google_authenticator.so 
```
	
-	Save your changes to the sshd file.

12. As the root user, open the /etc/ssh/sshd_config file in your preferred text editor.
	
Locate the following line:
```
ChallengeResponseAuthentication no
or KbdInteractiveAuthentication no
```
	
Modify the line as follows:
```
ChallengeResponseAuthentication yes
or KbdInteractiveAuthentication yes
```
	
Save your changes to the sshd_config file.

13. As the root user, restart the SSH service:
	
-	For Debian and Ubuntu, type the following command:
```
service ssh restart
```

-	For CentOS and Fedora, type the following command:
```
service sshd restart
```

14. While still logged in as the root user, in a separate window log in as the normal user and test the new configuration:
	
-	At the Verification code prompt, type the numeric password displayed by the authenticator app on your mobile device.
	
-	At the Password prompt, type the password for the user.

> If authentication fails, verify that you followed the previous steps correctly. Do not log out as the root user until you are sure the new authentication configuration is working correctly.

## Disabling two-factor authentication for SSH

> If you decide that you no longer want to use two-factor authentication with SSH, you can disable it. To do this, follow these steps:


1. Log in to your server using SSH.
2. As the root user, open the /etc/pam.d/sshd file in your preferred text editor.

Delete or comment out the following line at the top of the file:
```
auth required pam_google_authenticator.so
```

Save your changes to the sshd file.

3. Open the /etc/ssh/sshd_config file in your preferred text editor.

Locate the following line:
```
ChallengeResponseAuthentication yes
```

Modify the line as follows:
```
ChallengeResponseAuthentication no
```

Save your changes to the sshd_config file.

4. Restart the SSH service:

-	For Debian and Ubuntu, type the following command:

```
service ssh restart
```

-	For CentOS and Fedora, type the following command:

```
service sshd restart
```

> Two-factor authentication is now disabled for SSH.



