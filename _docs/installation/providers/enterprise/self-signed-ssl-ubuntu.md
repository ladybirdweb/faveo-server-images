---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/self-signed-ssl-ubuntu/
redirect_from:
  - /theme-setup/
last_modified_at: 2021-12-12
toc: true
---

# <strong>Install Self-Signed SSL for Faveo on Ubuntu</strong>  <!-- omit in toc -->

<img alt="Ubuntu" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Logo-ubuntu_cof-orange-hex.svg/120px-Logo-ubuntu_cof-orange-hex.svg.png" width="120" height="120" />


## <strong>Introduction:</strong>

This document will list on how to install Self-Signed SSL certificates on Ubuntu.

We will be using a tool OpenSSL for creating Self-Signed SSL certificate's in ubuntu.
The OpenSSL is an open-source library that provides cryptographic functions and implementations. OpenSSL is a defacto library for cryptography-related operations and is used by a lot of different applications. OpenSSL is provided as a library and application. OpenSSL provides functions and features like SSL/TLS, SHA1, Encryption, Decryption, AES, etc.

This OpenSSL is installed and ready to use in Ubuntu, to check the OpenSSL is installed and the version of it please use the below command.
```sh
openssl version
```

## <strong>STEPS:</strong>

To create a Self-Signed SSL certificates we need to create CA(Certificate Authority) from which we will validate and sign the SSL certificate as a valid certificate.
Below are the steps to create a Self-Signed SSL certificate using a CA.

- Generate a private key for the CA.
- Generate a root certificate.
- Create a private key for the certificate.
- Create a certificate signing request.
- Create a certificate and sign it with the CA private key.
- Installing the SSL certificate.

### <strong>Generate a private key for the CA:</strong>

Please create a directory for saving the certificates and the key files that we creaate in the below steps, please run this commands from the home directory:
```sh
mkdir ssl
cd ssl
```

The private key for the CA can be generated using the following command.

```sh
openssl genpkey -algorithm RSA -des3 -out private-key-ca.pem -pkeyopt rsa_keygen_bits:4096
```
The above command will create a Private key for the CA certificate with the name private-key-ca.pem. The above command will ask for a password for the key file please provide a meaningful password, which will be necessary for the below commands. 

### <strong>Generate a root certificate (CA Certificate):</strong>

To generate a CA root certificate based on the private key generated in the previous step use the below command.

```sh
openssl req -x509 -new -key private-key-ca.pem -sha256 -days 3650 -out ca-certificate.pem
```
- -x509 — Perform a certificate command.
- -new — Indicates the new certificate.
- -out — The filename to use to save the generated certificate. In this case, certificate.pem.
- -req — Indicate to OpenSSL that the input is a CSR.
- -signkey — Self-sign the certificate request using the given private-key.pem file.
- -days — The number of days the generated certificate is valid. Normal values are 365, 730, and 1095 days, to specify a duration of one, two, or three years.

OpenSSL again asks the passphrase of the private key which we used on the above command while creating private key and asks what information to put in the root certificate.

The above command will create a CA certificate file which will be saved in the current directory.

### <strong>Create a private key for the certificate:</strong>

To generate a Self-Segined we need to create a new key file specific to the certificate for the domain to create it use the below command.

```sh
openssl genpkey -algorithm RSA -des3 -out private-key.pem -pkeyopt rsa_keygen_bits:4096
```
This command generates the file private-key.pem in the current directory.

### <strong>Create a certificate signing request:</strong>

To create a signed certificate we need to create a CSR (certificate signing Request)




## Setting up the SSL certificate
To Install Self Signed SSL certificates in Centos, We need to create SSL Cetificates which is signed by the CA certificate, after that we need to add the Virtual host file for the SSL certificate.

## <strong>Steps</strong>

- Generate a private key for the CA (Certificate Authority).
- Generate a certificate signing request for the CA.
- Generate a root certificate.
- Create a private key for the certificate.
- Create a certificate signing request.
- Create a certificate and sign it with the CA private key.
- Installing the SSL certificate.

### <strong>Generate a private key for the CA</strong>

Create a directory named SSL in the home or on any directory, the following commands will create the SSL files those files will be saved in the directory which we create.
- From the SSL folder that was created run the below commands.
- Run the below command to create a Private key for the rootCA this command will save a file name faveoroot.key in the SSL folder.

```
openssl ecparam -out faveoroot.key -name prime256v1 -genkey
```

