---
title: "Gateway"
linkTitle: "Gateway"
weight: 2
---

MyController supports different type is providers network.
Each network can be connected to MyController via a gateway.

Gateway can be added/updated/deleted from the `Resources >> Gateway` page

### [Supported Providers list](/docs/overview/#supported-providers)

### Common Configurations
* Form View
  ![gateway-settings](/doc-images/gateway-settings.png)

* YAML View
  ```yaml
  id: mysensor # (1)
  description: MySensors gateway # (2)
  enabled: true # (3)
  reconnectDelay: 15s # (4)
  labels: # (5)
    location: core # (6)
  ```
  1. `id` of the gateway. You cannot modify this field later
  2. `description` of the gateway
  3. `enabled` - You can enable or disable to disconnect from provider network.
  4. `reconnectDelay` - if the gateway disconnected from the provider network for some reason, will be reconnected automatically after this delay
  5. `labels` - labels are a key value pair used across the system
  6. `labels.location` this is a kind of filter used to restrict to run this gateway to a specific location(s)

{{< alert title="Note" >}}
The `id` field can not be changed later
{{< /alert >}}

### Provider Configurations
* [MySensors](/docs/user-interface/resources/gateway-mysensors/)
* [Tasmota](/docs/user-interface/resources/gateway-tasmota/)

### Message Logger Configurations
Message logger is recording received and transmitted messages.

Type of `Message Logger`
* `None` - disable message logging system
* `File Logger` - records the messages into a file (disk)

{{< alert title="Note" >}}
This feature is available for all selected providers.
{{< /alert >}}

* Form View
  ![gateway-settings](/doc-images/gateway-message-logger.png)

* YAML View
  ```yaml
   messageLogger:
    type: file_logger # (1)
    flushInterval: 5s # (2)
    logRotateInterval: 6h # (3)
    maxSize: 1MiB # (4)
    maxAge: 24h # (5)
    maxBackup: 3 # (6)
  ```
  1. `messageLogger.type` message logger type. support `file_logger` and `none`
  2. `messageLogger.flushInterval` how long once received message to be dumped to disk from memory
  3. `messageLogger.logRotateInterval` creates new file after this interval
  4. `messageLogger.maxSize` if the size reaches the `maxSize`, creates new file
  5. `messageLogger.maxAge`  if the age reaches the `maxAge`, creates new file
  6. `messageLogger.maxBackup` retention files count
