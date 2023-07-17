#!/bin/bash

# Define function to prompt for input with a default value
function prompt {
  read -p "$1 [$2]: " value
  echo "${value:-$2}"
}

# Prompt for deployment name
deployment_name=$(prompt "Enter deployment name" "nginx-deployment")

# Prompt for app label value
app_label=$(prompt "Enter app label value" "web")

# Prompt for number of replicas
replicas=$(prompt "Enter number of replicas" "5")

# Prompt for container name
container_name=$(prompt "Enter container name" "nginx")

# Prompt for container image
container_image=$(prompt "Enter container image" "nginx")

# Prompt for container port
container_port=$(prompt "Enter container port" "80")

# Prompt for persistent volume claim name
pvc_name=$(prompt "Enter persistent volume claim name" "my-pv-claim")

# Prompt for volume mount path
volume_mount_path=$(prompt "Enter volume mount path" "/usr/share/nginx/html")

# Check if dynamic volume provisioner and storage class are being used
if [[ $(kubectl get storageclass | grep -c 'dynamic-volume-provisioner') -gt 0 ]]
then
  storage_class=$(prompt "Enter storage class name" "dynamic-volume-provisioner")
  volume_line="        —name: my-pv-storage\n          persistentVolumeClaim:\n            claimName: $pvc_name\n            storageClassName: $storage_class"
else
  volume_line="        —name: my-pv-storage\n          persistentVolumeClaim:\n            claimName: $pvc_name"
fi

# Prompt for resource limits and requests
cpu_limit=$(prompt "Enter CPU limit (e.g. 100m)" "100m")
memory_limit=$(prompt "Enter memory limit (e.g. 200Mi)" "200Mi")
cpu_request=$(prompt "Enter CPU request (e.g. 100m)" "100m")
memory_request=$(prompt "Enter memory request (e.g. 200Mi)" "200Mi")

# Construct deployment YAML
deployment_yaml="apiVersion: apps/v1
kind: Deployment
metadata:
  name: $deployment_name
  labels:
    app: $app_label
spec:
  selector:
    matchLabels:
      app: $app_label
  replicas: $replicas
  strategy:
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: $app_label
    spec:
      volumes:
$volume_line
      containers:
        —name: $container_name
          image: $container_image
          resources:
            limits:
              memory: $memory_limit
              cpu: $cpu_limit
            requests:
              memory: $memory_request
              cpu: $cpu_request
          ports:
            —containerPort: $container_port
          livenessProbe:
            httpGet:
              path: /
              port: $container_port
            initialDelaySeconds: 5
            periodSeconds: 5"

# Remove empty lines
deployment_yaml=$(echo "$deployment_yaml" | sed '/^[[:space:]]*$/d')

# Print deployment YAML
echo "$deployment_yaml" > "$deployment_name.yaml"
echo "Deployment file created: $deployment_name.yaml"