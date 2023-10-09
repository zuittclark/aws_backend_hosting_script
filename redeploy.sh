#!/bin/bash
echo "=========================================="
echo "Pulling changes from remote repository..."
echo "=========================================="
git pull 
echo "=========================================="
echo "Restarting pm2 services..."
echo "=========================================="
pm2 restart all
echo "=========================================="
echo "Changes successfully deployed!"      
echo "=========================================="