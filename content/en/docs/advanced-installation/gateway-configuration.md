---
title: "Gateway Configuration"
linkTitle: "Gateway Configuration"
weight: 2
---

MyController gateway configurations are loaded at the time of startup.
Configurations should be in the **[YAML](https://yaml.org/)** file format.


## gateway.yaml
Refer [backend configuration detailed guide](/docs/advanced-installation/backend-configuration/) to know about the configurations

```yaml
logger:
  mode: development
  encoding: console
  level:
    core: info
    storage: info
    metrics: warn

directories:
  data: /mc_home/data
  logs: /mc_home/logs
  tmp: /mc_home/tmp

bus:
  type: natsio
  topic_prefix: mc_production
  server_url: nats://192.168.1.21:4222
  tls_insecure_skip_verify: false
  connection_timeout: 10s

gateway: # (6)
  ids: []
  labels:
    location: external_gw1
```