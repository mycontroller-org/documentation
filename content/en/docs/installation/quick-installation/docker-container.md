---
title: "Install with container image"
linkTitle: "Install with container image"
weight: 1
---

## Install on Linux - Docker

-----
Steps to install on your linux machine with docker

{{< alert title="Note" >}}
Assuming that you are running all the commands as a `root` user.<br>
If you are running from non-root user, you should include `sudo` in the beginning of the commands.
{{< /alert >}}

* create directory for MyController server data and other usages
  ```bash
  mkdir -p /opt/apps/mycontroller/mc_home
  mkdir -p /opt/apps/mycontroller/mc_home/secure_share
  mkdir -p /opt/apps/mycontroller/mc_home/insecure_share
  ```
* copy `mycontroller.yaml` file
  ```bash
  cd /opt/apps/mycontroller
  
  curl https://raw.githubusercontent.com/mycontroller-org/backend/master/resources/sample-docker-server.yaml \
    --output mycontroller.yaml
  ```

#### Update mycontroller.yaml file
* **IMPORTANT:** update your secret on the `mycontroller.yaml` file. **DO NOT USE THE DEFAULT SECRET**
* secret can between 1 to 32 characters length
* This secret used to encrypt your third party password, tokens used on this server
  ```yaml
  secret: 5a2f6ff25b0025aeae12ae096363b51a # !!! WARNING: CHANGE THIS SECRET !!!
  ```

* Update `influx_database` configuration as follows in your `mycontroller.yaml`
  * prior to this step, **influxdb** should be **installed** and **running** with a database called **mycontroller** in influxdb
  * [Influxdb installation guide](/docs/getting-started/install-influxdb)
  * **IMPORTANT** `uri` - must point to the influxdb host ip address
    ```yaml
    database:
      metric:
        disabled: false
        type: influxdb
        uri: http://192.168.1.21:8086 # must be updated with your host ip address
        token:
        username:
        password:
        organization_name:
        bucket_name: mycontroller
        batch_size:
        flush_interval: 5s
    ```

* Optional - update `bus` configuration as follows in your `mycontroller.yaml`, if you plan to use external bus
  * **nats.io server** should be **installed** and **running**
  * [nats.io server installation guide](/docs/getting-started/install-natsio)
  * **IMPORTANT** `server_url` - must point to the nats.io server ip address.
    ```yaml
    bus:
      type: natsio
      topic_prefix: mc_communication_bus
      server_url: nats://192.168.1.21:4222 # must be updated with your host ip address
      insecure: false
      connection_timeout: 10s
    ```

* Start the MyController server
  ```bash
  docker run --detach --name mycontroller \
    --publish 8080:8080 \
    --publish 8443:8443 \
    --publish 9443:9443 \
    --volume $PWD/mc_home:/mc_home \
    --volume $PWD/mycontroller.yaml:/app/mycontroller.yaml \
    --env TZ="Asia/Kolkata" \
    --restart unless-stopped \
    docker.io/mycontroller/server:{{< variable "version" >}}
  ```

* Access MyController server Web UI
  * `http://<host-ip>:8080` (example: http://192.168.1.21:8080)
  * `https://<host-ip>:8443` (example: https://192.168.1.21:8443)

### To see the logs
* Prints all available logs
  ```bash
  docker logs mycontroller
  ```
* Prints and tails the logs, to get exit do `Ctrl+C`
  ```bash
  docker logs --follow mycontroller
  ```

### Stop
```bash
docker stop mycontroller
```

### Restart
```bash
docker restart mycontroller
```

### Uninstall
```bash
docker stop mycontroller
docker rm mycontroller
```