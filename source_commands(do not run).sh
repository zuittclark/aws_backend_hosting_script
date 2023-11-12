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
#- connect to instance:
ssh -o ServerAliveInterval=60 -i "zuitt_keypair_us_east2.pem" ubuntu@ec2-3-19-92-76.us-east-2.compute.amazonaws.com

#- Add bootcamper
sudo useradd --create-home --shell /bin/bash --gid bootcamper --comment "Ian Curay" bootcamper1

#- Check the user list
less /etc/passwd | grep bootcamper

#- Setup ssh key for bootcamper
sudo mkdir -p /home/bootcamper1/.ssh/
sudo touch /home/bootcamper1/.ssh/authorized_keys
sudo chown -R bootcamper1:bootcamper /home/bootcamper1/.ssh/
sudo chmod 644 /home/bootcamper1/.ssh/authorized_keys
sudo chmod 700 /home/bootcamper1/.ssh/

#============================================================
#- For auto setup
https://zuittclark.github.io/script-generator-cpst2Hosting/
# script
scp -i ~/.ssh/zuitt_keypair_us_east2.pem instructor_script.sh ubuntu@ec2-18-189-109-12.us-east-2.compute.amazonaws.com:~/
#============================================================

sudo mkdir -p /home/bootcamper9/.ssh/
sudo touch /home/bootcamper9/.ssh/authorized_keys
sudo sh -c 'echo $"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkdeDpyAKhdk83+IGFPBlT4VrYu4lCvnbwF2HC/OotywZFhxohaLuAIjKQS/oxVbjsmajANhsjvUuu/e6yET2HKkYxpEcgKhCJQ0XxvNLB914Vd6ZDBeIWLhNaNe0EkpamEQUuGTKLDnM1gMaiXUE9zoRQhS/q6NU088BfEj1JjBkLw/zx8qaGBwnxU40SIOzu2v8MbLN2AToib0L6I//HYuY0NJLsy23PUiBl5BD34fyepkn1MJWkEPXfbQU9qE9RD8ERjztyCfxEfIqbkO4AgQEVQujjJkJiQ3OqshlVfgp+01CxiWiBVvJqYjmwBrglZmcrbAxvJnmlrycLqMaJa8x9lN5MA9bRTPOruJykcM/PcSOQNTwLPwFba2MVfrfS2P6iOa7cmU2t5SSBhRKmwIM5mf123wU2i1OvSBe7XAWRm8N1k8ox1yPYH1atFz/OfxlMnhvmWjuD+YYBeVhvnU4HlZE4cOtxjQ8Z0rptBlhO+mD6K2OTfGh42ycXtiU= jci@jci-A320M-S2H
" >> /home/bootcamper9/.ssh/authorized_keys'
sudo chown -R bootcamper9:bootcamper /home/bootcamper9/.ssh/
sudo chmod 644 /home/bootcamper9/.ssh/authorized_keys
sudo chmod 700 /home/bootcamper9/.ssh/

#- Add bootcamper server to nginx
sudo nano /etc/nginx/sites-available/default
    #add the ff under the "server_name_;" block:
        location /b0 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4000;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

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

#- Restart nginx service
sudo systemctl restart nginx
sudo systemctl status nginx



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#================
#BOOTCAMPER SIDE
#================
#- access
ssh -o ServerAliveInterval=60 bootcamper1@ec2-18-189-109-12.us-east-2.compute.amazonaws.com

#Generate SSH Key
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
curl -sSf https://raw.githubusercontent.com/zuittclark/aws_backend_hosting_script/master/sshkeygen.sh | bash
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#AUTO SETUP
# Note: the 1 arg after the -- pertains to the bootcamper number
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
curl -sSf https://raw.githubusercontent.com/zuittclark/aws_backend_hosting_script/master/setup.sh | bash -s -- 1
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#REDEPLOY CHANGES SCRIPT 
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
curl -sSf https://raw.githubusercontent.com/zuittclark/aws_backend_hosting_script/master/redeploy.sh | bash
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

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

