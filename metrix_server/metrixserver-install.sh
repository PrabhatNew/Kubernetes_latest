#!/bin/bash

# Deploy the manifest file for Metrix server
echo "Deploying the manifest file for Metrix server..."
METRIX_YAML="metrixserver.yaml"
kubectl apply -f $METRIX_YAML
echo "Manifest file for Metrix server deployed"