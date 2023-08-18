#!/bin/bash

# Call install_ansible.sh script to install Ansible
#./install_ansible.sh

# Group names
groups=("master" "worker" "loadbalancer" "rancher" "nfs_server" "nfs_client")

# Function to check if the hosts.ini file exists
hosts_ini_exists() {
  [ -e hosts.ini ]
}

# Check if the hosts.ini file exists
if hosts_ini_exists; then
  echo "The hosts.ini file already exists. It will be replaced."
  rm hosts.ini
fi

# Loop through the groups and get the details for each group
for group in "${groups[@]}"; do
  echo -n "Enter the number of $group hosts (or leave empty to skip): "
  read num_hosts

  if [ -z "$num_hosts" ]; then
    echo "Skipping $group group."
    continue
  fi

  echo "[$group]" >> hosts.ini

  # Loop to get the details for each host in the group
  for i in $(seq 1 $num_hosts); do
    echo -n "Enter the hostname of $group host $i: "
    read hostname
    echo -n "Enter the IP address of $group host $i: "
    read ip
    echo -n "Enter the username for $group host $i: "
    read user
    echo -n "Enter the path to the private key for $group host $i: "
    read private_key
    echo "$hostname ansible_host=$ip ansible_user=$user ansible_ssh_private_key=$private_key" >> hosts.ini
  done

  echo # Add a new line between groups
done

# Move the hosts.ini file to the ansible directory
echo "The hosts.ini file has been created inside the ansible folder."
cp hosts.ini ../ansible/