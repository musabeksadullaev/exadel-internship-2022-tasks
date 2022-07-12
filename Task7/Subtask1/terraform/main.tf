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
resource "aws_vpc" "task_5_core_vpc" {
  cidr_block      = "10.0.30.0/24"
  enable_dns_hostnames  = true

  tags = {
    Name          = "Task-5-core-VPC"
    Payer         = "exadel-tasks"
  }
}


# - Subnet --------------------------------------
resource "aws_subnet" "task_5_core_vpc_subnet_main" {
  vpc_id          = aws_vpc.task_5_core_vpc.id
  cidr_block      = "10.0.30.0/24"

  tags = {
    Name          = "Task-5-core-VPC-Subnet-Main"
    Payer         = "exadel-tasks"
  }
}


# - Elastic IP ----------------------------------
resource "aws_eip" "task_5_core_vm_1_eip_1" {
  instance        = aws_instance.task_5_core_vm_1.id
  vpc             = true

  tags = {
    Name          = "task-5-core-vm-1"
    Payer         = "exadel-tasks"
  }
}

resource "aws_eip" "task_5_core_vm_2_eip_1" {
  instance        = aws_instance.task_5_core_vm_2.id
  vpc             = true

  tags = {
    Name          = "task-5-core-vm-2"
    Payer         = "exadel-tasks"
  }
}

resource "aws_eip" "task_5_core_vm_3_eip_1" {
  instance        = aws_instance.task_5_core_vm_3.id
  vpc             = true

  tags = {
    Name          = "task-5-core-vm-3"
    Payer         = "exadel-tasks"
  }
}


# - Route table ---------------------------------
resource "aws_route_table" "task_5_core_route_table_1" {
  vpc_id          = aws_vpc.task_5_core_vpc.id

  route {
    cidr_block    = "0.0.0.0/0"
    gateway_id    = aws_internet_gateway.task_5_core_igw_1.id
  }

  tags = {
    Name          = "task-5-core-route-table-1"
    Payer         = "exadel-tasks"
  }
}


# - Main route table ---------------------------------
resource "aws_main_route_table_association" "task_5_core_vpc_main_route_table" {
  vpc_id          = aws_vpc.task_5_core_vpc.id
  route_table_id  = aws_route_table.task_5_core_route_table_1.id
}


# - Internet gateway ----------------------------
resource "aws_internet_gateway" "task_5_core_igw_1" {
  vpc_id          = aws_vpc.task_5_core_vpc.id

  tags = {
    Name          = "task-5-core-vm-1"
    Payer         = "exadel-tasks"
  }
}


# - Security group --------------------------------
resource "aws_security_group" "task_5_core_vpc_sg_vm_1" {
  name            = "task_5_core_vpc_sg_vm_1"
  description     = "SG for VM 1 (Core)"
  vpc_id          = aws_vpc.task_5_core_vpc.id

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
    from_port     = 10050
    to_port       = 10050
    protocol      = "tcp"

    cidr_blocks   = ["0.0.0.0/0"]
  }

  ingress {
    from_port     = 10051
    to_port       = 10051
    protocol      = "tcp"

    cidr_blocks   = ["0.0.0.0/0"]
  }

  ingress {
    from_port     = -1
    to_port       = -1
    protocol      = "icmp"

    cidr_blocks   = ["0.0.0.0/0"]
  }

  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"  # All
    cidr_blocks   = ["0.0.0.0/0"]
  }

  tags = {
    Name          = "task-5-core-vm-1"
    Payer         = "exadel-tasks"

  }
}

resource "aws_security_group" "task_5_core_vpc_sg_vm_2" {
  name            = "task_5_core_vpc_sg_vm_2"
  description     = "SG for VM 2"
  vpc_id          = aws_vpc.task_5_core_vpc.id

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
    from_port     = 10050
    to_port       = 10050
    protocol      = "tcp"

    cidr_blocks   = ["0.0.0.0/0"]
  }

  ingress {
    from_port     = 10051
    to_port       = 10051
    protocol      = "tcp"

    cidr_blocks   = ["0.0.0.0/0"]
  }

  ingress {
    from_port     = -1
    to_port       = -1
    protocol      = "icmp"

    cidr_blocks   = ["0.0.0.0/0"]
  }

  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"  # All
    cidr_blocks   = ["0.0.0.0/0"]
  }

  tags = {
    Name          = "task-5-core-vm-2"
    Payer         = "exadel-tasks"

  }
}

