---
title: "System Monitoring"
linkTitle: "Gateway System Monitoring"
weight: 6
---
System Monitoring is an internal plugin developed and maintained by MyController


## Configuration
* Form view
  ![gateway-system-monitoring](/doc-images/gateway-system-monitoring.png)
* YAML View
  ```yaml
  provider:
    type: system_monitoring # (1)
    hostIdMap: {} # (2)
    hostConfigMap: {} # (3)
  ```
  1. `type` should be selected as `system_monitoring`
  2. `hostIdMap` - is a group of key value map
  3. `hostConfigMap` configurations of monitoring resources

### Host ID Map Configuration
Host ID Map (`hostIdMap`) is used to map the real host id with a friendly name

Samples:
```yaml
be0164ad-6f25-4448-b691-567946392b47: rpi_1
a574ac8d-4c9f-40d6-b0ce-bbc7d98cd87d: rpi_2
```
Here `be0164ad-6f25-4448-b691-567946392b47` is the actual id of the host and it is mapped with `rpi_1`.
If data received from this node, The node name will be as `rpi_1`

### Host Config Map Configuration
Host Config Map (`hostConfigMap`) is used to configure a specific node(s)

```yaml
rpi_1: # (1)
  disabled: false # (2)
  cpu: # (3)
    interval: 1m
    cpuDisabled: false
    perCpuDisabled: false
    unit: MiB
  disk: # (4)
    interval: 1h
    disabled: false
    data:
      disk_root:
        disabled: false
        name: "Root"
        path: /root
        unit: MiB
      disk_storage:
        disabled: false
        name: "Storage"
        path: /storage
        unit: MiB
  memory: # (5)
    interval: 1m
    memoryDisabled: false
    swapMemoryDisabled: false
  process: # (6)
    interval: 1m
    disabled: false
    data:
      influxd:
        disabled: false
        name: "InfluxDB"
        unit: MiB
        filter:
          cmdline: influxd
      adguard:
        disabled: false
        name: "AdGuard"
        unit: MiB
        filter:
          cmdline: >-
            /opt/adguardhome/AdGuardHome --no-check-update -c
            /opt/adguardhome/conf/AdGuardHome.yaml -h 0.0.0.0 -w
            /opt/adguardhome/work
      mycontroller:
        disabled: false
        name: "MyController"
        unit: MiB
        filter:
          cmdline: /app/mycontroller-all-in-one -config /app/mycontroller.yaml
      natsio:
        disabled: false
        name: "NatsIO"
        unit: MiB
        filter:
          cmdline: nats-server --config /etc/nats/nats-server.conf
      proc_gw:
        disabled: false
        name: "MYC GW"
        unit: MiB
        filter:
          cmdline: ./mycontroller-gateway -config gateway.yaml
  temperature: # (7)
    disabledAll: false
    interval: 30s
    enabled: []
rpi_2: # (1)
  cpu:
    # ...
```
1. node_id - id of the node or host
2. `disabled` - set `true` to disable data from this node. default value: `false`
3. `cpu` configurations
4. `disk` configurations
5. `memory` configurations
6. `process` configurations
7. `temperature` configurations

#### CPU Configurations
```yaml
cpu:
  interval: 1m # (1)
  cpuDisabled: false # (2)
  perCpuDisabled: false # (3)
```
1. `interval` - metric measurement interval
2. `cpuDisabled` - disable overall CPU metrics data
3. `perCpuDisabled` - disable individual CPU(s) metrics data

#### Disk Configurations
```yaml
disk:
  interval: 1h # (1)
  disabled: false # (2)
  data: # (3)
    disk_root: # (4)
      disabled: false # (5)
      name: "Root" # (6)
      path: /root # (7)
      unit: MiB # (8)
    disk_storage:
      disabled: false
      name: "Storage"
      path: /storage
```
1. `interval` - metric measurement interval
2. `disabled` - disable the all the disk metrics
3. `data` - is a map of disk configurations
4. This id will be used as `fieldId` in MyController, use lowercase, no special characters, `_` allowed
5. `disabled` - disable this particular disk metrics
6. `name` - will be used as field name
7. `path` - disk path used to measure the usage details
8. `unit` - [units guide](#measurement-units)
   
#### Memory Configurations
```yaml
memory:
  interval: 1m # (1)
  memoryDisabled: false # (2)
  swapMemoryDisabled: false # (3)
  unit: MiB # (4)
```
1. `interval` - metric measurement interval
2. `memoryDisabled` - enable/disable memory measurement
3. `swapMemoryDisabled` - enable/disable swap measurement
4. `unit` - [units guide](#measurement-units)

#### Process Configurations
```yaml
process:
  interval: 1m # (1)
  disabled: false # (2)
  data: # (3)
    influxd: # (4)
      disabled: false # (5)
      name: "InfluxDB" # (6)
      unit: MiB # (7)
      filter: # (8)
        cmdline: influxd # (9)
    mycontroller:
      disabled: false
      name: "MyController"
      filter:
        cmdline: /app/mycontroller-all-in-one -config /app/mycontroller.yaml
```
1. `interval` - metric measurement interval
2. `disabled` - disable the all the process metrics
3. `data` - is a map of process configurations
4. This id will be used as `fieldId` in MyController, use lowercase, no special characters, `_` allowed
5. `disabled` - disable this particular process metrics
6. `name` - will be used as field name
7. `unit` - [units guide](#measurement-units)
8. `filter` - used to get a specific filter
9. `cmdline` - one of the key used to filter a process

Supported keys in the `filter`
* `pid` - Process ID
* `cmdline` - 
* `cwd` - client's Current Working Directory
* `exe` - 
* `name` - 
* `nice` - nice value of the process
* `ppid` - Parent Process ID 
* `username` - 

#### Measurement Units
Bye default all the values reported in bytes.
We have an option to convert the bytes to more readable values.<br>
Update `unit` on the supported resources.<br>
If you want the values in bytes leave the `unit` field as blank or remove it completely

Supported units: `KiB`, `MiB`, `GiB`, `TiB`, `PiB`, `EiB`
  - KiB - Kibibytes (1024<sup>1</sup> bytes)
  - MiB - Mibibytes (1024<sup>2</sup> bytes)
  - GiB - Gibibytes (1024<sup>3</sup> bytes)
  - TiB - Tebibytes (1024<sup>4</sup> bytes)
  - PiB - Pebibytes (1024<sup>5</sup> bytes)
  - EiB - Exbibytes (1024<sup>6</sup> bytes)

{{< alert title="Note" >}}
Units are case sensitive. If the specified unit is not in the above list, returns the value as bytes
{{< /alert >}}