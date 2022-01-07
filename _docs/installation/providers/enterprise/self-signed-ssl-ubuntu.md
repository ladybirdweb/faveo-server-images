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