resource "aws_security_group" "task_5_core_vpc_sg_vm_3" {
  name            = "task_5_core_vpc_sg_vm_3"
  description     = "SG for VM 3"
  vpc_id          = aws_vpc.task_5_core_vpc.id

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
    from_port     = 10050
    to_port       = 10050
    protocol      = "tcp"

    cidr_blocks   = ["0.0.0.0/0"]
  }

  ingress {
    from_port     = 10051
    to_port       = 10051
    protocol      = "tcp"

    cidr_blocks   = ["0.0.0.0/0"]
  }

  ingress {
    from_port     = -1
    to_port       = -1
    protocol      = "icmp"

    cidr_blocks   = ["0.0.0.0/0"]
  }

  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"  # All
    cidr_blocks   = ["0.0.0.0/0"]
  }

  tags = {
    Name          = "task-5-core-vm-3"
    Payer         = "exadel-tasks"

  }
}


# - EC2 instance --------------------------------
resource "aws_instance" "task_5_core_vm_1" {
  # OS info
  ami                           = "ami-052efd3df9dad4825"
  instance_type                 = "t2.micro"

  # Access management
  key_name                      = "exadel-tasks-key-main"

  # Networking
  associate_public_ip_address   = false
  subnet_id                     = aws_subnet.task_5_core_vpc_subnet_main.id

  # Firewall
  vpc_security_group_ids        = [aws_security_group.task_5_core_vpc_sg_vm_1.id]

  # Main disk drive
  root_block_device {
    delete_on_termination       = true
    volume_size                 = 8
  }

  user_data                     = var.task_5_core_vm_1_user_data

  # Tags
  tags = {
    Name                        = "task-5-core-vm-1"
    Payer                       = "exadel-tasks"
  }
}

resource "aws_instance" "task_5_core_vm_2" {
  # OS info
  ami                           = "ami-052efd3df9dad4825"
  instance_type                 = "t2.micro"

  # Access management
  key_name                      = "exadel-tasks-key-main"

  # Networking
  associate_public_ip_address   = false
  subnet_id                     = aws_subnet.task_5_core_vpc_subnet_main.id

  # Firewall
  vpc_security_group_ids        = [aws_security_group.task_5_core_vpc_sg_vm_2.id]

  # Main disk drive
  root_block_device {
    delete_on_termination       = true
    volume_size                 = 8
  }

  # Tags
  tags = {
    Name                        = "task-5-core-vm-2"
    Payer                       = "exadel-tasks"
  }
}

resource "aws_instance" "task_5_core_vm_3" {
  # OS info
  ami                           = "ami-052efd3df9dad4825"
  instance_type                 = "t2.micro"

  # Access management
  key_name                      = "exadel-tasks-key-main"

  # Networking
  associate_public_ip_address   = false
  subnet_id                     = aws_subnet.task_5_core_vpc_subnet_main.id

  # Firewall
  vpc_security_group_ids        = [aws_security_group.task_5_core_vpc_sg_vm_3.id]

  # Main disk drive
  root_block_device {
    delete_on_termination       = true
    volume_size                 = 8
  }

  # Tags
  tags = {
    Name                        = "task-5-core-vm-3"
    Payer                       = "exadel-tasks"
  }
}


# Output
output "ec2_global_ips" {
  value                         = [
    "${aws_eip.task_5_core_vm_1_eip_1.*.public_ip}",
    "${aws_eip.task_5_core_vm_2_eip_1.*.public_ip}",
    "${aws_eip.task_5_core_vm_3_eip_1.*.public_ip}",
  ]
}

output "ec2_local_ips" {
  value                         = [
    "${aws_eip.task_5_core_vm_1_eip_1.*.private_ip}",
    "${aws_eip.task_5_core_vm_2_eip_1.*.private_ip}",
    "${aws_eip.task_5_core_vm_3_eip_1.*.private_ip}",
  ]
}
