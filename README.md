# Yandex Cloud Infrastructure with Terraform & Ansible

This project demonstrates the deployment and configuration of virtual machines in Yandex Cloud using Infrastructure as Code (IaC) principles. Terraform is used to provision the infrastructure, and Ansible is used for configuration management.

The setup creates three Debian VMs:
* `vm-1`: Acts as an Nginx reverse proxy.
* `vm-2` & `vm-3`: Act as web servers, serving a simple page.

## Technology Stack 🛠️

[![Terraform](https://img.shields.io/badge/-Terraform-464646?style=flat&logo=terraform&logoColor=white&color=7B42BC)](https://www.terraform.io/)
[![Ansible](https://img.shields.io/badge/-Ansible-464646?style=flat&logo=ansible&logoColor=white&color=EE0000)](https://www.ansible.com/)
[![Nginx](https://img.shields.io/badge/-Nginx-464646?style=flat&logo=nginx&logoColor=white&color=009639)](https://www.nginx.com/)
[![Yandex Cloud](https://img.shields.io/badge/-Yandex%20Cloud-464646?style=flat&logo=yandex&logoColor=white&color=FF0000)](https://cloud.yandex.com/)

## Project Structure
```
.
├── ansible/                  # Ansible configuration files
│   ├── default_y_packages/   # Ansible roles
│   ├── nginx_proxy/
│   ├── nginx_send/           
│   ├── inventory.yaml        # Defines hosts and variables
│   └── playbook.yaml         # Main playbook
└── terraform/                # Terraform configuration files
    └──terraform.tfvars       # Main infrastructure definition
```

## How to Deploy

### Prerequisites

1. [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) and [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installed.
2. Yandex Cloud account and the `yc` CLI configured.
3. An SSH key for accessing the VMs.

### Step-by-Step Guide

1.  **Clone the Repository**
    ```bash
    git clone [https://github.com/wabisabicode/y_cloud.git](https://github.com/wabisabicode/y_cloud.git)
    cd y_cloud
    ```

2.  **Generate SSH Key**
    Create a specific SSH key for this project. This is the key Ansible will use.
    ```bash
    ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_terraform
    ```

3.  **Create profile for yc provider**
    We assume that you've installed the provider `yc` as recommended by Yandex Cloud.
    ```bash
    yc config profile create <Custom profile name>
    yc config set service-account-key key.json
    yc config set cloud-id <Cloud ID>
    yc config set folder-id <Catalog ID>
    
    export YC_TOKEN=$(yc iam create-token)
    export YC_CLOUD_ID=$(yc config get cloud-id)
    export YC_FOLDER_ID=$(yc config get folder-id)
    ```

3.  **Deploy Infrastructure with Terraform**
    Navigate to the terraform directory and initialize it.
    ```bash
    cd terraform
    terraform init
    ```

    Now, apply the configuration. Terraform will create the three VMs and output their public IP addresses.
    ```bash
    terraform apply
    ```

4.  **Configure with Ansible**
    Once Terraform provides the IP addresses, update `ansible/inventory.yaml` with them.
    ```yaml
    # ansible/inventory.yaml
    ...
      pnginx:
        hosts:
          vm1:
            ansible_host: <IP_ADDRESS_OF_VM1>
      snginx:
        hosts:
          vm2:
            ansible_host: <IP_ADDRESS_OF_VM2>
          vm3:
            ansible_host: <IP_ADDRESS_OF_VM3>
    ...
    ```
    Run the Ansible playbook to configure all machines.
    ```bash
    ansible-playbook -i ansible/inventory.yaml ansible/playbook.yml
    ```

## Result

After the playbook finishes, you can access the Nginx proxy by navigating to `http://<IP_ADDRESS_OF_VM1>:3000` in your browser. The proxy will load balance requests between `vm-2` and `vm-3`, and you will see a message "Hello from vm2!" or "Hello from vm3!".
