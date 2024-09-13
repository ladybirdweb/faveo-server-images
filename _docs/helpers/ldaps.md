---
layout: single
type: docs
permalink: /docs/helpers/ldaps/
redirect_from:
  - /theme-setup/
last_modified_at: 2024-07-23
last_modified_by: Mohammad_Asif
toc: true
title: "LDAPS Self-Signed Certificate Trust Configuration"
---
<img alt="ftp" src="https://i0.wp.com/ldap.com/wp-content/uploads/2018/04/ldapdotcom-white-background-with-text-1024x341.png?resize=1024%2C341&ssl=1" width="200"  />


- [<strong>Introduction :</strong>](#introduction-) 
    - [<strong>1. Debian and Derivatives</strong>](#1-debian-and-derivatives)
    - [<strong>2. Red Hat and Derivatives</strong>](#2-redhat-and-derivatives)
    - [<strong>3. Windows Server</strong>](#3-windows-server)

<a id="introduction-" name="introduction-"></a>

## <strong>Introduction:</strong>
To connect to an LDAPS server using a self-signed certificate, you'll need to add the certificate to the trusted authorities on your client system (Faveo Server). Follow these instructions based on your operating system.

<a id="1-debian-and-derivatives" name="1-debian-and-derivatives"></a>

### <strong>1. Debian and Derivatives</strong>

Debian and Derivates include:
 
a. Debian 11 (Bullseye) 

b. Debian 12 (Bookworm)  

c. Ubuntu 20.04 (Focal Fosa) 

d. Ubuntu 22.04 (Jammy Jellyfish)

#### 1. Install Required Packages

Open a terminal and execute the following commands to install necessary packages:

```
sudo apt update
sudo apt install ldap-utils openssl
```

#### 2. Trust the Self-Signed Certificate

**a. Get the Certificate:**

Use the following command to retrieve the certificate details:

```
openssl s_client -connect ldap.demo.com:636 -showcerts
```

Copy the certificate from <code><b>-----BEGIN CERTIFICATE-----</b></code> to <code><b>-----END CERTIFICATE-----</b></code> and save it to a file, e.g., ldap_cert.crt.

**b. Add the Certificate to Trusted Authorities:**

Create a file for the certificate and add it to the trusted certificate store:

```
sudo nano /usr/local/share/ca-certificates/ldap_cert.crt
```
Paste the copied certificate into this file.

**c. Update CA Certificates:**

```
sudo update-ca-certificates
```

**d. Verify Connection:**

Test the LDAP connection:

```
ldapsearch -x -H ldaps://ldap.demo.com:636 -D "cn=admin,dc=demo,dc=com" -W -b "dc=demo,dc=com"
```

<a id="2-redhat-and-derivatives" name="2-redhat-and-derivatives"></a>

### <strong>2. Red Hat and Derivatives</strong>

Red Hat and Derivatives include: 

a. Alma 8 

b. Alma 9 

c. Rocky 8 

d. Rocky 9 

e. RHEL 8 

f. RHEL 9

#### 1. Install Required Packages

Open a terminal and execute the following commands to install necessary packages:

```
sudo yum install ldap-utils openssl
# or
sudo dnf install ldap-utils openssl
```

#### 2. Trust the Self-Signed Certificate

**a. Get the Certificate:**

Use the following command to retrieve the certificate details:

```
openssl s_client -connect ldap.demo.com:636 -showcerts
```

Copy the certificate from <code><b>-----BEGIN CERTIFICATE-----</b></code> to <code><b>-----END CERTIFICATE-----</b></code> and save it to a file, e.g., ldap_cert.crt.

**b. Add the Certificate to Trusted Authorities:**

Create a file for the certificate and add it to the trusted certificate store:

```
nano /etc/pki/ca-trust/source/anchors/ldap_cert.crt
```

Paste the copied certificate into this file.


**c. Update CA Certificates:**

```
sudo update-ca-trust
```

**d. Verify Connection:**

Test the LDAP connection:

```
ldapsearch -x -H ldaps://ldap.demo.com:636 -D "cn=admin,dc=demo,dc=com" -W -
```

<a id="3-windows-server" name="3-windows-server"></a>

### <strong>3. Windows Server</strong>

#### 1. Install Required Tools

Open SSL is not available for windows in .exe format the easiest way to install is by using a third-party software CHOCOLATEY.

Install “Chocolatey” a package management software for windows by using the below command.

Open Powershell.exe with Administrator Privilege, Paste the below command and hit enter

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```
It may ask for permission please select yes for all and when the installation is over then enter the below command.

Open the command prompt with Administrator privilege and enter the below command to install OpenSSL.

```
choco install openssl 
```
It will prompt and ask for 'yes' give 'yes' and wait till the installation gets done.

### 2. Trust the Self-Signed Certificate

**a. Get the Certificate:**

Use the following command to retrieve the certificate details, run it in command prompt window with Administrator Privileges:

```
openssl s_client -connect ldap.demo.com:636 -showcerts
```

Copy the certificate from <code><b>-----BEGIN CERTIFICATE-----</b></code> to <code><b>-----END CERTIFICATE-----</b></code> and save it to a file, e.g., ldap.crt.

Save the <code><b>ldap.crt</b></code> file inside php folder <code><b>C:\php8.1</b></code> 

**b. Install the Certificate:**

Double Click on the ldap.crt certificate, It will Open a new Window to install the Certificate.

Install the Certificate for both <code><b>Current User</b></code>  and <code><b>Local Machine</b></code>  one by one and save it to Trusted Root Certification Authorities.

**c. Create System Environment Variable:**

Create a file ldap.conf inside php folder i.e, <code><b>C:\php8.1\ldap.conf</b></code>

The Content of ldap.conf file is the path of ldap.crt file as shown below:
```
TLS_CACERT C:\php8.1\ldap.crt
```

Now Create a System Environment Variable <code><b>LDAPCONF</b></code> and pass the value as the path of ldap.crt file
```
C:\php8.1\ldap.conf
``` 

Open Command Prompt and Verify the saved Environment Variable Path by running below command:
```
echo %LDAPCONF%
```
 
<p class="notice--warning">
Note that LDAPS Works only on Windows with IIS and not on Windows with Apache
</p>