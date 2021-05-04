---
title: "Install Mosquitto MQTT Broker"
linkTitle: "Install Mosquitto MQTT Broker"
weight: 4
---

{{< alert title="Tested Versions" >}}
MyController tested on Mosquitto 1.6.9 or above
{{< /alert >}}

[Mosquitto](https://mosquitto.org/) broker can be installed in different way. Here we are focusing to setup it on docker and Mosquitto 1.6.9 version.

{{< alert title="Note" >}}
Assuming that you are running all the commands as a `root` user.

If you are running from non-root user, you should include `sudo` in the beginning of the commands.
{{< /alert >}}


#### mosquitto.conf
Detailed information is on [Mosquitto Website](https://mosquitto.org/man/mosquitto-conf-5.html)

```bash
# create mosquitto.conf
mkdir -p /opt/apps/mosquitto
cd /opt/apps/mosquitto

cat << EOF > mosquitto.conf
allow_anonymous true
persistence false
persistence_location /mosquitto/data/
EOF
```

##### Install
{{< alert title="Variable $PWD" >}}
`$PWD` is a `Print Working Directory`.
{{< /alert >}}

```bash
mkdir -p /opt/apps/mosquitto
cd /opt/apps/mosquitto

docker run -d --name mc_mosquitto \
    -p 1883:1883 \
    -p 9001:9001 \
    -v $PWD/mosquitto.conf:/mosquitto/config/mosquitto.conf \
    --restart unless-stopped \
    eclipse-mosquitto:1.6.9
```

##### Restart
```bash
docker restart mc_mosquitto
```

##### Uninstall
```bash
docker stop mc_mosquitto
docker rm mc_mosquitto
```
