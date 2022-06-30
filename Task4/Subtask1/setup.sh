# Stop if some command is ended not successfully
set -e

# Update packages index
sudo apt-get -y update

# Add apt-fast repository (fast download wrapper for apt-get)
sudo add-apt-repository -y ppa:apt-fast/stable

# Set aria2c max download threads count
echo debconf apt-fast/maxdownloads string 16 | sudo debconf-set-selections

# Suppress confirmation dialog before installing
echo debconf apt-fast/dlflag boolean true | sudo debconf-set-selections

# APT backend
echo debconf apt-fast/aptmanager string apt-get | sudo debconf-set-selections

# Install apt-fast
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y apt-fast

# Upgrade packages
sudo apt-fast -y upgrade

sudo apt-fast -y install nano htop curl wget net-tools traceroute mtr
