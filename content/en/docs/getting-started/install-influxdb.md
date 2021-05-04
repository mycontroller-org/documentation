---
title: "Install InfluxDB"
linkTitle: "Install InfluxDB"
weight: 2
---

{{< alert title="Supported Versions" >}}
MyController supports InfluxDB 1.8.x or above
{{< /alert >}}

InfluxDB can be installed in different way. Here we are focusing to setup it on docker and InfluxDB 1.8.4 version.

#### Generate influxdb.conf
Detailed information is on [InfluxDB Website](https://docs.influxdata.com/influxdb/v1.8/administration/config/)

```
# generate influxdb.conf
sudo mkdir -p /opt/apps/influxdb
sudo cd /opt/apps/influxdb
sudo docker run --rm influxdb:1.8.4 influxd config > influxdb.conf
```

* (Optional) Steps to disable InfluxDB monitor
  * Monitor InfluxDB metrics will be enabled by default. It eats lot of disk space and CPU.
  * on the generated influxdb.conf set `false` to `store-enabled`
```
[monitor]
  store-enabled = false
```

##### Install
{{< alert title="Variable $PWD" >}}
`$PWD` is a Present Working Directory.
{{< /alert >}}

```
sudo mkdir -p /opt/apps/influxdb/influxdb_data
sudo cd /opt/apps/influxdb

sudo docker run --detach --name mc_influxdb \
    --publish 8086:8086 \
    --volume $PWD/influxdb_data:/var/lib/influxdb \
    --volume $PWD/influxdb.conf:/etc/influxdb/influxdb.conf:ro \
    --env TZ="Asia/Kolkata" \
    --restart unless-stopped \
    influxdb:1.8.4
```

##### Create a database for MyController usage in influxDB
```
# enter inside running docker container
$ sudo docker exec -it mc_influxdb /bin/sh

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

##### Restart
```
sudo docker restart mc_influxdb
```

##### Uninstall
```
sudo docker stop mc_influxdb
sudo docker rm mc_influxdb
```
