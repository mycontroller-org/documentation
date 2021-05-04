---
title: "Install Docker"
linkTitle: "Install Docker"
weight: 1
---

Docker can be installed in different way. Here it is explained to install it on Raspberry PI with Raspbian OS

Follow the steps below to install docker on your Raspberry PI

{{< alert title="Note" >}}
Assuming that you are running all the commands as a `root` user.

If you are running from non-root user, you should include `sudo` in the beginning of the commands.
{{< /alert >}}


```bash
# copy the installation script
curl -fsSL https://get.docker.com -o get-docker.sh

# execute the script
sh get-docker.sh

# enable the docker daemon
systemctl enable docker.service

# start the docker daemon
systemctl start docker.service

# check the docker daemon is active
systemctl is-active docker.service
```


* Optional steps - If you plan to play docker command on user
  ```bash
  # add a non-root user to the docker group
  # here the "pi" is a user
  usermod -aG docker pi
  ```
