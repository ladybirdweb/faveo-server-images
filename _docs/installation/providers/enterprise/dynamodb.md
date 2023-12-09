---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/dynamodb/
redirect_from:
  - /theme-setup/
last_modified_at: 2023-12-09
last_modified_by: Mohammad_Asif
toc: true
title: Installing DynamoDB for Faveo.
---
<img alt="DynamoDB" src="https://insightsoftware.com/wp-content/uploads/2022/12/DynamoDB-ODBC-Driver.png" width="200"  />

## Introduction:
Amazon DynamoDB is a fast and flexible NoSQL database service for all applications that require consistent single-digit millisecond latency at any scale. It is a fully managed database that supports both document and key-value data models. 


---

## DynamoDB Local:
DynamoDB Local is a downloadable version of DynamoDB that lets you write and test applications without accessing the DynamoDB web service, instead, it is self-contained on your Server.

DynamoDB Local makes use of Java so if you don't have Java installed on your machine you will need to install Java on your server.

For Debian and Derivatives

```
apt install openjdk-19-jre-headless
```

For RedHat and Derivatives

```
sudo yum install java
```
## Install DynamoDB Local

Create a hidden folder in your home directory.

```
mkdir ./dynamolocal
```

Change into the new created directory.

```
cd ./dynamolocal
```

Download the DynamoDB tar file.

```
wget http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.tar.gz
```

Once the file is download you uncompress it.

```
tar xzf dynamodb_local_latest.tar.gz
```

We are now already to use DynamoDb locally, start DynamoDB with the below command.

```
java -Djava.library.path=./DynamoDBLocal_lib/ -jar DynamoDBLocal.jar
```

Which will respond with the below Output.

```
Initializing DynamoDB Local with the following configuration:
Port:  8000
InMemory:  false
DbPath:  null
SharedDb:  false
shouldDelayTransientStatuses:  false
CorsParams:  *
```

## Create terminal shortcut for DynamoDB

Open your Bash Profile using nano

```
nano ~/.bashrc
```

Then add the following function to your bashrc content.

```
function dynamo(){
 cd $HOME/dynamolocal
 java -Djava.library.path=./DynamoDBLocal_lib/ -jar DynamoDBLocal.jar
}
```

Save and exit from the file then refresh your terminal window

```
source  ~/.bashrc
or
. ~/.bashrc
```

Now you can start the your DynamoDB local instance in the terminal window by simply

```
dynamo
```








