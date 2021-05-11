---
title: "Install InfluxDB"
linkTitle: "Install InfluxDB"
weight: 2

influx_version: 1.8.4
---

{{< alert title="Supported Versions" color="primary" >}}
MyController supports InfluxDB 1.8.x or above
{{< /alert >}}

{{< alert title="Warning" color="warning">}}
In ARM v6, docker version of InfluxDB not started and no issue reported. Tested it on 1.8.4<br>
We can directly install on the host system by following [this guide](#install-influxdb-on-the-host-system)
{{< /alert >}}

InfluxDB can be installed in different way. Here we are focusing to setup it on docker and InfluxDB 1.8.4 version.

{{< alert title="Note" >}}
Assuming that you are running all the commands as a `root` user.<br>
If you are running from non-root user, you should include `sudo` in the beginning of the commands.
{{< /alert >}}


### Generate influxdb.conf
Detailed information is on [InfluxDB Website](https://docs.influxdata.com/influxdb/v1.8/administration/config/)

* generate `influxdb.conf`

  ```bash
  mkdir -p /opt/apps/influxdb
  cd /opt/apps/influxdb

  docker run --rm influxdb:1.8.4 influxd config > influxdb.conf
  ```

* (Optional) Steps to disable InfluxDB monitor
  * Monitor InfluxDB metrics will be enabled by default. It eats lot of disk space and CPU.
  * on the generated `influxdb.conf` set `false` to `store-enabled`, available under `monitor`
  ```toml
  [monitor]
    store-enabled = false
  ```

### Install
{{< alert title="Variable $PWD" >}}
`$PWD` is a `Print Working Directory`.
{{< /alert >}}

```bash
mkdir -p /opt/apps/influxdb/influxdb_data
cd /opt/apps/influxdb

docker run --detach --name mc_influxdb \
    --publish 8086:8086 \
    --volume $PWD/influxdb_data:/var/lib/influxdb \
    --volume $PWD/influxdb.conf:/etc/influxdb/influxdb.conf:ro \
    --env TZ="Asia/Kolkata" \
    --restart unless-stopped \
    influxdb:1.8.4
```

### Create a database for MyController usage in influxDB
* enter inside running docker container
* execute `influx` command inside the influx container as follows
* create a database by running `create database mycontroller`
* show available databases by running `show databases`
* type `exit` two time, one exits from influx client shell, second exits from the docker container

```bash
$ docker exec -it mc_influxdb /bin/sh

# influx
Connected to http://localhost:8086 version 1.8.4
InfluxDB shell version: 1.8.4
> create database mycontroller
> show databases
name: databases
name
----
mycontroller
> exit
# exit
```

### To see the logs
* Prints all available logs
  ```bash
  docker logs mc_influxdb
  ```
* Prints and tails the logs, to get exit do `Ctrl+C`
  ```bash
  docker logs --follow mc_influxdb
  ```

### Restart
```bash
docker restart mc_influxdb
```

### Uninstall
```bash
docker stop mc_influxdb
docker rm mc_influxdb
```

## Install InfluxDB on the host system
Most of the places docker installation of influxdb works ok.<br>
In ARM v6, docker version of influxDB is not working (Tested it on 1.8.4)<br>
In that case follow this guide to install InfluxDB directly on the host system<br>

**Run the following commands as a `root` user**<br>
Operating System: `Raspbian Linux 10 (buster)`

```bash
# configure influxdb repository
wget -qO- https://repos.influxdata.com/influxdb.key | apt-key add -
echo "deb https://repos.influxdata.com/debian buster stable" | tee /etc/apt/sources.list.d/influxdb.list

# update package details to the local system
apt update

# install influxdb and enable to run at startup
apt install influxdb
systemctl enable influxdb.service

# start influxdb
systemctl start influxdb.service
```

Optionally you can disable self monitoring metrics to avoid unnecessary CPU and Disk usage.

* update the following line on `/etc/influxdb/influxdb.conf`
  ```toml
  [monitor]
    store-enabled = false
  ```
* restart the influxdb service
  ```bash
  systemctl restart influxdb.service
  ```

### Create a database for MyController usage in influxDB
```bash
root@rpi-171:~# influx
Connected to http://localhost:8086 version 1.8.5
InfluxDB shell version: 1.8.5
> create database mycontroller
> show databases
name: databases
name
----
mycontroller
> exit
```