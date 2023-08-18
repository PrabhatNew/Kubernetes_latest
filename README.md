# Kubernetes Cluster Setup with HAProxy and Rancher

This repository contains Ansible playbooks and Bash scripts to set up a Kubernetes cluster with HAProxy and Rancher on Ubuntu 22.04. The playbook automates the installation process and allows users to quickly set up a Kubernetes cluster.

## Table of Contents
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Examples](#examples)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## Requirements
- Ubuntu 22.04
- Ansible 2.9+
- The ansible control node (where you'll run the Ansible commands) must be able to SSH to all the nodes without a password. This can be done by generating SSH keys and copying the public key to all the nodes.

## Installation
1. Clone the repository to your Ansible controller (local machine) and to all the nodes in the cluster using the following command:
   `````sh
   sudo git clone https://github.com/PrabhatNew/Kubernetes_latest.git
   

2. Navigate to the repository directory:
   ````sh 
   cd Kubernetes_latest
   

3. Make the Bash scripts executable using the following command:
   ````sh
   sudo chmod +x -R bash_files
   ````
   ````sh
   cd bash_files
   ````

4. Run the `on_all_k8s_nodes.sh` script on all the nodes in your cluster to gather information about each individual node:
   ````sh
   bash on_all_k8s_nodes.sh
   

5. Execute the `hosts.ini.sh` script on your Ansible control node and enter the data gathered from the `on_all_k8s_nodes.sh` command to create the `hosts.ini` file:
   ````sh
   sudo bash hosts.ini.sh
   

6. Verify that the `hosts.ini` file was created and contains the correct information:
   ````sh
   cat /Kubernetes_latest/ansible/hosts.ini
   

7. Copy the SSH public key from the Ansible control node to all other nodes in the cluster using the `ssh-copy-id` command:
   ````sh
   ssh-copy-id server1@192.168.101.109
   ssh-copy-id server2@192.168.101.110
   ssh-copy-id server3@192.168.101.111
   ````

   Alternatively, you can use the `ssh-copy-id_automated.sh` script to automate this process:
   ````sh
   cd Kubernetes_latest/bash_files
   bash ssh-copy-id_automated.sh
   ````

## Usage
To use the scripts in this repository, follow these steps:

1. Test the Ansible connection to all hosts using the following command:
   ````sh
   cd /Kubernetes_latest/ansible
   ansible all -m ping -i hosts.ini 
   

   **Note:** Do not run the `mainplaybook.yml` if the connection to all hosts has not passed. Instead, run the playbooks individually.

2. You should modify the values of the 12_vars.yml file inside the /ansible/playbooks directory for the version of kubernetes you want to install, the value of floating_ip of loadbalancer, NFS_SERVER ip, NFS path.

3. To execute all playbooks at once, run the following command:
   ````sh
   ansible-playbook -i hosts.ini mainplaybook.yml 
   

4. To execute playbooks individually, run the following commands:
   - Edit the variables file according to your environment and configuration:
     ```sh
     sudo nano playbooks/12_vars.yml
     ```
   - To install  HAProxy, Keepalived:
     ```sh
     ansible-playbook -i hosts.ini playbooks/01_install_haproxy_keepalived.yml
     ```
   - To Configure HAProxy, Keepalived:
     ```sh
     ansible-playbook -i hosts.ini playbooks/02_configure_loadbalancer.yml
     ```
   - To install Kubernetes:
     ```sh
     ansible-playbook -i hosts.ini playbooks/03_install_kubernetes.yml 
     ```
   - To initialize Kubernetes on the first master host:
     ```sh
     ansible-playbook -i hosts.ini playbooks/04_init_kubernetes.yml
     ```
   - To join the worker nodes to the Kubernetes cluster:
     ```sh
     ansible-playbook -i hosts.ini playbooks/05_join_worker.yml 
     ```
   - To join the master nodes to the Kubernetes cluster:
     ```sh
     ansible-playbook -i hosts.ini playbooks/06_join_master.yml 
     ```
   - To install nginx ingress controller and helm to the Kubernetes cluster:
     ```sh
     ansible-playbook -i hosts.ini playbooks/07_install_helm_ing_controller.yml 
     ```
   - To update haproxy_conf file with ingress controller ports:
     ```sh
     ansible-playbook -i hosts.ini playbooks/08_update_HA_conf.yml 
     ```
   - To install NFS_SERVER:
     ```sh
     ansible-playbook -i hosts.ini playbooks/09_nfs_server.yml 
     ```
   - To install NFS_CLIENT:
     ```sh
     ansible-playbook -i hosts.ini playbooks/10_nfs_client.yml 
     ```
   - To install Rancher:
     ```sh
     ansible-playbook -i hosts.ini playbooks/11_rancher_setup_updated.yml 
     ```
4. To reset the cluster run this command:
     ```sh
     ansible-playbook -i hosts.ini playbooks/13_reset_cluster.yml 
     ```
## Troubleshooting
If you encounter any issues when using the playbook, try the following steps:

- Verify that the `hosts.ini` file contains the correct information.
- Check that the SSH connection to all hosts is successful using the `ansible all -m ping -i hosts.ini` command.
- Check the status of the Kubernetes cluster using the `kubectl get nodes` command.
- Read the error messages and search for solutions online.

If you are unable to resolve the issue, please contact the project owner for assistance.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.