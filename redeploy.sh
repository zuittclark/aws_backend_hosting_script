#!/bin/bash -e

echo "=========================================="
echo "Pulling changes from remote repository..."
echo "=========================================="
git pull || { echo "Error pulling changes from the remote repository"; exit 1; }
echo "=========================================="
echo "Restarting pm2 services..."
echo "=========================================="
pm2 restart all || { echo "Error restarting pm2 services"; exit 1; }
echo "=========================================="
echo "Changes successfully deployed!"      
echo "=========================================="
