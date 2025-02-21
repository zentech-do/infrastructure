# 📘 Project Documentation

## 🔰 Introduction

This document provides a detailed guide on setting up the environment, running the source code, and verifying the deployment results.

## 📂 Directory Structure Overview

The project is organized into three main directories:

| Directory   | Description                                                                                                                    |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------ |
| **Ansible** | Contains configuration files for setting up infrastructure using Ansible, including roles, inventory, and playbooks.           |
| **Config**  | Holds Terraform configuration files for deploying services like Docker, Jenkins, and SonarQube.                                |
| **Modules** | Includes reusable Terraform modules for managing AWS infrastructure components such as EC2, VPC, subnets, and security groups. |

### 1️⃣ Ansible

- `ansible.cfg`: Configuration file for Ansible execution.
- `inventory/`: Defines the AWS EC2 inventory for Ansible.
- `group_vars/`: Stores environment-specific variables for Docker, Jenkins, and SonarQube.
- `roles/`: Includes role-specific tasks, handlers, and defaults for setting up services.
- `site.yml`: The main playbook that executes all roles.

### 2️⃣ Config

Each service has its own folder (`Docker/`, `Jenkins/`, `Sonarqube/`) containing:

- `main.tf`: Defines resources for deployment.
- `backend.tf`: Configures remote state storage.
- `variables.tf`: Defines input variables.
- `terraform.tfvars`: Stores variable values.
- `outputs.tf`: Defines output values.

### 3️⃣ Modules

- `ec2/`: Manages EC2 instances.
- `routables/`: Defines routing tables.
- `security-groups/`: Configures security groups.
- `subnets/`: Manages subnet configurations.
- `vpc/`: Defines the AWS VPC structure.

## 🛠 Environment Setup

Ensure you have the necessary tools installed before proceeding:

- 📌 [Install Terraform (>=1.7.2)](https://developer.hashicorp.com/terraform/downloads)
- 📌 [Install Ansible (>=2.14)](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- 📌 [Install AWS CLI (>=2.13)](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- 📌 [Install Python (>=3.8)](https://www.python.org/downloads/)

To verify installations, run:

```sh
# Check Terraform version
terraform -version

# Check Ansible version
ansible --version

# Check AWS CLI version
aws --version

# Check Python version
python --version
```

### Install Required Python Libraries

```sh
pip install boto3 ansible boto
```

## 🚀 Running the Source Code

### Navigate to the Desired Service Directory

```sh
cd config/Docker   # or cd config/Jenkins or cd config/Sonarqube
```

### Initialize Terraform

```sh
terraform init
```

### Plan the Deployment

```sh
terraform plan
```

### Apply the Configuration

```sh
terraform apply -auto-approve
```
## 🎯 Conclusion

By following this guide, you can successfully set up the environment, run the source code, and verify the deployment results efficiently.

🚀 **This guide ensures a smooth and automated deployment process with Terraform and Ansible!**

