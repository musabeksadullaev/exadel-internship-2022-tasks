# variable "VM_1_AMI_ID" {
#   type = string
# }

# variable "VM_2_AMI_ID" {
#   type = string
# }

variable "task_3_extra_vm_1_user_data" {
  type = string
  description = "Script to run when EC2 instance is launching"
  default = <<EOL
#!/bin/bash

# Stop script when some step is failed
set -e

# Output of info file
SYSTEM_INFO_FILE_LOCATION="/var/www/html/info.html"

# Update package index
sudo apt-get -y update

# Upgrade all installed packages
sudo apt-get -y upgrade

# Install nginx web-server
sudo apt-get -y install nginx

# Start and enable nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Generate page with "Hello World" text and system information
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
    <title>System info file</title>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col">
                <h1 class="text-center mt-3">Hello World</h1>
            </div>
        </div>

        <div class="row">
            <div class="col">
                <hr />
            </div>
        </div>

        <div class="row">
            <div class="col">
                <h3 class="mb-2 mt-4">OS version (Output of <code>cat /etc/os-release</code>):</h3>
                <pre>
$(sudo bash -c "echo -en '$(cat /etc/os-release)\n'")
                </pre>
            </div>
        </div>

        <div class="row">
            <div class="col">
                <hr />
            </div>
        </div>

        <div class="row">
            <div class="col">
                <h3 class="mb-2 mt-4">Free disk space (Output of <code>df -h</code>):</h3>
                <pre>
$(sudo bash -c "echo -en '$(df -h)\n'")
                </pre>
            </div>
        </div>

        <div class="row">
            <div class="col">
                <hr />
            </div>
        </div>

        <div class="row">
            <div class="col">
                <h3 class="mb-2 mt-4">Memory status (Output of <code>free -mh</code>):</h3>
                <pre>
$(sudo bash -c "echo -en '$(free -mh)\n'")
                </pre>
            </div>
        </div>

        <div class="row">
            <div class="col">
                <hr />
            </div>
        </div>

        <div class="row">
            <div class="col">
                <h3 class="mb-2 mt-4">Process list (Output of <code>ps aux</code>):</h3>
                <pre>
$(sudo bash -c "echo -en '$(ps aux | tr '<' '&lt;' | tr '>' '&gt;')\n'")
                </pre>
            </div>
        </div>
    </div>

</body>

EOF


# Install Docker (Official way)
# Install CA Certificates, cURL, GnuPG, lsb-release packages
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Create keyring folder
sudo mkdir -p /etc/apt/keyrings
# Add keyring of Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker package repo
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package indexes
sudo apt-get update -y

# Install Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Install Docker Compose
# Download Docker Compose
sudo curl -SL https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
# Make docker-compose executable
sudo chmod +x /usr/local/bin/docker-compose
# Make docker-compose available systemwide
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Enable docker service
sudo systemctl enable docker.service
# Enable containerd service
sudo systemctl enable containerd.service

# Start docker service
sudo systemctl start docker.service
# Start containerd service
sudo systemctl start containerd.service

# Add ubuntu user to docker group to make available other users than root to use docker cli
# Backup original group file
sudo cp /etc/group{,.bak}
# Add ubuntu user to docker group
sudo sed -i 's/docker:x:999:/docker:x:999:ubuntu/' /etc/group
sudo newgrp docker

# Install Squid proxy server
sudo apt install -y squid
# Backup original Squid config file
sudo cp /etc/squid/squid.conf{,.bak}
# Allow http proxy proxying
sed -i 's/http_access deny all/http_access allow all/' /etc/squid/squid.conf
# Restart Squid server
sudo systemctl restart squid

EOL

}
