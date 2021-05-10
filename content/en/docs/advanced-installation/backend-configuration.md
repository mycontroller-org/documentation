---
title: "Backend Configuration"
linkTitle: "Backend Configuration"
weight: 1
---

MyController backend configurations are loaded at the time of startup.
Configurations should be in the **[YAML](https://yaml.org/)** file format.

Samples are available in the [source code repository](https://github.com/mycontroller-org/backend/tree/master/resources)

{{< alert title="Note">}}
`mycontroller.yaml` file will not be included in the backup for the security reasons.
{{< /alert >}}


## mycontroller.yaml

```yaml
web: # (1)
  bind_address: "0.0.0.0"
  port: 8080
  web_directory: /ui
  enable_profiling: false

secret: 5a2f6ff25b0025aeae12ae096363b51a # (2)

logger: # (3)
  mode: development
  encoding: console
  level:
    core: info
    storage: info
    metrics: warn

directories: # (4)
  data: /mc_home/data
  logs: /mc_home/logs
  tmp: /mc_home/tmp

bus: # (5)
  type: natsio
  topic_prefix: mc_production
  server_url: nats://192.168.1.21:4222
  tls_insecure_skip_verify: false
  connection_timeout: 10s

gateway: # (6)
  ids: []
  labels:
    location: core

database: # (7)
  storage: memory_db
  metrics: influxdb_v1_8

databases: # (8)
  - name: memory_db
    type: memory
    dump_enabled: true
    dump_interval: 10m
    dump_dir: "memory_db"
    dump_format: ["yaml", "json"]
    load_format: "yaml"

  - name: influxdb_v1_8
    type: influxdb_v2
    uri: http://192.168.1.21:8086
    token: 
    username:
    password:
    organization: 
    bucket: mycontroller
    batch_size:
    flush_interval: 5s
```
1. `web` holds the [web configurations](#web-configuration)
2. `secret` is used to encrypt the password of the third party services and keep encrypted data in the storage database.
   At later point if you change this `secret` you have update manually the existing third party services passwords.
3. `logger` - controls the logs level of a [different components](#logger).
4. `directories` - points to [custom locations](#directories).
5. `bus` - [message bus configurations](#message-bus), will be used for internal communications.
6. `gateway` - [filters](#gateway) to load gateways to this instance.
7. `database` - says which configuration should be used for `storage` and `metrics`. Name of the configuration should be supplied. It looks the detailed configuration from `databases`(#6) list.
8. `databases` - keeps the detailed configurations of a [different databases](#databases).

### Web Configuration
```yaml
web:
  bind_address: "0.0.0.0" # (1)
  port: 8080 # (2)
  web_directory: /ui # (3)
  enable_profiling: false # (14)
```
1. `bind_address` - IP address to bind, `0.0.0.0` - binds to all the available network interfaces.
2. `port` number for the web interface
3. `web_directory` - production build location of [Web Console](https://github.com/mycontroller-org/console-web)
4. `enable_profiling` - enables [GoLang profiling](https://golang.org/pkg/net/http/pprof/) on the http api

### Logger
```yaml
logger:
  mode: development # (1)
  encoding: console # (2)
  level: # (3)
    core: info
    storage: info
    metrics: warn
```
1. `mode` - supports two modes.
   - `development` - prints the detailed information about the log fields
   - `production` - prints the restricted information about the log fields
2. `encoding` - log encoding format
   - `console` - suits for console display
   - `json` - prints logs in json format, suits for processing with external tools
3. `level` - restrict the log level. supported levels: `debug`, `info`, `warn`, `error`, `fatal`.
   You can restrict the log level to a specific service.
   - `core` - entire system log level. This is applicable for gateway service too.
   - `storage` service log level
   - `metrics` service log level

### Directories
```yaml
directories:
  data: /mc_home/data # (1)
  logs: /mc_home/logs # (2)
  tmp: /mc_home/tmp # (3)
```
MyController uses these directories to keep configurations, logs, and temporary files.
1. `data` - keeps all configurations on this location. in-memory database, firmware, etc.,
2. `logs` - keeps gateway logs and system logs
3. `tmp` - used as a temporary location for MyController services

### Message Bus
```yaml
bus:
  type: natsio # (1)
  topic_prefix: mc_production # (2)
  server_url: nats://192.168.1.21:4222 # (12)
  tls_insecure_skip_verify: false # (3)
  connection_timeout: 10s # (4)
```
1. `type` - There are two type of [message bus](/docs/overview/architecture/#message-bus) available.
   - `embedded` - internal message bus. You cannot include external gateway
   - `natsio` - external message bus
2. `topic_prefix` - A natsio message bus can be used for different applications.
   Based on this topics we can separate a specific MyController instance.
3. `server_url` - natsio server url
4. `tls_insecure_skip_verify` - allow or disallow insecure connections
5. `connection_timeout` - connection establishment timeout

{{< alert title="Important" color="danger">}}
When you use external gateway service.
You should use external message bus service(natsio)
Also should use the same message bus configurations in the MyController instance and in the external gateway instances.
{{< /alert >}}


### Gateway
```yaml
gateway:
  ids: [] # (1)
  labels: # (2)
    location: core
```
We can restrict to load a specific gateway to this service.
1. `ids` - filtered by list of gateways id
2. `labels` - filtered based on the labels. [detailed guide](/docs/user-interface/resources/gateway/#power-of-the-labels)

{{< alert title="Note">}}
Empty filter loads all the gateways.
{{< /alert >}}

### Databases
You can define ant number of databases.
However only two configurations used. one for `storage` and another one is for `metrics`

The `name` and `type` fields are common in across all the database configurations

```yaml
databases:
  - name: memory_db # (1)
    type: memory # (2)
    dump_enabled: true
    dump_interval: 10m
    dump_dir: "memory_db"
    dump_format: ["yaml", "json"]
    load_format: "yaml"
```
1. `name` of the database, should a be unique name
2. `type` of the database

MyController needs two type of databases.
1. [Storage](#storage-databases)
2. [Metrics](#metric-databases)

#### Storage Databases
MyController supports two type of storage databases
- [In Memory](#in-memory-database)
- [MongoDB](#mongodb-database)

##### In Memory Database
In memory is a special database designed by MyController.org.
It keeps all the configuration data in the memory(RAM).
Dumps all the data into the disk on a specified interval.
When MyController start up, loads all the data from the disk to memory.

We can reduce the number of writes to disk on configurations change.
This can increase the life time of the disk.
This is very good choice for a tiny hardwares(ie: Raspberry PI).

In-Memory database will be faster as the configurations are in memory(RAM).

{{< alert title="Important" color="danger">}}
(assuming dump enabled)
When the MyController server terminated gracefully, dumps all the configuration data onto disk.
So there will be no loss.

However there will be some loss, if the service terminated forcefully.
{{< /alert >}}

```yaml
name: memory_db # (1)
type: memory # (2)
dump_enabled: true # (3)
dump_interval: 10m # (4)
dump_dir: "memory_db" #(5)
dump_format: ["yaml", "json"] # (6)
load_format: "yaml" # (7)
```
1. `name` of the database, should be unique name
2. `type` should be `memory`
3. `dump_enabled` - enable or disable sync to disk feature. Copies in memory configurations to disk
4. `dump_interval` - how long once the sync should happen.
5. `dump_dir` - directory used to dump in memory configurations. default: `memory_db`
6. `dump_format` - supports `yaml` and `json` formats. You can ask to dump a format or both formats
7. `load_format` - even though you can dump configurations on `yaml` and/or `json` format. at the time of startup, only one format can be used. Make sure you are using this format on the `dump_format`

##### MongoDB Database
MyController supports MongoDB local or cloud version.

```yaml
name: mongo_local
type: mongodb
database: mcdb
uri: mongodb://192.168.1.21:27017
```
1. `name` of the database, should be a unique name
2. `type` should be `mongodb`
3. `database` - name of the database in your MongoDB
4. `uri` of the database. supports cloud database format too.


#### Metric Databases
MyController supports two type of metric databases
- [Void](#in-memory-database)
- [InfluxDB](#mongodb-database)

##### Void Database
If you do not want track metrics in your MyController instance you can go with void database.
It means nothing recorded.

```yaml
name: dummy_metric_database
type: void_db
```
1. `name` of the database, should be unique
2. `type` should be `void_db`

##### InfluxDB
MyController uses InfluxDB to keep the metrics data. It can be local InfluxDB instance or can be in the cloud.

MyController supports InfluxDB **1.8.4 or above** versions.

{{< alert title="Note">}}
Flux query supports for InfluxDB 1.8.x and InfluxDB 2.x, however there an **[issue on ARM architecture](https://github.com/influxdata/flux/issues/2505)** in `mean` and `query` functions

As a workaround, MyController uses two type of InfluxDB query clients.
- `v1` - uses [InfluxQL](https://docs.influxdata.com/influxdb/v1.8/query_language/explore-data/) query language
- `v2` - uses [Flux](https://docs.influxdata.com/influxdb/v2.0/query-data/get-started/) query language
{{< /alert >}}

```yaml
name: influxdb_v1.8_local # (1)
type: influxdb_v2 # (2)
uri: http://192.168.1.21:8086 # (3)
token: # (4)
username: # (5)
password: # (6)
organization: # (7)
bucket: mc_db # (8)
query_client_version: # (9)
batch_size: # (10)
flush_interval: 1s # (11)
```
1. `name` of the database, should be a unique name
2. `type` should be `influxdb_v2`
3. `uri` is the database connection URI
4. `token` - authentication token used in InfluxDB 2.x
5. `username` - authenticate using username and password
6. `password` - authenticate using username and password. If `username` specified `password` is a mandatory field.
7. `organization` - used in InfluxDB 2.x
8. `bucket` - database name used for MyController. In InfluxDB 2.x it is called `bucket`
9. `query_client_version` - MyController uses two type of query clients.
   It is recommended to keep it blank. MyController can choose automatically based the the database version used.
   However we can override the automatic selection by providing one for the option,
    - `v1` - InfluxDB 1.8.x
    - `v2` - InfluxDB 2.x
10. `batch_size` - sends the metrics to InfluxDB when meets the batch size
11. `flush_interval` - sends the metrics to InfluxDB when meets the interval

###### Sample of Cloud InfluxDB Configuration
```yaml
name: influxdb_v2_cloud
type: influxdb_v2
uri: https://eu-central-1-1.aws.cloud2.influxdata.com
token: VGhpcyBpcyBmYWtlIHRva2VuLCB0YWtlIHlvdXIgZnJvbSBNb25nb0RCIGNsb3VkCg==
organization: example@example.com
bucket: mc_bkt
batch_size:
flush_interval: 1s
```

{{< alert title="Note">}}
[MongoDB Cloud](https://www.mongodb.com/cloud/atlas) offers free services for small applications.
{{< /alert >}}

