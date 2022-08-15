---
title: "Quick Installation"
linkTitle: "Quick Installation"
weight: 1
---

## Installation Methods
 * [Install on Linux - Executable Binary](#install-on-linux---executable-binary)
 * [Install on Linux - Docker](#install-on-linux---docker)

## Install on Linux - Executable Binary

-----
Steps to install the executable binary on your linux machine

### Download Options
* [Released versions](https://github.com/mycontroller-org/server/releases)
* [Pre Released versions](https://download.mycontroller.org/v2/master/)


### Choose the right executable bundle
Download the executable bundle that matches to your operating system architecture<br>

#### Architectures
* `linux-arm` - 32 bit ARM Linux
* `linux-arm64` - 64 bit ARM Linux
* `linux-386` - 32 bit Linux
* `linux-amd64` - 64 bit Linux
* `windows-386` - 32 bit Windows
* `windows-amd64` - 64 bit Windows

#### Download 
* Here we are focusing on `arm` architecture (Raspberry Pi). You can follows this guide for other architecture too.
* Download [mycontroller-server-{{< variable "version" >}}-linux-arm.tar.gz](https://download.mycontroller.org/v2/master/mycontroller-server-{{< variable "version" >}}-linux-arm.tar.gz)<br>


{{< alert title="Note" >}}
MyController server does not require root access, But for some devices(serial port, monitoring system resources, etc.,) it may required root access.<br>
If you want to run MyController server with `root`, you should include `sudo` in the beginning of the commands. or directly run the commands as `root` user.
{{< /alert >}}

* create a directories to keep MyController server data and executable
  ```bash
  mkdir -p /opt/apps/mycontroller/mc_home  # directory to hold data
  mkdir -p /opt/apps/mycontroller/executable # directory to hold executable

  # create directories to keep image files to show it MyController dashboard
  # Example, camera stream image
  mkdir -p /opt/apps/mycontroller/mc_home/secure_share
  mkdir -p /opt/apps/mycontroller/mc_home/insecure_share
 
  # download the bundle and extract on executable directory
  cd /opt/apps/mycontroller
  wget https://download.mycontroller.org/v2/master/mycontroller-server-{{< variable "version" >}}-linux-arm.tar.gz
  tar xzf mycontroller-server-{{< variable "version" >}}-linux-arm.tar.gz  --strip-components=1 --directory /opt/apps/mycontroller/executable
  ```
* now we have isolated MyController server *data* and *executables*, the expected result will be as follows,
* **NOTE:** still, we have to keep the configuration file (`mycontroller.yaml`) file on the executable directory
  ```bash
  $ ls /opt/apps/mycontroller/mc_home  # MyController server data location
  insecure_share  secure_share
  
  $ ls /opt/apps/mycontroller/executable # MyController server executable location
  LICENSE.txt  logs  mcctl.sh  mycontroller-server  mycontroller.yaml  README.txt  web_console
  ```

#### Update mycontroller.yaml file
* **IMPORTANT:** update your secret on the `mycontroller.yaml` file. **DO NOT USE THE DEFAULT SECRET**
* secret can between 1 to 32 characters length
* This secret used to encrypt your third party password, tokens used on this server
  ```yaml
  secret: 5a2f6ff25b0025aeae12ae096363b51a # !!! WARNING: CHANGE THIS SECRET !!!
  ```

* update influxdb configuration as follows in your `mycontroller.yaml`
  * prior to this step, **influxdb** should be **installed** and **running** with a database called **mycontroller** in influxdb
  * [Influxdb installation guide](/docs/getting-started/install-influxdb)
  * **IMPORTANT** `uri` - must point to the influxdb ip address. if you have installed on the same host, you can leave it as `127.0.0.1`
  * update other fields as per your influxdb setup
    ```yaml
    database:
      metric:
        disabled: false
        type: influxdb
        uri: http://127.0.0.1:8086 # must be updated with your host ip address
        token:
        username:
        password:
        organization_name:
        bucket_name: mycontroller
        batch_size:
        flush_interval: 5s
    ```
* if you plan to use https with ACME([Letsencrypt](https://letsencrypt.org/getting-started/)) follow the [detailed guide](/docs/advanced-installation/backend-configuration/#web-configuration)

* Optional - if you plan to use external bus, update `bus` configuration as follows in your `mycontroller.yaml`
  * **nats.io server** should be **installed** and **running**
  * [nats.io server installation guide](/docs/getting-started/install-natsio)
  * **IMPORTANT** `server_url` - must point to the nats.io server ip address. if you have installed on the same host, leave it as `127.0.0.1`
    ```yaml
    bus:
      type: natsio
      topic_prefix: mc_server
      server_url: nats://127.0.0.1:4222 # must be updated with your host ip address
      insecure: false
      connection_timeout: 10s
    ```

* Start the MyController server
  ```bash
  cd /opt/apps/mycontroller
  executable/mcctl.sh start
  ```

* Access MyController server Web UI
  * http: `http://<host-ip>:8080` (example: http://192.168.1.21:8080)
  * https: `https://<host-ip>:8443` (example: https://192.168.1.21:8443)

### To see the logs
* MyController log file is placed in the `executable` directory
  ```bash
  cd /opt/apps/mycontroller
  cat executable/logs/mycontroller.log
  ```
* Prints and tails the logs, to get exit do `Ctrl+C`
  ```bash
  cd /opt/apps/mycontroller
  tail --follow executable/logs/mycontroller.log
  ```
### Stop
```bash
cd /opt/apps/mycontroller
executable/mcctl.sh stop
```

### Restart
```bash
cd /opt/apps/mycontroller
executable/mcctl.sh stop
executable/mcctl.sh start
```

### Uninstall from your system
```bash
cd /opt/apps/mycontroller
executable/mcctl.sh stop
rm /opt/apps/mycontroller/executable --recursive --force
```

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