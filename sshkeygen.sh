#!/bin/bash

#GENERATE SSH KEY

# Set the default key file location and type
KEY_FILE="$HOME/.ssh/id_rsa_git"
KEY_TYPE="rsa"
KEY_BITS="2048"

# Check if the key file already exists
if [ -f "$KEY_FILE" ]; then
    echo "SSH key already exists at: $KEY_FILE"
    echo -e "\nYour public key is: \n"
    cat "${KEY_FILE}.pub"
    exit 1
fi

# Prompt user for key file location
read -p "Enter the file to save the key (default: $KEY_FILE): " CUSTOM_KEY_FILE
KEY_FILE="${CUSTOM_KEY_FILE:-$KEY_FILE}"

# Prompt user for key type
read -p "Enter the key type (default: $KEY_TYPE): " CUSTOM_KEY_TYPE
KEY_TYPE="${CUSTOM_KEY_TYPE:-$KEY_TYPE}"

# Prompt user for key bits
read -p "Enter the key bits (default: $KEY_BITS): " CUSTOM_KEY_BITS
KEY_BITS="${CUSTOM_KEY_BITS:-$KEY_BITS}"

# Generate SSH key pair
ssh-keygen -t "$KEY_TYPE" -b "$KEY_BITS" -f "$KEY_FILE" -N ""

# Display the public key
echo "SSH Key generated!"
echo -e "\nYour public key is: \n"
cat "${KEY_FILE}.pub"

