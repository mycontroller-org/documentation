---
title: "Install Mosquitto MQTT Broker"
linkTitle: "Install Mosquitto MQTT Broker"
weight: 4
---

{{< alert title="Tested Versions" >}}
MyController tested on Mosquitto 1.6.9 or above
{{< /alert >}}

[Mosquitto](https://mosquitto.org/) broker can be installed in different way. Here we are focusing to setup it on docker and Mosquitto 1.6.9 version.

#### mosquitto.conf
Detailed information is on [Mosquitto Website](https://mosquitto.org/man/mosquitto-conf-5.html)

```
# create mosquitto.conf
sudo mkdir -p /opt/apps/mosquitto
sudo cd /opt/apps/mosquitto

sudo cat << EOF > mosquitto.conf
allow_anonymous true
persistence false
persistence_location /mosquitto/data/
EOF
```

##### Install
{{< alert title="Variable $PWD" >}}
`$PWD` is a Present Working Directory.
{{< /alert >}}

```
sudo mkdir -p /opt/apps/mosquitto
sudo cd /opt/apps/mosquitto

sudo docker run -d --name mc_mosquitto \
    -p 31883:1883 \
    -p 9001:9001 \
    -v $PWD/mosquitto.conf:/mosquitto/config/mosquitto.conf \
    --restart unless-stopped \
    eclipse-mosquitto:1.6.9
```

##### Restart
```
sudo docker restart mc_mosquitto
```

##### Uninstall
```
sudo docker stop mc_mosquitto
sudo docker rm mc_mosquitto
```
