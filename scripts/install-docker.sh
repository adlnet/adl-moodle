#!/bin/bash

set -e

# Simple function to announce what we're doing
announce() {
	echo ""
	echo "#===============================================================#"
	echo "#            Installing $1"
	echo "#===============================================================#"
}

announce "Wget"

if ! [ -x "$(command -v wget)" ]; then
	sudo apt-get install -y wget
else
	echo "Skipping, Wget already installed!"
fi

announce "Docker"

# sudo apt-get remove docker docker-engine docker.io containerd runc

if ! [ -x "$(command -v docker)" ]; then

  # Uninstall old versions
	sudo apt-get remove -y docker docker-engine docker.io containerd runc

	# Add the GPG Key
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

	# Add the Docker repository to our APT sources
	echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	
	# With those added, update our packages
	sudo apt-get update

	# Since we're up to date, get docker
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io

	# Add this user to the docker group
	sudo usermod -aG docker $USER
else
	echo "Skipping, docker already installed!"
fi

announce "Docker-Compose"

if ! [ -x "$(command -v docker-compose)" ]; then

	mkdir -p ~/.docker/cli-plugins/
	curl -SL https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-$(uname -s)-$(uname -m) -o ~/.docker/cli-plugins/docker-compose
	chmod +x ~/.docker/cli-plugins/docker-compose
	sudo ln -sfn ~/.docker/cli-plugins/docker-compose /usr/local/bin/docker-compose
	echo export DOCKER_BUILDKIT=1 >> ~/.profile
else
	echo "Skipping, docker-compose already installed!"
fi

# Enable docker features
export DOCKER_BUILDKIT=1

echo
echo "NOTE: You must logout, then log back in for the correct Docker permissions"
echo
