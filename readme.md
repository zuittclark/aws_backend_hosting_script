# AWS Bootcamper Instance Setup Script
#### The goal of this script is to automate the process of setting up the bootcampers user instance to minimize configuration steps

Example command:
```bash
curl -sSf https://raw.githubusercontent.com/zuittclark/aws_backend_hosting_script/master/setup.sh | bash -s -- 1
```

`Created by CLRK`


```bash
#B320 DNS
g1 - http://ec2-3-129-121-110.us-east-2.compute.amazonaws.com/b1
g2 - http://ec2-3-14-158-255.us-east-2.compute.amazonaws.com/b1
g3 - http://ec2-18-190-141-12.us-east-2.compute.amazonaws.com/b1

#Needed Command
curl -sSf https://raw.githubusercontent.com/zuittclark/aws_backend_hosting_script/master/setup.sh | bash -s -- 1

curl -sSf https://raw.githubusercontent.com/zuittclark/aws_backend_hosting_script/master/redeploy.sh | bash

# ================
# INSTRUCTOR SIDE
# ================
# #- connect to instance:
# ssh -o ServerAliveInterval=60 -i "zuitt_keypair_us_east2.pem" ubuntu@ec2-3-19-92-76.us-east-2.compute.amazonaws.com

# #- Add bootcamper
# sudo useradd --create-home --shell /bin/bash --gid bootcamper --comment "Ian Curay" bootcamper1

# #- Check the user list
# less /etc/passwd | grep bootcamper

# #- Setup ssh key for bootcamper
# sudo mkdir -p /home/bootcamper1/.ssh/
# sudo touch /home/bootcamper1/.ssh/authorized_keys
# sudo chown -R bootcamper1:bootcamper /home/bootcamper1/.ssh/
# sudo chmod 644 /home/bootcamper1/.ssh/authorized_keys
# sudo chmod 700 /home/bootcamper1/.ssh/

#============================================================
#- For auto setup
https://zuittclark.github.io/script-generator-cpst2Hosting/
# importing script manually
scp -i ~/.ssh/zuitt_keypair_us_east2.pem instructor_script.sh ubuntu@ec2-18-189-109-12.us-east-2.compute.amazonaws.com:~/
#============================================================

#- Add bootcamper server to nginx (This still need to be done manually)
sudo nano /etc/nginx/sites-available/default
    #add the ff under the "server_name_;" block:
#~~~~~~~~~~~~~~~~~~~~ copy the following: start ~~~~~~~~~~~~~~~~~~~~
        location /b1 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4001;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b1-webhook {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4101;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }
        
        location /b2 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4002;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b2-webhook {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4102;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b3 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4003;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b3-webhook {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4103;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b4 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4004;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b4-webhook {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4104;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b5 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4005;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b5-webhook {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4105;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b6 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4006;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b6-webhook {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4106;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b7 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4007;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b7-webhook {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4107;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b8 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4008;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b8-webhook {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4108;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b9-webhook {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4109;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b9 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4009;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b9-webhook {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4109;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b10 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4010;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b10-webhook {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4110;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }
#~~~~~~~~~~~~~~~~~~~~ copy the following: end ~~~~~~~~~~~~~~~~~~~~
#- Restart nginx service
sudo systemctl restart nginx
sudo systemctl status nginx

#================
#BOOTCAMPER SIDE
#================
#- access
ssh -o ServerAliveInterval=60 bootcamper1@ec2-18-189-109-12.us-east-2.compute.amazonaws.com

#AUTO SETUP (v1)
    # Note: the 1 arg after the -- pertains to the bootcamper number
    #+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    curl -sSf https://raw.githubusercontent.com/zuittclark/aws_backend_hosting_script/master/setup.sh | bash -s -- 1
    #+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    #REDEPLOY CHANGES SCRIPT 
    #+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    curl -sSf https://raw.githubusercontent.com/zuittclark/aws_backend_hosting_script/master/redeploy.sh | bash
    #+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#AUTO SETUP (v2)
    #Generate SSH Key
    #+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    curl -sSf https://raw.githubusercontent.com/zuittclark/aws_backend_hosting_script/master/v2/sshkeygen.sh | bash
    #+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    #+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    curl -sSf https://raw.githubusercontent.com/zuittclark/aws_backend_hosting_script/master/v2/setup_v2.sh | bash -s -- 1
    #+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    # Note: the 1 arg after the -- pertains to the bootcamper number

# MANUAL SETUP
    #- Setup node version (select only one of the ff)
    curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
        #alternatives:
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
            curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
    source ~/.nvm/nvm.sh
    nvm install 16.16.0
    nvm use 16.16.0

    #- Clone CSP2 repo

    #- install dependencies
    npm install

    #- Add to pm2
    pm2 start index.js --name b1 --interpreter ~/.nvm/versions/node/v16.16.0/bin/node

    #- Create a cron job (to run the server on boot)
    crontab -e #select 1 for nano editor 
        #Add the ff:
            @reboot sh -c 'cd /home/bootcamper1/app && pm2 start index.js --name b1 --interpreter ~/.nvm/versions/node/v16.16.0/bin/node'
    crontab -l #to check


```