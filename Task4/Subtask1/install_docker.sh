# Update packages and install other needed packages
./setup.sh

# Stop if some command is ended not successfully
set -e

# Install Docker (Official way)
# Install CA Certificates, cURL, GnuPG, lsb-release packages
sudo apt-fast -y update
sudo apt-fast -y install ca-certificates curl gnupg lsb-release

# Create keyring folder
sudo mkdir -p /etc/apt/keyrings

# Add keyring of Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker package repo
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package indexes
sudo apt-fast -y update

# Install Docker
sudo apt-fast -y install docker-ce docker-ce-cli containerd.io

# Install Docker Compose
# Download Docker Compose
sudo curl -SL https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose

# Make docker-compose executable
sudo chmod +x /usr/local/bin/docker-compose

# Make docker-compose available system-wide
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Enable and start docker and containerd service
sudo systemctl enable --now docker.service containerd.service

# Create docker group
sudo groupadd docker

# Add current user to docker group
sudo usermod -aG docker $USER

# Reload group params
newgrp docker

# (Download and) Run test docker image
docker run hello-world
