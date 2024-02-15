#!/bin/bash 

USER=kubeadmin 

# Remove previous Docker installations 

apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli docker-compose-plugin containerd.io 

apt-get autoremove -y --purge docker-engine docker docker.io docker-ce docker-ce-cli docker-compose-plugin containerd.io 

# Install fresh Docker 

cd /opt 

apt install apt-transport-https ca-certificates curl software-properties-common -y 

curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg 

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null 

apt update 

apt install docker-ce docker-ce-cli  containerd.io docker-compose-plugin docker-buildx-plugin -y 

usermod -aG docker $USER 

systemctl enable docker 

systemctl enable containerd 

systemctl start docker 

chmod 666 /var/run/docker.sock 

docker --version 

docker compose version 

# docker run hello-world 
