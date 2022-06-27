# - Providers -----------------------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

# - Provider settings ---------------------------
provider "aws" {
  region          = "us-east-1"
}

# - VPC -----------------------------------------
data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]  # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "centos" {
  most_recent = true
  owners = ["125523088429"]  # CentOS

  filter {
    name   = "name"
    values = ["CentOS 7.9.2009 x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# - VPC -----------------------------------------
resource "aws_vpc" "task_3_extra_vpc" {
  cidr_block      = "10.0.10.0/24"

  tags = {
    Name          = "Task-3-Extra-VPC"
    Payer         = "exadel-tasks"
  }
}


# - Subnet --------------------------------------
resource "aws_subnet" "task_3_extra_vpc_subnet_main" {
  vpc_id          = aws_vpc.task_3_extra_vpc.id
  cidr_block      = "10.0.10.0/24"

  tags = {
    Name          = "Task-3-Extra-VPC-Subnet-main"
    Payer         = "exadel-tasks"
  }
}


# - Elastic IP ----------------------------------
resource "aws_eip" "task_3_extra_vm_1_eip_1" {
  instance        = aws_instance.task_3_extra_vm_1.id
  vpc             = true

  tags = {
    Name          = "task-3-extra-vm-1"
    Payer         = "exadel-tasks"
  }
}


# - Route table ---------------------------------
resource "aws_route_table" "task_3_extra_route_table_1" {
  vpc_id          = aws_vpc.task_3_extra_vpc.id

  route {
    cidr_block    = "0.0.0.0/0"
    gateway_id    = aws_internet_gateway.task_3_extra_igw_1.id
  }

  tags = {
    Name          = "task-3-extra-route-table-1"
    Payer         = "exadel-tasks"
  }
}

# - Main route table ---------------------------------
resource "aws_main_route_table_association" "task_3_extra_vpc_main_route_table" {
  vpc_id          = aws_vpc.task_3_extra_vpc.id
  route_table_id  = aws_route_table.task_3_extra_route_table_1.id
}


# - Internet gateway ----------------------------
resource "aws_internet_gateway" "task_3_extra_igw_1" {
  vpc_id          = aws_vpc.task_3_extra_vpc.id

  tags = {
    Name          = "task-3-extra-vm-1"
    Payer         = "exadel-tasks"
  }
}


# - Security group --------------------------------
resource "aws_security_group" "task_3_extra_vpc_sg_vm_1" {
  name            = "task_3_extra_vpc_sg_vm_1"
  description     = "SG for VM 1 (Extra)"
  vpc_id          = aws_vpc.task_3_extra_vpc.id

  ingress {
    from_port     = 22
    to_port       = 22
    protocol      = "tcp"

    cidr_blocks   = ["0.0.0.0/0"]
  }

  ingress {
    from_port     = 80
    to_port       = 80
    protocol      = "tcp"

    cidr_blocks   = ["0.0.0.0/0"]
  }

  ingress {
    from_port     = 443
    to_port       = 443
    protocol      = "tcp"

    cidr_blocks   = ["0.0.0.0/0"]
  }

  ingress {
    from_port     = -1
    to_port       = -1
    protocol      = "icmp"

    cidr_blocks   = ["0.0.0.0/0"]
  }

  ingress {
    from_port     = 3128
    to_port       = 3128
    protocol      = "tcp"

    cidr_blocks   = [aws_subnet.task_3_extra_vpc_subnet_main.cidr_block]
  }

  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"  # All
    cidr_blocks   = ["0.0.0.0/0"]
  }

  tags = {
    Name          = "task-3-vm-1"
    Payer         = "exadel-tasks"

  }
}

resource "aws_security_group" "task_3_extra_vpc_sg_vm_2" {
  name            = "task_3_extra_vpc_sg_vm_2"
  description     = "SG for VM 2 (Extra)"
  vpc_id          = aws_vpc.task_3_extra_vpc.id

  ingress {
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"

    cidr_blocks       = ["${aws_instance.task_3_extra_vm_1.private_ip}/32"]
  }

  ingress {
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"

    cidr_blocks       = ["${aws_instance.task_3_extra_vm_1.private_ip}/32"]
  }

  ingress {
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"

    cidr_blocks       = ["${aws_instance.task_3_extra_vm_1.private_ip}/32"]
  }

  ingress {
    from_port         = -1
    to_port           = -1
    protocol          = "icmp"

    cidr_blocks       = ["${aws_instance.task_3_extra_vm_1.private_ip}/32"]
  }

  egress {
    from_port         = 0
    to_port           = 0
    protocol          = "-1"  # All
    cidr_blocks       = ["0.0.0.0/0"]
  }

  tags = {
    Name          = "task_3_extra_vpc_sg_vm_2"
  }
}


# - EC2 instance --------------------------------
resource "aws_instance" "task_3_extra_vm_1" {
  # OS info
  ami                           = data.aws_ami.ubuntu.id
  instance_type                 = "t2.micro"

  # Access management
  key_name                      = "exadel-tasks-key-main"

  # Networking
  associate_public_ip_address   = false
  subnet_id                     = aws_subnet.task_3_extra_vpc_subnet_main.id

  # Firewall
  vpc_security_group_ids        = [aws_security_group.task_3_extra_vpc_sg_vm_1.id]

  # Main disk drive
  root_block_device {
    delete_on_termination       = true
    volume_size                 = 8
  }


  # Script to run when creating EC2 instance
  user_data                     = var.task_3_extra_vm_1_user_data

  # Tags
  tags = {
    Name                        = "task-3-extra-vm-1"
    Payer                       = "exadel-tasks"
  }
}

resource "aws_instance" "task_3_extra_vm_2" {
  # OS info
  ami                           = data.aws_ami.centos.id
  instance_type                 = "t2.micro"

  # Access management
  key_name                      = "exadel-tasks-key-main"

  # Networking
  associate_public_ip_address   = false
  subnet_id                     = aws_subnet.task_3_extra_vpc_subnet_main.id

  # Firewall
  vpc_security_group_ids        = [aws_security_group.task_3_extra_vpc_sg_vm_2.id]

  # Main disk drive
  root_block_device {
    delete_on_termination       = true
    volume_size                 = 15
  }


  # Script to run when creating EC2 instance
  user_data                     = <<EOL
#!/bin/bash

# Stop script when some step is failed
set -e

# Output of info file
SYSTEM_INFO_FILE_LOCATION="/usr/share/nginx/html/info.html"


# Disable IPv6
sudo bash -c 'echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf'
sudo bash -c 'echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf'
sudo sysctl -p


# Add proxy
sudo bash -c 'echo "proxy=http://${ aws_instance.task_3_extra_vm_1.private_ip }:3128" >> /etc/yum.conf'


# Update package index
sudo yum -y update


# Upgrade all installed packages
sudo yum -y upgrade


# Install EPEL packages repository
sudo yum -y install epel-release


# Install nginx web-server
sudo yum -y install nginx


# Start and enable nginx
sudo systemctl enable nginx
sudo systemctl start nginx


# Generate page with "Hello World" text
# Empty info file
echo "" > $SYSTEM_INFO_FILE_LOCATION

# Fill contents
cat << EOF >> $SYSTEM_INFO_FILE_LOCATION
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
        crossorigin="anonymous"
    >
    <title>Hello World</title>
</head>
<body>
    <div class="container">

        <div class="row">
            <div class="col">
                <h1 class="text-center mt-3">Hello World</h1>
            </div>
        </div>

    </div>

</body>

EOF

EOL

  # Tags
  tags = {
    Name                        = "task-3-extra-vm-2"
    Payer                       = "exadel-tasks"
  }
}


output "ec2_global_ips" {
  value                         = ["${aws_eip.task_3_extra_vm_1_eip_1.*.public_ip}"]
}

output "ec2_local_ips" {
  value                         = ["${aws_eip.task_3_extra_vm_1_eip_1.*.private_ip}"]
}
