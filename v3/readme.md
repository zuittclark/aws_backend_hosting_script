# AWS Bootcamper Instance Setup Script v3

## This version of CSP2 Backend API hosting platform utilize Contanerization with Docker


### Initial Setup
**Add SSH to Zuitt Git**
```bash
curl -sSf https://csp2-scripts.s3.us-west-2.amazonaws.com/v3/sshkeygen.sh | bash
```

**Run initial setup script**
```bash
curl -sSf https://csp2-scripts.s3.us-west-2.amazonaws.com/v3/intial_setup.sh | bash
```
**To run docker without sudo**
```bash
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
```