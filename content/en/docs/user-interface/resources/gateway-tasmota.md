---
title: "Tasmota"
linkTitle: "Gateway Tasmota"
weight: 4
---

[Tasmota](https://tasmota.github.io/docs/) is an Open source firmware for ESP8266 devices

### Common Configuration
* Form view
  ![gateway-provider-tasmota](/doc-images/gateway-provider-tasmota.png)

* YAML View
  ```yaml
  provider:
    type: tasmota # (1)
  ```
  1. `type` should be selected as `tasmota`

### Protocols
Tasmota gateway supports the following protocols
  - [MQTT](#protocol-configuration---mqtt)

#### Protocol Configuration - MQTT
* Form view
  ![gateway-tasmota-mqtt](/doc-images/gateway-tasmota-mqtt.png)

* YAML View
  ```yaml
  provider:
    protocol:
      type: mqtt # (1)
      transmitPreDelay: 15ms # (2)
      broker: tcp://192.168.1.21:1883 # (3)
      insecureSkipVerify: false # (4)
      username: '' # (5)
      password: '' # (6)
      subscribe: jktasmota/# # (7)
      publish: jktasmota # (8)
      qos: 0 # (9)
  ```
  1. `type` type of the protocol. here it should be `mqtt`
  2. `transmitPreDelay` - wait till this time to avoid collision and sends the data to provider network
  3. `broker` mqtt broker url
  4. `insecureSkipVerify` if you want to skip the insecure ssl, enable this option
  5. `username` username of the mqtt broker. if it is `anonymous` leave it as a blank
  6. `password` if username supplied, password should be supplied. otherwise leave it as a blank
  7. `subscribe` topic to be subscribed to get messages from MySensors gateway
  8. `publish` topic to be used to post data from MyController to MySensors network
  9. `qos` MQTT qos

{{< alert title="Note" >}}
It is important to include `/#` at the end of `subscription` topic to receive form all the nodes. *example: `jktasmota/#`*
{{< /alert >}}

### MQTT configuration on the Tasmota node
![tasmota-node](/doc-images/gateway-tasmota-node.png)

The following changes needs to be updated on the Tasmota node MQTT settings to connect with MyController
* `Topic` - should be updated as `tasmota_%06X`
* `Full Topic` - should be updated as `jktasmota/%prefix%/%topic%/`
  * here `jktasmota` can be any name, should be in lowercase and special characters are not allowed

To know more about MQTT settings on Tasmota [follow this guide](https://tasmota.github.io/docs/MQTT/)
