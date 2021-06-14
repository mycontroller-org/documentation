---
title: "Install Mosquitto MQTT Broker"
linkTitle: "Install Mosquitto MQTT Broker"
weight: 5
---

{{< alert title="Tested Versions" >}}
MyController tested on Mosquitto 1.6.9
{{< /alert >}}

[Mosquitto](https://mosquitto.org/) broker can be installed in different way. Here we are focusing to setup it on docker and Mosquitto 1.6.9 version.


**To install Mosquitto broker on your host system [follow this guide](https://mosquitto.org/download/)**

{{< alert title="Note" >}}
Assuming that you are running all the commands as a `root` user.<br>
If you are running from non-root user, you should include `sudo` in the beginning of the commands.
{{< /alert >}}


### mosquitto.conf
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

### Install
{{< alert title="Variable $PWD" >}}
`$PWD` is a `Print Working Directory`.
{{< /alert >}}

```bash
mkdir -p /opt/apps/mosquitto
cd /opt/apps/mosquitto

docker run -d --name mc_mosquitto \
    --publish 1883:1883 \
    --publish 9001:9001 \
    --volume $PWD/mosquitto.conf:/mosquitto/config/mosquitto.conf \
    --restart unless-stopped \
    eclipse-mosquitto:1.6.9
```

### To see the logs
* Prints all available logs
  ```bash
  docker logs mc_mosquitto
  ```
* Prints and tails the logs, to get exit do `Ctrl+C`
  ```bash
  docker logs --follow mc_mosquitto
  ```

### Restart
```bash
docker restart mc_mosquitto
```

### Uninstall
```bash
docker stop mc_mosquitto
docker rm mc_mosquitto
```
