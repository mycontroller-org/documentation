---
title: "Backend Configuration"
linkTitle: "Backend Configuration"
weight: 1
---

MyController backend configurations are loaded at the time of startup.<br>
Configurations should be in the **[YAML](https://yaml.org/)** file format.<br>
Samples are available in the [source code repository](https://github.com/mycontroller-org/server/tree/{{< variable "versionTag" >}}/resources)

{{< alert title="Note">}}
`mycontroller.yaml` file will not be included in the backup for the security reasons.
{{< /alert >}}


## mycontroller.yaml

```yaml
secret: 5a2f6ff25b0025aeae12ae096363b51a # (1)

analytics: # (2)
  enabled: true 

web: # (3)
  web_directory: /ui
  enable_profiling: false
  read_timeout: 60s
  http:
    enabled: true 
    bind_address: "0.0.0.0"
    port: 8080
  https_ssl:
    enabled: false
    bind_address: "0.0.0.0"
    port: 8443
    cert_dir: /mc_home/certs/https_ssl
  https_acme:
    enabled: false
    bind_address: "0.0.0.0"
    port: 9443
    cache_dir: /mc_home/certs/https_acme
    acme_directory:
    email: hello@example.com
    domains: ["mycontroller.example.com"]

logger: # (4)
  mode: record_all
  encoding: console
  level:
    core: info
    web_handler: info
    storage: info
    metric: warn

directories: # (5)
  data: /mc_home/data
  logs: /mc_home/logs
  tmp: /mc_home/tmp
  secure_share: /mc_home/secure_share
  insecure_share: /mc_home/insecure_share

bus: # (6)
  type: natsio
  topic_prefix: mc_production
  server_url: nats://192.168.1.21:4222
  insecure: false
  connection_timeout: 10s

gateway: # (7)
  disabled: false
  types: []
  ids: []
  labels:
    location: server

handler: # (8)
  disabled: false
  types: []
  ids: []
  labels:
    location: server

database: # (9)
  storage:
    type: memory
    dump_enabled: true
    dump_interval: 10m
    dump_dir: "memory_db"
    dump_format: ["yaml"] # options: yaml, json
    load_format: "yaml"

  metric:
    disabled: true
    type: influxdb
    uri: http://192.168.1.21:8086
    token: 
    username:
    password:
    organization_name: 
    bucket_name: mycontroller
    batch_size:
    flush_interval: 5s
    query_client_version:
```
1. `secret` is used to encrypt the password, token and other sensitive details in gateways, handlers, etc., and keep encrypted data in the storage database.<br>
   At later point if you change the `secret` you have update manually the existing passwords and tokens if any<br>
   Uses [AES-256](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard) encryption then base64 encoding
2. `analytics` if enabled, reports anonymous statics to MyController analytics collector
3. `web` holds the [web configurations](#web-configuration)
4. `logger` - controls the logs level of a [different components](#logger).
5. `directories` - points to [custom locations](#directories).
6. `bus` - [message bus configurations](#message-bus), will be used for internal communications.
7. `gateway` - [filters](#gateway) to load gateways to this instance.
8. `handler` - [filters](#handler) to load handlers to this instance.
9. `database` - defines `storage` and `metric` configuration details

### Web Configuration
```yaml
web:
  web_directory: /ui # (1)
  documentation_url: http://192.168.1.21:8079/docs/ # (2)
  enable_profiling: false # (3)
  http: # (4)
    enabled: true 
    bind_address: "0.0.0.0"
    port: 8080
  https_ssl: # (5)
    enabled: false
    bind_address: "0.0.0.0"
    port: 8443
    cert_dir: /mc_home/certs/https_ssl
  https_acme: # (6)
    enabled: false
    bind_address: "0.0.0.0"
    port: 9443
    cache_dir: /mc_home/certs/https_acme
    acme_directory:
    email: hello@example.com
    domains: ["mycontroller.example.com"]
```
1. `web_directory` - production build of [Web Console](https://github.com/mycontroller-org/console-web)
2. `documentation_url` - if you are in a private environment and want to keep the document server locally. Add your documentation server url.<br>
   In MyController server default documentation url will be replaced with this url.
3. `enable_profiling` - enables [GoLang profiling](https://golang.org/pkg/net/http/pprof/) on the http handler at `/debug/pprof/`
4. `http` - [HTTP handler](#http-handler)
5. `https_ssl` - [HTTPS SSL handler](#https-ssl-handler)
6. `https_acme` - [HTTPS ACME handler](#https-acme-handler)

#### HTTP handler
HTTP handler serves the `web console` and `api` as un-encrypted.<br>
This setup can be used in a trusted network.
```yaml
http:
  enabled: true # (1)
  bind_address: "0.0.0.0" # (2)
  port: 8080 # (3)
```
1. `enabled` - can enable or disable the http handler. if no values supplied, will be treated as disabled
2. `bind_address` - IP address to bind, `0.0.0.0` - binds to all the available network interfaces.
3. `port` - listening port number

#### HTTPS SSL handler
HTTPS SSL handler serves the `web console` and `api` as encrypted.<br>
You can use self signed certificate or CA signed certificate.<br>
You can use this handler to access the web console on the untrusted networks
```yaml
https_ssl:
  enabled: false # (1)
  bind_address: "0.0.0.0" # (2)
  port: 8443 # (3)
  cert_dir: /mc_home/certs/https_ssl # (4)
```
1. `enabled` - can enable or disable the https ssl handler. if no values supplied, will be treated as disabled
2. `bind_address` - IP address to bind, `0.0.0.0` - binds to all the available network interfaces.
3. `port` - listening port number
4. `cert_dir` - certificate and key files location.

`https_ssl` operates in two modes.
  * [Generate the certificates automatically](#generate-the-certificates-automatically)
  * [Custom certificate](#custom-certificate)
##### Generate the certificates automatically
If there is no `custom.crt` and `custom.key` found on the `cert_dir` location MyController generates a crt and key files and stores on `cert_dir` location. Auto generated file names will as `mc_generated.crt` and `mc_generated.key`.

Auto generated certificate details:
* RSA Bits - 2048
* Organization name - MyController.org
* Validity - 365 days

If you want to change these details, you have to generate a certificate manually as mentioned in [Custom certificate](#custom-certificate)

##### Custom certificate
If you want to use your custom certificates, you have to place your files on the `cert_dir` location.
The name of the files must be as `custom.crt` and `custom.key`

To generate self signed certificate there are multiple options available. Here is a quick sample,
```bash
openssl genrsa -out custom.key 2048
openssl req -new -x509 -sha256 -key custom.key -out custom.crt -days 365
```

{{< alert title="Important" color="danger">}}
If `custom.crt` and `custom.key` files are present in the `cert_dir`, it get the higher precedence than the auto generated files.
{{< /alert >}}

#### HTTPS ACME handler
Automated Certificate Management Environment (ACME) is a standard protocol for automating domain validation, installation, and management of X.509 certificates.<br>
[Letsencrypt]((https://letsencrypt.org/getting-started/)) is popular free certificate provider.

This handler can take care of the life cycle of the certificate. That is to get the certificate first time and subsequence renewals.

* The default ACME directory url will be pointing to letsencrypt, https://acme-v02.api.letsencrypt.org/directory
* The certificates will be renewed 30 days prior to expiration
* ACME challenge will be verified using `tls-alpn-01`. Extra port is not required.
  To know more about `tls-alpn-01` visit [Letsencrypt guide](https://letsencrypt.org/docs/challenge-types/#tls-alpn-01)
* You have to configure port forward to the `https_acme` port. This port should be reachable on public ip of `443` port. acme challenge will be verified only on `443` port.

```yaml
https_acme:
  enabled: false # (1)
  bind_address: "0.0.0.0" # (2)
  port: 9443 # (3)
  cache_dir: /mc_home/certs/https_acme # (4)
  acme_directory: # (5)
  email: hello@example.com # (6)
  domains: ["mycontroller.example.com"] # (7)
```
1. `enabled` - can enable or disable the https acme handler. if no values supplied, will be treated as disabled
2. `bind_address` - IP address to bind, `0.0.0.0` - binds to all the available network interfaces.
3. `port` - listening port number
4. `cache_dir` - certificate and related files received from the provider will be stored on this directory.
5. `acme_directory` - ACME provider directory url, if you leave it blank the default will be https://acme-v02.api.letsencrypt.org/directory
6. `email` - email address used to get the certificate from the provide
7. `domains` - You can have single or multiple domains

### Logger
```yaml
logger:
  mode: record_all # (1)
  encoding: console # (2)
  enable_stacktrace: false # (3)
  level: # (4)
    core: info
    web_handler: info
    storage: info
    metric: warn
```
1. `mode` - supports two modes.
   - `record_all` - prints the detailed information about the log fields
   - `sampled` - prints the restricted information about the log fields and not all the logs
2. `encoding` - log encoding format
   - `console` - suits for console display
   - `json` - prints logs in json format, suits for processing with external tools
3. `enable_stacktrace` - enables stack trace of the error
4. `level` - restrict the log level. supported levels: `debug`, `info`, `warn`, `error`, `fatal`.
   You can restrict the log level to a specific service.
   - `core` - entire system log level. This is applicable for gateway service too.
   - `web_handler` - http handlers log level
   - `storage` service log level
   - `metrics` service log level

### Directories
```yaml
directories:
  data: /mc_home/data # (1)
  logs: /mc_home/logs # (2)
  tmp: /mc_home/tmp # (3)
  secure_share: /mc_home/secure_share # (4)
  insecure_share: /mc_home/insecure_share # (5)
```
MyController uses these directories to keep configurations, logs, and temporary files.
1. `data` - keeps all configurations on this location. in-memory database, firmware, etc.,
2. `logs` - keeps gateway logs and system logs
3. `tmp` - used as a temporary location for MyController services
4. `secure_share` - you can keep custom files on this location. This location can be accessed via MyController instance url, `http://mycontroller-ip:8080/secure_share`. It needs authentication. access token can be supplied via header or on the url.
5. `insecure_share` - you can keep custom files on this location. This location can be accessed via MyController instance url, `http://mycontroller-ip:8080/insecure_share`. **It is open to everyone. Authentication not required**

### Message Bus
```yaml
bus:
  type: natsio # (1)
  topic_prefix: mc_production # (2)
  server_url: nats://192.168.1.21:4222 # (12)
  insecure: false # (3)
  connection_timeout: 10s # (4)
```
1. `type` - There are two type of [message bus](/docs/overview/architecture/#message-bus) available.
   - `embedded` - internal message bus. You cannot include external gateway
   - `natsio` - external message bus
2. `topic_prefix` - A natsio message bus can be used for different applications.
   Based on this topics we can separate a specific MyController instance.
3. `server_url` - natsio server url
4. `insecure` - allow or disallow insecure connections
5. `connection_timeout` - connection establishment timeout

{{< alert title="Important" color="danger">}}
When you use external gateway service.
You should use external message bus service(natsio)
Also should use the same message bus configurations in the MyController instance and in the external gateway instances.
{{< /alert >}}


### Gateway
```yaml
gateway:
  disabled: false # (1)
  types: [] # (2)
  ids: [] # (3)
  labels: # (4)
    location: server
```
We can restrict to load a specific gateway to this service.
1. `disabled` - enables or disables gateway service
2. `types` - filter specific gateway types
3. `ids` - filtered by list of gateways id
4. `labels` - filtered based on the labels. [detailed guide](/docs/user-interface/resources/gateway/#power-of-the-labels)

{{< alert title="Note">}}
Empty filter loads all the gateways.
{{< /alert >}}

### Handler
```yaml
handler:
  disabled: false # (1)
  types: [] # (2)
  ids: [] # (3)
  labels: # (4)
    location: server
```
We can restrict to load a specific handler to this service.
1. `disabled` - enables or disables handler service
2. `types` - filter specific handler types
3. `ids` - filtered by list of handlers id
4. `labels` - filtered based on the labels. [detailed guide](/docs/user-interface/resources/gateway/#power-of-the-labels)

{{< alert title="Note">}}
Empty filter loads all the handlers.
{{< /alert >}}

### Database
You can define you `storage` and `metric` database configurations

```yaml
database:
  storage:
    # storage database configurations
  metric:
    # metric database configurations
```
MyController needs two type of databases.
1. [Storage](#storage-databases)
2. [Metric](#metric-databases)

#### Storage Databases
MyController supports two type of storage databases
- [Memory](#in-memory-database)
- [MongoDB](#mongodb-database)

##### In Memory Database
In memory is a special database designed by MyController org.
It keeps all the configuration data in the memory(RAM).
Dumps all the data into the disk on a specified interval.
When MyController start up, loads all the data from the disk to memory.

* We can reduce the number of writes to disk. This can increase the life time of the disk.
* This is very good choice for a tiny hardwares(ie: Raspberry PI with memory card as disk).
* Memory database will be faster as the entities are in memory(RAM).

{{< alert title="Important" color="danger">}}
**Assuming dump enabled**<br>
When the MyController server terminated gracefully, dumps all the configuration data onto the disk.<br>
So there will be no loss.<br>
However there will be some loss, if the service terminated forcefully or power plug removed.
{{< /alert >}}

```yaml
database:
  storage:
    type: memory # (1)
    dump_enabled: true # (2)
    dump_interval: 10m # (3)
    dump_dir: "memory_db" # (4)
    dump_format: ["yaml", "json"] # (5)
    load_format: "yaml" # (6)
```
1. `type` should be `memory`
2. `dump_enabled` - enable or disable sync to disk feature. Copies in memory entities into disk
3. `dump_interval` - how long once the sync should happen.
4. `dump_dir` - directory used to dump entities from memory. default: `memory_db`
5. `dump_format` - supports `yaml` and/or `json` formats.
6. `load_format` - even though you can dump entities on `yaml` and/or `json` format. at the time of startup, only one format can be used. Make sure you are using this format on the `dump_format`

##### MongoDB Database
MyController supports MongoDB local or cloud version.

```yaml
type: mongodb # (1)
database: mcdb # (2)
uri: mongodb://192.168.1.21:27017 # (3)
```
1. `type` should be `mongodb`
2. `database` - name of the database in your MongoDB
3. `uri` of the database. supports cloud database format too.


#### Metric Databases
MyController supports two type of metric databases
- [Void](#in-memory-database)
- [InfluxDB](#mongodb-database)

##### InfluxDB
MyController uses InfluxDB to keep the metrics data. It can be local InfluxDB instance or can be in the cloud.<br>
MyController supports InfluxDB **1.8.4 or above** versions.

{{< alert title="Note">}}
Flux query supports for InfluxDB 1.8.x and InfluxDB 2.x, <br>
however there is an **[issue on ARM architecture](https://github.com/influxdata/flux/issues/2505)** in `mean` and `query` functions<br>
As a workaround, MyController uses two type of InfluxDB query clients.
- `v1` - uses [InfluxQL](https://docs.influxdata.com/influxdb/v1.8/query_language/explore-data/) query language
- `v2` - uses [Flux](https://docs.influxdata.com/influxdb/v2.0/query-data/get-started/) query language
{{< /alert >}}

```yaml
database:
  metric:
    disabled: false # (1)
    type: influxdb # (2)
    uri: http://192.168.1.21:8086 # (3)
    token: # (4)
    username: # (5)
    password: # (6)
    organization_name: # (7)
    bucket_name: mc_db # (8)
    query_client_version: # (9)
    batch_size: # (10)
    flush_interval: 1s # (11)
```
1. `disabled` if you want to disable metric database
2. `type` should be `influxdb`
3. `uri` is the database connection URI
4. `token` - authentication token used in InfluxDB 2.x
5. `username` - authenticate using username and password
6. `password` - authenticate using username and password. If `username` specified `password` is a mandatory field.
7. `organization_name` - used in InfluxDB 2.x
8. `bucket_name` - In influxdb 1.x it is a database name. In influxdb 2.x it is called bucket
9. `query_client_version` - MyController uses two type of query clients.
   It is recommended to keep it blank. MyController can choose automatically based the the database version used.
   However we can override the automatic selection by providing one for the option,
    - `v1` - InfluxDB 1.8.x
    - `v2` - InfluxDB 2.x
10. `batch_size` - sends the metrics to InfluxDB when meets the batch size
11. `flush_interval` - sends the metrics to InfluxDB when meets the interval

###### Sample of Cloud InfluxDB Configuration
```yaml
database:
  metric:
    disabled: false
    type: influxdb
    uri: https://eu-central-1-1.aws.cloud2.influxdata.com
    token: VGhpcyBpcyBmYWtlIHRva2VuLCB0YWtlIHlvdXIgZnJvbSBNb25nb0RCIGNsb3VkCg==
    username: 
    password: 
    organization_name: example@example.com
    bucket_name: mc_bkt
    query_client_version: 
    batch_size: 
    flush_interval: 1s
```

{{< alert title="Note">}}
[MongoDB Cloud](https://www.mongodb.com/cloud/atlas) offers free services for small applications.
{{< /alert >}}

