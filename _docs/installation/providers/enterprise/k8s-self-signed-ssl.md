---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/k8s-self-signed-ssl
redirect_from:
  - /theme-setup/
last_modified_at: 2024-08-27
toc: true
title: Install Self-Signed SSL for Faveo on K8s
---


<img alt="Ubuntu" src="https://raw.githubusercontent.com/kubernetes/kubernetes/7436ca32bc766ff202109a7541d2e7bb41ee7d13/logo/logo.svg" width="120" height="120" />



# Setting up the SSL Certificate

To install self-signed SSL certificates for Kubernetes, follow these steps to create SSL certificates signed by a CA certificate. This process includes creating Kubernetes Secrets and ConfigMaps for managing the certificates and configuring the NGINX Ingress resource. The detailed steps are explained below:

## Steps

1. **Generate a private key for the CA (Certificate Authority).**
2. **Generate a certificate signing request for the CA.**
3. **Generate a root certificate.**
4. **Create a private key for the server certificate.**
5. **Create a certificate signing request for the server SSL certificate.**
6. **Create a certificate and sign it with the CA private key.**
7. **Install the SSL certificate.**

## Step 1: Generate a Private Key for the CA

Create a directory named `SSL` in the home or any other directory. Run the following commands from the `SSL` folder to create the necessary SSL files.

To create a private key for the Root CA, run:

```bash
openssl ecparam -out faveoroot.key -name prime256v1 -genkey
```

This command will save a file named `faveoroot.key` in the `SSL` folder.

## Step 2: Generate a Certificate Signing Request for the CA

Run the following command to create a CSR (certificate signing request) for the Root CA:

```bash
openssl req -new -sha256 -key faveoroot.key -out faveoroot.csr
```

The command will prompt you to enter information such as Country Name, State Name, Organization, Common Name (leave blank or provide the company domain, not the Faveo domain), and Email Address. The CSR file `faveoroot.csr` will be saved in the `SSL` directory.

## Step 3: Generate a Root Certificate

Create the Root CA certificate using the following command:

```bash
openssl x509 -req -sha256 -days 3650 -in faveoroot.csr -signkey faveoroot.key -out faveorootCA.crt
```

This command will create a file named `faveorootCA.crt` in the `SSL` directory.

## Step 4: Create a Private Key for the Server Certificate

Generate a private key for the server SSL certificate:

```bash
openssl ecparam -out private.key -name prime256v1 -genkey
```

The file `private.key` will be created for the server SSL certificate.

## Step 5: Create a Certificate Signing Request for the Server SSL Certificate

Create a CSR for the server SSL certificate:

```bash
openssl req -new -sha256 -key private.key -out faveolocal.csr
```

Provide the following details when prompted:

- Country Name
- State Name
- Organization
- Common Name (provide the domain or IP through which you will access Faveo)
- Email Address

The CSR file `faveolocal.csr` will be saved in the `SSL` directory.

## Step 6: Create a Certificate and Sign It with the CA Private Key

Create the server SSL certificate signed by the Root CA:

```bash
openssl x509 -req -in faveolocal.csr -CA faveorootCA.crt -CAkey faveoroot.key -CAcreateserial -out faveolocal.crt -days 3650 -sha256
```

This command will create a server SSL file named `faveolocal.crt`, valid for 3650 days (10 years).

## Step 7: Obtain SSL Certificate and CA Certificate

- Obtain your SSL certificate (`faveolocal.crt`) and private key (`faveolocal.key`).
- Obtain the CA certificate (`faveorootCA.crt`).

## Step 8: Create Kubernetes Secrets

### 1. Create a Secret for the SSL Certificate:

```bash
kubectl create secret tls faveo-tls \
  --cert=path/to/faveolocal.crt \
  --key=path/to/faveolocal.key \
  -n faveo
```

### 2. Create a ConfigMap for the CA Certificate:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: faveo-ca-certificates
  namespace: faveo
data:
  faveorootCA.crt: |
    -----BEGIN CERTIFICATE-----
    [Your CA Certificate Content]
    -----END CERTIFICATE-----
```

Apply the ConfigMap:

```bash
kubectl apply -f ca-configmap.yaml
```

## Step 9: Configure the NGINX Ingress Resource

Update your Ingress resource to use the SSL certificate and configure it to verify upstream SSL connections using the CA certificate:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: faveo-ingress
  namespace: faveo
  annotations:
    kubernetes.io/ingress.class: nginx
spec:
  tls:
  - hosts:
    - "your_domain_name"
    secretName: faveo-tls
  rules:
  - host: "your_domain_name"
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: faveo-svc
            port:
              number: 80
```

Apply the Ingress resource:

```bash
kubectl apply -f ingress.yaml
```

## Step 10: Update Deployment Configuration

Ensure the CA certificate is included in your deployment configuration:

Open deploy-faveo.yaml and uncomment all the ca-certificates commented lines. It should now look like this.

```yaml
---
        - name: ca-certificates
          mountPath: /usr/local/share/ca-certificates/faveorootCA.crt
          subPath: faveorootCA.crt

---
      - name: ca-certificates
        configMap:
          name: faveo-ca-certificates
```

Apply the changes to your Kubernetes cluster:

```bash
kubectl apply -f deploy-faveo.yaml
```

## Step 11: Access Your Domain

Visit \`https://your_domain_name\` to confirm that the SSL certificate is correctly applied and the connection is secure.