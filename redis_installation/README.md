# Setting up and Deploying Redis Server

This guide will walk you through the steps necessary to set up and deploy a Redis server using Helm.

## Prerequisites

Before you begin, you will need:

- A Kubernetes cluster with kubectl configured
- Administrative access to the cluster
- Helm 3 installed on your local machine

## Installation

1. Clone this repository to your local machine:

```bash
git clone https://github.com/PrabhatNew/Kubernetes_latest.git
```

2. Change into the chart's directory:

```bash
cd Kubernetes_latest
```

3. Change the file permession:

```bash
sudo chmod -R 777 redis_installation
```
4. Run the script:
```bash
cd redis_installation
```
```bash
bash install_redis.sh
```

## Conclusion

Congratulations! You have successfully installed and deployed a Redis server using Helm. You can now use Redis to cache and store your data. 


