variable "task_3_vm_1_user_data" {
  type = string
  description = "Script to run when EC2 instance is launching"
  default = <<EOL
#!/bin/bash

# Stop script when some step is failed
set -e

# Output of info file
SYSTEM_INFO_FILE_LOCATION="/var/www/html/info.html"


# Update package index
printf "\n#####################################################"
printf "\n############## Updating packages ... ################"
printf "\n#####################################################\n\n"

sudo apt-get -y update


# Upgrade all installed packages
printf "\n#####################################################"
printf "\n############## Upgrading packages ... ###############"
printf "\n#####################################################\n\n"

sudo apt-get -y upgrade


# Install nginx web-server
printf "\n#####################################################"
printf "\n############## Installing nginx web server ... ######"
printf "\n#####################################################\n\n"

sudo apt-get -y install nginx


# Start and enable nginx
printf "\n#####################################################"
printf "\n############## Installing nginx web server ... ######"
printf "\n#####################################################\n\n"

sudo systemctl enable nginx
sudo systemctl start nginx


# Generate page with "Hello World" text and system information
printf "\n#####################################################"
printf "\n############## Generating webpage with ##############"
printf "\n############## Hello World text and #################"
printf "\n############## system information ###################"
printf "\n#####################################################\n\n"

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

printf "\n#####################################################"
printf "\n############## Done ... #############################"
printf "\n#####################################################\n"


printf "\n#####################################################"
printf "\n############## Install Docker ... ###################"
printf "\n#####################################################\n"

sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo groupadd docker
sudo usermod -aG docker ubuntu

sudo newgrp docker

sudo systemctl enable docker.service
sudo systemctl enable containerd.service

sudo systemctl start docker.service
sudo systemctl start containerd.service

EOL

}
