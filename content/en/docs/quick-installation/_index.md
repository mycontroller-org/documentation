---
title: "Quick Installation"
linkTitle: "Quick Installation"
weight: 3
---

MyController.org 2.x can be installed in different way.
Here we are going to focus on All-In-One setup.

If the quick installation is not fulfil your requirements follow [advanced Installation guide](/docs/advanced-installation/)<br>
To know more about All-In-One setup [follow this guide](/docs/overview/#all-in-one-bundle-and-setup)

## Prerequisites
Prerequisites to setup MyController all-in-one
* [Docker Installation Guide](/docs/getting-started/install-docker)
* [InfluxDB Installation Guide](/docs/getting-started/install-influxdb)
* Optional
  * [Mosquitto Installation Guide](/docs/getting-started/install-mosquitto)
  * [nats.io Installation Guide](/docs/getting-started/install-natsio)

## Install on Linux
In this document we are focusing installation on a docker setup.

{{< alert title="Note" >}}
Assuming that you are running all the commands as a `root` user.<br>
If you are running from non-root user, you should include `sudo` in the beginning of the commands.
{{< /alert >}}

* create directory for MyController server storage and other usages
  ```bash
  mkdir -p /opt/apps/mycontroller/mc_home
  ```
* copy `mycontroller.yaml` file
  ```bash
  cd /opt/apps/mycontroller
  
  curl https://raw.githubusercontent.com/mycontroller-org/backend/master/resources/default-all-in-one.yaml \
    --output mycontroller.yaml
  ```

* Update `influx_database` configuration as follows in your `mycontroller.yaml`
  * **influxdb** should be **installed** and **running**
  * **Important** `uri` - must be updated with your host ip address
    ```yaml
    - name: influx_database
      type: influxdb_v2
      uri: http://192.168.1.21:8086 # must be updated with your host ip address
      token: 
      username:
      password:
      organization: 
      bucket: mycontroller
      batch_size:
      flush_interval: 1s
    ```

* Update `metrics` database to `influx_database`
  ```yaml
  database:
    storage: memory_database
    metrics: influx_database # <-- update this field to point influx database config
  ```

* Optional - Update `bus` configuration as follows in your `mycontroller.yaml`, if you plan to use external bus
  * **nats.io server** should be **installed** and **running**
  * **Important** `server_url` - must be updated with your host ip address
    ```yaml
    bus:
      type: natsio
      topic_prefix: mc_communication_bus
      server_url: nats://192.168.1.21:4222 # must be updated with your host ip address
      tls_insecure_skip_verify: false
      connection_timeout: 10s
    ```

* Start MyController server
  ```bash
  docker run --detach --name mycontroller \
    --publish 80:8080 \
    --volume $PWD/mc_home:/mc_home \
    --volume $PWD/mycontroller.yaml:/app/mycontroller.yaml \
    --env TZ="Asia/Kolkata" \
    --restart unless-stopped \
    quay.io/mycontroller-org/all-in-one:master
  ```

* Access MyController server Web UI
  * `http://<host-ip>` (example: http://192.168.1.21)

### To see the logs
* Prints all available logs
  ```bash
  docker logs mycontroller
  ```
* Prints and tails the logs, to get exit do `Ctrl+C`
  ```bash
  docker logs --follow mycontroller
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