---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/k8s-paid-ssl
redirect_from:
  - /theme-setup/
last_modified_at: 2024-08-27
toc: true
title: Install Paid SSL for Faveo on K8s
---


<img alt="Ubuntu" src="https://raw.githubusercontent.com/kubernetes/kubernetes/7436ca32bc766ff202109a7541d2e7bb41ee7d13/logo/logo.svg" width="120" height="120" />

# Setting Up a Paid SSL Certificate in Kubernetes

To install a paid SSL certificate in your Kubernetes cluster, follow these steps to set up the certificate, create Kubernetes Secrets and ConfigMaps, and configure the NGINX Ingress resource.

## Step 1: Obtain SSL Certificate and CA Certificate

1. **Obtain your SSL certificate** (`your_domain.crt`) and private key (`your_domain.key`) from your SSL certificate provider.

2. **Obtain the CA certificate** (`your_domain-CA.crt`) from your SSL provider, if applicable.

## Step 2: Create Kubernetes Secrets

### 1. Create a Secret for the SSL Certificate

Use the following command to create a Kubernetes Secret that holds your SSL certificate and private key:

```bash
kubectl create secret tls faveo-tls \
  --cert=path/to/your_domain.crt \
  --key=path/to/your_domain.key \
  -n faveo
```


#### 2. Create a ConfigMap for the CA Certificate:

```
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

```
kubectl apply -f ca-configmap.yaml
```

### Step 3: Configure the NGINX Ingress Resource

Update your Ingress resource to use the SSL certificate and configure it to verify upstream SSL connections using the CA certificate:

```
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

```
kubectl apply -f ingress.yaml
```

### Step 4: Update Deployment Configuration

Ensure the CA certificate is included in your deployment configuration:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: faveo-svc
  namespace: faveo
spec:
  type: ClusterIP
  ports:
  - port: 80
    targetPort: 80
  selector:
    app: faveo-pods
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: faveo-deploy
  namespace: faveo
spec:
  replicas: 1
  selector:
    matchLabels:
      app: faveo-pods
  template:
    metadata:
      labels:
        app: faveo-pods
    spec:
      containers:
      - name: faveo-apache
        image: ladybird/faveo-k8s-apache2
        resources:
          limits:
            memory: 700Mi
            cpu: 1
          requests:
            memory: 600Mi
            cpu: 800m
        livenessProbe:
          httpGet:
            path: /probe.php
            port: 80
          initialDelaySeconds: 5
          timeoutSeconds: 5
          periodSeconds: 10
          failureThreshold: 1
        readinessProbe:
          httpGet:
            path: /probe.php
            port: 80
          initialDelaySeconds: 5
          timeoutSeconds: 5
          periodSeconds: 10
          failureThreshold: 1
        volumeMounts:
        - name: volume-data
          mountPath: /var/www/html
#        - name: cm
#          mountPath: /var/www/html/.env
#          subPath: .env
        - name: ca-certificates
          mountPath: /usr/local/share/ca-certificates/faveorootCA.crt
          subPath: faveorootCA.crt
      initContainers:
      - name: fetch
        image: ladybird/faveo-fetcher
        command: ['sh','-c','apt update;apt install git -y; curl https://billing.faveohelpdesk.com/download/faveo\?order_number\=order-no\&serial_key\=license-key --output faveo.zip; unzip faveo.zip -d html;chown -R www-data:www-data /html']
        volumeMounts:
        - name: volume-data
          mountPath: /html
      volumes:
      - name: volume-data
        emptyDir: {}
#      - name: cm-
#        configMap:
#          name: faveo-env
      - name: ca-certificates
        configMap:
          name: faveo-ca-certificates
```

Apply the changes to your Kubernetes cluster:

```
kubectl apply -f deploy-faveo.yaml
```

Access Your Domain

Visit https://your_domain_name to confirm that the SSL certificate is correctly applied and the connection is secure.