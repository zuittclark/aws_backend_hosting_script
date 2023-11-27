#!/bin/bash
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
echo -e "Swap memory setup successful!"
echo -e "You can check the swap memory in the task manager using htop."
echo -e "===================================="