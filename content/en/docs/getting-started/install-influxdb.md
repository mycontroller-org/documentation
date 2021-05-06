---
title: "Install InfluxDB"
linkTitle: "Install InfluxDB"
weight: 2

influx_version: 1.8.4
---

{{< alert title="Supported Versions" >}}
MyController supports InfluxDB 1.8.x or above
{{< /alert >}}

InfluxDB can be installed in different way. Here we are focusing to setup it on docker and InfluxDB {{ $.Params "influx_version" }} version.

{{< alert title="Note" >}}
Assuming that you are running all the commands as a `root` user.

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

### Restart
```bash
docker restart mc_influxdb
```

### Uninstall
```bash
docker stop mc_influxdb
docker rm mc_influxdb
```
