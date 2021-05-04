---
title: "Install Docker"
linkTitle: "Install Docker"
weight: 1
---

Docker can be installed in different way. Here it is explained to install it on Raspberry PI with Raspbian OS

Follow the steps below to install docker on your Raspberry PI

```
# copy the installation script
curl -fsSL https://get.docker.com -o get-docker.sh

# execute the script
sudo sh get-docker.sh

# enable the docker daemon
sudo systemctl enable docker.service

# start the docker daemon
sudo systemctl start docker.service

# check the docker daemon is active
sudo systemctl is-active docker.service
```


* Optional steps - If you plan to play docker command on user
```
# add a non-root user to the docker group
# here the "pi" is a user
sudo usermod -aG docker pi
```
