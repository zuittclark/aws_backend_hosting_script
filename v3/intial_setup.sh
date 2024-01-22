#!/bin/bash
echo -e "===================================="
echo -e "Installing and Setting up DOCKER ..."
echo -e "===================================="
curl -fsSL https://get.docker.com -o get-docker.sh || { echo "Error cloning docker installer."; exit 1; }
sh get-docker.sh && rm -rf get-docker.sh || { echo "Error installing docker."; exit 1; }
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
echo -e "===================================="
echo -e "(DONE) Installing and Setting up DOCKER!"
echo -e "===================================="


echo -e "===================================="
echo -e "Setting up swap memory ..."
echo -e "===================================="
SWAPFILE="/swapfile"
if [ -e "$SWAPFILE" ]; then
    echo -e "Swap file already exists. Skipping creation."
else
    # Create 1 gigabytes swap file
    sudo fallocate -l 1G "$SWAPFILE"
    sudo chmod 600 "$SWAPFILE"
    sudo mkswap "$SWAPFILE"
    sudo swapon "$SWAPFILE"
    # Add swap file to /etc/fstab
    echo "$SWAPFILE none swap sw 0 0" | sudo tee -a /etc/fstab
    echo -e "Swap file created and activated."
fi
sudo swapon --show
echo -e "===================================="
echo -e "(DONE) Swap memory setup successful!"
echo -e "You can check the swap memory in the task manager using htop."
echo -e "===================================="


echo -e "===================================="
echo -e "Setting up CRONTAB ..."
echo -e "===================================="
DOCKER_SCRIPT_PATH="~/utils/start_docker_containers.sh"
CRON_ENTRY="@reboot $DOCKER_SCRIPT_PATH"
echo "$CRON_ENTRY" > /tmp/docker_cron
crontab /tmp/docker_cron || { echo "Error setting up CRON job."; exit 1; }
rm /tmp/docker_cron
echo "Cron job set to start Docker containers on reboot."
echo -e "===================================="
echo -e "(DONE) Setting up CRONTAB!"
echo -e "===================================="