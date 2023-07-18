#!/bin/bash

# Create vault namespace
echo "Creating vault namespace..."
kubectl create namespace vault
echo "vault namespace created."

# List all namespaces to verify that vault was created
echo "Listing all namespaces..."
kubectl get ns
echo "Namespace list displayed."

# Add Vault Helm repository
echo "Adding Vault Helm repository..."
helm repo add hashicorp https://helm.releases.hashicorp.com 
echo "Vault Helm repository added."

# List all Helm repositories to verify that Vault was added
echo "Listing all Helm repositories..."
helm repo list
echo "Helm repository list displayed."

# Install Vault using Helm
echo "Installing Vault using Helm..."
helm install vault hashicorp/vault --namespace vault -f vault-values.yaml 
echo "Vault installed using Helm."

# List all installed Helm releases in Vault namespace
echo "Listing installed Helm releases in Vault namespace..."
helm list -n vault
echo "Installed Helm releases displayed."

# Get the service information for Vault server
echo "Getting the service information for Vault server..."
kubectl get svc -n vault
echo "Service information displayed."

