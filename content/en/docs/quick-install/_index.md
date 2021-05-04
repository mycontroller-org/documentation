---
title: "Quick Install"
linkTitle: "Quick Install"
weight: 3
---

MyController.org 2.x can be installed in different way.
Here we are going to focus on Quick Install.

If quick install is not fulfil your requirements follow [Advanced Install](/docs/advanced-install/)

### Prerequisites
Prerequisites to setup MyController all-in-one
* [Docker Installation Guide](/docs/getting-started/install-docker)
* [InfluxDB Installation Guide](/docs/getting-started/install-influxdb)
* Optional
  * [Mosquitto Installation Guide](/docs/getting-started/install-mosquitto)
  * [nats.io Installation Guide](/docs/getting-started/install-natsio)

#### Install
* create directory for MyController.org storage and other usage
  ```
  sudo mkdir -p /opt/apps/mycontroller/mc_home
  ```
* Copy `mycontroller.yaml` file
  ```
  sudo cd /opt/apps/mycontroller
  
  sudo curl \
    https://raw.githubusercontent.com/mycontroller-org/backend/master/resources/default-all-in-one.yaml \
    --output mycontroller.yaml
  ```

* Update `influxdb_v1_8` configuration as follows in your `mycontroller.yaml`
  * **influxdb** should be **installed** and **running**
  * **Important** `uri` - must be updated with your host ip address
  ```yaml
  - name: influxdb_v1_8
    type: influxdb_v2
    uri: http://192.168.1.21:8086 # must be updated with your host ip address
    token: 
    username:
    password:
    organization: 
    bucket: mycontroller
    batch_size:
    flush_interval: 5s
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
  ```
  sudo docker run --detach --name mycontroller \
    --publish 80:8080 \
    --volume $PWD/mc_home:/mc_home \
    --volume $PWD/mycontroller.yaml:/app/mycontroller.yaml \
    --env TZ="Asia/Kolkata" \
    --restart unless-stopped \
    quay.io/mycontroller-org/all-in-one:master
  ```

* Access MyController server Web UI
  * `http://<host-ip>` (example: http://192.168.1.21)

#### Restart
```
sudo docker restart mycontroller
```

#### Uninstall
```
sudo docker stop mycontroller
sudo docker rm mycontroller
```