---
title: "Gateway Configuration"
linkTitle: "Gateway Configuration"
weight: 2
---

MyController gateway configurations are loaded at the time of startup.<br>
Configurations should be in the **[YAML](https://yaml.org/)** file format.


## gateway.yaml
Refer [backend configuration detailed guide](/docs/advanced-installation/backend-configuration/) to know about the configurations

```yaml
# This secret should be same as given in the server configuration file.
secret: 5a2f6ff25b0025aeae12ae096363b51a

directories:
  data: /mc_home/data
  logs: /mc_home/logs
  tmp: /mc_home/tmp

logger:
  mode: record_all
  encoding: console
  level:
    core: info
    storage: info
    metric: warn

bus:
  type: natsio
  topic_prefix: mc_production
  server_url: nats://192.168.1.21:4222
  insecure: false
  connection_timeout: 10s

gateway:
  disabled: false
  types: []
  ids: []
  labels:
    location: external_gw1
```