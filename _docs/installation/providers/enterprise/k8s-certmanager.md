---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/k8s-cert-manager
redirect_from:
  - /theme-setup/
last_modified_at: 2024-08-27
toc: true
title: Install Let’s Encrypt SSL for Faveo on K8s
---


<img alt="Ubuntu" src="https://cert-manager.io/images/cert-manager-logo-icon.svg" width="120" height="120" />


## Exposing the App Ingress Using Cert-Manager

To secure your Ingress Resources, you’ll install Cert-Manager, create a ClusterIssuer for production, and modify the configuration of your Ingress to take advantage of the TLS certificates. ClusterIssuers are Cert-Manager Resources in Kubernetes that provision TLS certificates for the whole cluster. Once installed and configured, your app will be running behind HTTPS.

Add the Jetstack Helm repository:
```sh
helm repo add jetstack https://charts.jetstack.io
```
Update your local Helm chart repository cache:
```sh
helm repo update
```
Install cert-manager and its Custom Resource Definitions (CRDs) like Issuers and ClusterIssuers
```sh
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.8.0 \
  --set installCRDs=true
```
To verify our installation, check the cert-manager Namespace for running pods:
```sh
kubectl get pods --namespace cert-manager
```
You’ll now create one that issues Let’s Encrypt certificates, and you’ll store its configuration in a file named cluster_issuer.yaml. Create it and open it for editing.

Add the following lines:
```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
  namespace: cert-manager
spec:
  acme:
    # Email address used for ACME registration
    email: your_email_address
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      # Name of a secret used to store the ACME account private key
      name: letsencrypt-prod
    # Add a single challenge solver, HTTP01 using nginx
    solvers:
    - http01:
        ingress:
          class: nginx
```
This configuration defines a ClusterIssuer that contacts Let’s Encrypt in order to issue certificates. You’ll need to replace your_email_address with your email address in order to receive possible urgent notices regarding the security and expiration of your certificates.

Save and close the file.

Roll it out with kubectl:
```sh
kubectl apply -f cluster_issuer.yaml
```

Now you’re going to create an Ingress Resource and use it to expose the Faveo helpdesk app deployments at your desired domains. You’ll then test it by accessing it from your browser.

You’ll store the Ingress in a file named ingress.yml. Create it using your editor. Add the following lines to your file:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
    annotations:
      kubernetes.io/ingress.class: nginx
      cert-manager.io/cluster-issuer: letsencrypt-prod
    name: faveo-ingress
    namespace: faveo

spec:
   tls:
   - hosts:
     - your_domain_name
     secretName: faveo-tls
   rules:
    - host: your_domain_name
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

Remember to replace the <mark>your_domain_name</mark> with your own domain. When you’ve finished editing, save and close the file.

Re-apply this configuration to your cluster by running the following command:
```sh
kubectl apply -f ingress.yaml
```
You’ll need to wait a few minutes for the Let’s Encrypt servers to issue a certificate for your domains. In the meantime, you can track its progress by inspecting the output of the following command:
```sh
kubectl get certificate
```
From the output of the above command the READY field must be True. Navigate to your domain in your browser to test. You’ll find the padlock to the left of the address bar in your browser, signifying that your connection is secure.

In this step, you have installed Cert-Manager using Helm and created a Let’s Encrypt ClusterIssuer. After, you updated your Ingress Resource to take advantage of the Issuer for generating TLS certificates. In the end, you have confirmed that HTTPS works correctly by navigating to your domain in your browser.