### <strong>Generate a certificate signing request for the CA</strong>

- Run the below command which will create a CSR (certificate signing request) for the Root CA.

```
openssl req -new -sha256 -key faveoroot.key -out faveoroot.csr
```
- The above command will ask for the below information if needed you can provide them or you can just hit enter and skip them but it is recommended to give the meaningful details.

    - Country Name.
    - State Name.
    - Organization.
    - Comman name (We don't need to add any details to this field)
    - Email address.

- The above command will save a file in the name faveoroot.csr in the SSL directory.

### <strong>Generate a root certificate</strong>

- The below ccommand will create the Root CA certificate which we will use to sign the SSL certificates.


```
openssl x509 -req -sha256 -days 3650 -in faveoroot.csr -signkey faveoroot.key -out faveorootCA.crt
```

- The above command will create a file and save it as faveorootCA.crt in the SSL directory.

### <strong>Create a private key for the certificate</strong>

- The below command will create a private key file for the server SSL certificate.

```
openssl ecparam -out private.key -name prime256v1 -genkey
```

- The above command will save a key file with the name private.key for the server SSL certificate.

### <strong>Create a certificate signing request for the server SSL</strong>

- The below command will create a Certificate Signing Request for the Server webpage SSL.

```
openssl req -new -sha256 -key private.key -out faveolocal.csr
```

- It will ask for the details as below we should give the details as shown below.

    - Country Name.
    - State Name.
    - Organization.
    - Common name (the domain or the IP which we need to create the SSL certificate for faveo should be entered).
    - Email address.
- The rest can be left blank and after this is completed it will create the CSR file and save it with the name faveolocal.csr in the SSL directory.

### <strong>Create a certificate and sign it with the CA private key</strong>

- The below command will create the server SSL certificate which is signed by the Root CA that we created above.

```
openssl x509 -req -in faveolocal.csr -CA  faveorootCA.crt -CAkey faveoroot.key -CAcreateserial -out faveolocal.crt -days 3650 -sha256 
```
- The above command will create a server SSL file and save it in the name faveolocal.crt, this certificate will be valid for 3650 days that is ten years.

## Setting up the Virtual host file for the Self signed SSL certificate's.

- We need to enable some Modules for the ssl as below : 
```
dnf install mod_ssl
systemctl restart httpd
```
- The above will install mod_ssl module and restart apache.
- Before creating the Virtual host file for SSL we need to copy the created SSL certificate's and Key file to the corresponding directory with below command, these commands should be runned from the SSL Directory.
```
cp faveolocal.crt /etc/pki/tls/certs
cp private.key /etc/pki/tls/private
cp faveorootCA.crt /etc/pki/ca-trust/source/anchors/
```
- Then adding the Virtual host file, for that we need to create a file in webserver directory as <b> /etc/httpd/conf.g/faveo-ssl.conf.</b>
- Then need to copy the below configuration inside the faveo-ssl.conf file.

```
<IfModule mod_ssl.c>
        <VirtualHost *:443>
                ServerAdmin ---DomainName or IP---

                DocumentRoot /var/www/faveo/public

                ErrorLog ${APACHE_LOG_DIR}/error.log
                CustomLog ${APACHE_LOG_DIR}/access.log combined

                SSLEngine on

                SSLCertificateFile      /etc/pki/tls/certs/faveolocal.crt
                SSLCertificateKeyFile /etc/pki/tls/private/private.key

                <FilesMatch "\.(cgi|shtml|phtml|php)$">
                                SSLOptions +StdEnvVars
                </FilesMatch>
                <Directory /usr/lib/cgi-bin>
                                SSLOptions +StdEnvVars
                </Directory>

        </VirtualHost>
</IfModule>
```

## After Creating the Virtual Host file we need to add the local host for the domain.

- After adding the SSL certificates and virtual hosts we need to add the domain to the hosts file to the local host as below.
```
nano /etc/hosts
```
- In the above file add the below line replace the domain or the IP which is used for the faveo.
```
127.0.0.1  ---Domain or IP---
```
- After the above is done then we need to add the the ca-cert file path to the php.ini file add the path to the openssl.cafile like this : "<b>openssl.cafile = "/etc/pki/tls/certs/ca-bundle.crt"</b> 

- Now check the faveo on the Browser it will take you to probe page, if everything is good then you can proceed with the installation in Browser.