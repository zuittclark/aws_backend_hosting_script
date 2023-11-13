#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <bc>"
    exit 1
fi

bc="$1"

echo "=========================================="
echo "Pulling changes from remote repository..."
echo "=========================================="
git pull || { echo "Error pulling changes from the remote repository"; exit 1; }
echo "=========================================="
echo "Installing/updating dependencies..."
echo "=========================================="
npm install
echo "=========================================="
echo "Restarting pm2 services..."
echo "=========================================="
pm2 restart "b$bc" || { echo "Error restarting pm2 services"; exit 1; }
echo "=========================================="
echo "Changes successfully deployed!"      
echo "=========================================="