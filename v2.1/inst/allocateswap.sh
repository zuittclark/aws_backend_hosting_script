#!/bin/bash

echo -e "===================================="
echo -e "Creating swap file ..."
echo -e "===================================="

sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
sudo swapon --show

echo -e "===================================="
echo -e "Swap file created successfully."
echo -e "You can check the swap memory in the task manager using htop."
echo -e "===================================="