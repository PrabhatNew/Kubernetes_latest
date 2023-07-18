# Setting up and Deploying Vault Server

This guide will walk you through the steps necessary to set up and deploy a Vault server using Helm.

## Prerequisites

Before you begin, you will need:

- A Kubernetes cluster with kubectl configured
- Administrative access to the cluster
- Helm 3 installed on your local machine

## Installation
## Installing the Chart

To install the chart, follow these steps:

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
sudo chmod -R 777 hasicorp_vault
```
4. Run the script:
```bash
cd hasicorp_vault
```
```bash
bash install_hasicorp_vault.sh
```

## Initializing and Unsealing Vault

After the installation, you need to initialize and unseal Vault to start using it.

1. Initialize Vault using: `vault operator init`
   This will give you a set of keys that you need to keep safe.
2. Unseal Vault using: `vault operator unseal` and provide one of the keys obtained in the previous step.
   You need to run this step three times for Vault to unseal completely.

## Conclusion

Congratulations! You have successfully installed and deployed a Vault server using Helm. You can now use Vault to manage your secrets and sensitive data.