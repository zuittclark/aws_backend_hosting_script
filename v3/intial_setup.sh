#!/bin/bash
echo -e "===================================="
echo -e "Installing and Setting up DOCKER ..."
echo -e "===================================="
curl -fsSL https://get.docker.com -o get-docker.sh || { echo "Error cloning docker installer."; exit 1; }
sh get-docker.sh && rm -rf get-docker.sh || { echo "Error installing docker."; exit 1; }
echo -e "===================================="
echo -e "(DONE) Installing and Setting up DOCKER!"
echo -e "===================================="


echo -e "===================================="
echo -e "Setting up NGINX Reverse Proxies ..."
echo -e "===================================="
new_server_block=$(cat <<'EOF'
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    
    root /var/www/html;
    
    index index.html index.htm index.nginx-debian.html;
    
    server_name _;
    
    location / {
        # First attempt to serve request as file, then
        # as directory, then fall back to displaying a 404.
        try_files $uri $uri/ =404;
    }

    location /b1 {
        rewrite ^/b1(/.*)$ $1 break;
        proxy_pass http://localhost:4001;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /b2 {
	rewrite ^/b2(/.*)$ $1 break;
	proxy_pass http://localhost:4002;
	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header X-Forwarded-Proto $scheme;
    } 
    

    location /b3 {
	rewrite ^/b3(/.*)$ $1 break;
	proxy_pass http://localhost:4003;
	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header X-Forwarded-Proto $scheme;
    } 
    

    location /b4 {
	rewrite ^/b4(/.*)$ $1 break;
	proxy_pass http://localhost:4004;
	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header X-Forwarded-Proto $scheme;
    } 
    

    location /b5 {
	rewrite ^/b5(/.*)$ $1 break;
	proxy_pass http://localhost:4005;
	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header X-Forwarded-Proto $scheme;
    } 
    

    location /b6 {
	rewrite ^/b6(/.*)$ $1 break;
	proxy_pass http://localhost:4006;
	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header X-Forwarded-Proto $scheme;
    } 
    

    location /b7 {
	rewrite ^/b7(/.*)$ $1 break;
	proxy_pass http://localhost:4007;
	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header X-Forwarded-Proto $scheme;
    } 
    

    location /b8 {
	rewrite ^/b8(/.*)$ $1 break;
	proxy_pass http://localhost:4008;
	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header X-Forwarded-Proto $scheme;
    } 
    

    location /b9 {
	rewrite ^/b9(/.*)$ $1 break;
	proxy_pass http://localhost:4009;
	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header X-Forwarded-Proto $scheme;
    } 
    

    location /b10 {
	rewrite ^/b10(/.*)$ $1 break;
	proxy_pass http://localhost:4010;
	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header X-Forwarded-Proto $scheme;
    } 
    

    location /b11 {
	rewrite ^/b11(/.*)$ $1 break;
	proxy_pass http://localhost:4011;
	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header X-Forwarded-Proto $scheme;
    } 
    

    location /b12 {
	rewrite ^/b12(/.*)$ $1 break;
	proxy_pass http://localhost:4012;
	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header X-Forwarded-Proto $scheme;
    } 
    

    location /b13 {
	rewrite ^/b13(/.*)$ $1 break;
	proxy_pass http://localhost:4013;
	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header X-Forwarded-Proto $scheme;
    } 
    

    location /b14 {
	rewrite ^/b14(/.*)$ $1 break;
	proxy_pass http://localhost:4014;
	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header X-Forwarded-Proto $scheme;
    } 
    

    location /b15 {
	rewrite ^/b15(/.*)$ $1 break;
	proxy_pass http://localhost:4015;
	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF
)

# Backup the current default configuration
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup

# Update the default configuration with the new server block
echo "$new_server_block" | sudo tee /etc/nginx/sites-available/default > /dev/null

# Reload Nginx to apply the changes
sudo systemctl reload nginx

echo "Nginx configuration updated successfully!"
echo -e "===================================="
echo -e "(DONE) Setting up NGINX Reverse Proxies"
echo -e "===================================="


echo -e "===================================="
echo -e "Provisioning necessary resources..."
echo -e "===================================="
git clone git@ec2-54-147-90-61.compute-1.amazonaws.com:zuitt_instructors/aws_backend_hosting_script.git || { echo "Error cloning resources."; exit 1; }
cp -r aws_backend_hosting_script/v3/utils ~/
cp aws_backend_hosting_script/v3/deploy.sh ~/
rm -rf aws_backend_hosting_script
chmod +x utils/start_docker_containers.sh
chmod +x deploy.sh
echo -e "===================================="
echo -e "(DONE) Provisioning necessary resources!"
echo -e "===================================="






# This should be the end
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
