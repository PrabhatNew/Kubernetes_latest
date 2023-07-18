#!/bin/bash

NAMESPACE="redis"
RELEASE_NAME="my-redis"
REPO_NAME="bitnami"
CHART_NAME="redis"

# Create Redis namespace
kubectl create namespace $NAMESPACE

# Add Bitnami Helm repository
helm repo add $REPO_NAME https://charts.$REPO_NAME.com/$REPO_NAME

# Install Redis using Helm
helm install $RELEASE_NAME $REPO_NAME/$CHART_NAME --namespace $NAMESPACE -f redis-values.yaml