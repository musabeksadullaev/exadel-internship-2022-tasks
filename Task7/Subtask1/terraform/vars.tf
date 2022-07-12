variable "task_5_core_vm_1_user_data" {
  type = string
  description = "Script to run when EC2 instance is launching"
  default = <<EOL
#!/bin/bash

# Stop script when some step is failed
set -e


# Update package index
sudo apt-get -y update

# Upgrade all installed packages
sudo apt-get -y upgrade

# Install ansible
sudo apt-get -y install ansible

EOL

}
