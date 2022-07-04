# Task 5 - Ansible

## :link: [Important points](./IMPORTANT_POINTS.MD)

## Tasks:

### 1. Deploy three virtual machines in the Cloud. Install Ansible on one of them (control_plane)

Created three EC2 instances in AWS with Terraform.

You can find out files in [here](./terraform)

To apply them run `terraform plan` and `terraform apply` in folder that `main.tf` file placed

### 2. Ping pong - execute the built-in ansible ping command. Ping the other two machines
Log-in with SSH to first server created in previous step (Master plane)

Create working dir in home directory: `mkdir -p ~/tasks/5/`

`cd` to created folder: `cd ~/tasks/5/`

Copy private key file to `./ssh.key`

Add read/write permission only for owner of file, deny other users to read/write: `chmod 600 ./ssh.key`

Create file named `./hosts.ini` in folder created in previous step with next content:
``` ini
[targets]
x.x.x.x
x.x.x.x

[targets:vars]
ansible_connection              = ssh
ansible_user                    = ubuntu
ansible_ssh_private_key_file    = ~/tasks/ssh.key
```

Run next command (if master plane VM is connecting to other VMs first time, type `yes` and press `Enter` when asked):
``` bash
ansible -i hosts.ini targets -m ping
```

You can find out files in [here](./ansible/Task2.md)


### 3. My First Playbook: write a playbook for installing Docker on two machines and run it.

You can find out files in [here](./ansible/Task3.md)

To apply them run `terraform plan` and `terraform apply` in folder that `main.tf` file placed

<!-- 
## Extra tasks

## Extra - 1: Write a playbook for installing Docker and one of the (LAMP/LEMP stack, **Wordpress**, ELK, MEAN - GALAXY do not use) in Docker.

You can find out ansible files in [here](./ansible)
 -->
