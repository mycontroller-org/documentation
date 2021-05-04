---
title: "MySensors"
linkTitle: "Gateway MySensors"
weight: 3
---

[MySensors](https://www.mysensors.org/) is an open source hardware and software community focusing on do-it-yourself home automation and Internet of Things.

To know more about MySensors network [follow this link](https://www.mysensors.org/about/network)

#### Key points
* In a network MySensors can have 254 nodes
* node id `0` is always a gateway node
* node id `1` to `254` can be allocatable to any node
* Notable supported actions in MyController
  * `OTA`features
  * `reboot`
  * `reset`
  * get node info
  * discover nodes

### MQTT Gateway Sample configuration
{{< alert title="Note" >}}
The `id` attribute can not be changed later
{{< /alert >}}
* Form view
  ![gateway-mysensors](/doc-images/gateway-mysensors.png)

* YAML View
  ```yaml
  id: mysensor # (1)
  description: MySensors gateway
  enabled: true # (2)
  reconnectDelay: 15s # (3)
  provider:
    type: mysensors_v2 # (4)
    timeout: 1s # (5)
    retryCount: 3 # (6)
    enableInternalMessageAck: true # (7)
    enableStreamMessageAck: false #(8)
    protocol:
      type: mqtt # (9)
      broker: tcp://192.168.1.21:1883 # (10)
      insecureSkipVerify: false # (11)
      username: '' # (12)
      password: '' # (13) 
      qos: 0 # (14)
      subscribe: out_rfm69/# # (15)
      publish: in_rfm69 # (16)
      transmitPreDelay: 15ms # (17)
      reconnectDelay: 30s # (18)      
  messageLogger:
    type: file_logger # (19)
    flushInterval: 5s # (20)
    logRotateInterval: 6h # (21)
    maxAge: 24h # (22)
    maxBackup: 3 # (23)
    maxSize: 1MiB # (24)
  labels: # (25)
    location: core # (26)
  ```

  ###### Configuration details
  1. `id` of a gateway. You cannot modify this field later
  2. `enabled` - You can disable to disconnect from provider network.
  3. `reconnectDelay` - for some reason disconnected from the provider network, will be reconnected automatically after this delay
  4. `provider.type` says the type of the provider
  5. `provider.timeout` wait for the acknowledgement till this timeout
  6. `provider.retryCount` if do not receive acknowledgement on the specified `provider.timeout` keep resend the message till reaches this count
  7. `provider.enableInternalMessageAck` enable acknowledgement for internal messages
  8. `provider.enableStreamMessageAck` enable acknowledgement for streaming messages. ie: firmware messages
  9. `provider.protocol.type` MySensors supports 3 type of protocols. `MQTT`, `Serial`, and `Ethernet`
  10. `provider.protocol.broker` mqtt broker url
  11. `provider.protocol.insecureSkipVerify` if you want to skip the insecure ssl, enable this option
  12. `provider.protocol.username` username of the mqtt broker. if it is `anonymous` leave it as a blank
  13. `provider.protocol.password` if username supplied, password should be supplied. otherwise leave it as a blank
  14. `provider.protocol.qos` MQTT qos
  15. `provider.protocol.subscribe` topic to be subscribed to get messages from MySensors gateway
  16. `provider.protocol.publish` topic to be used to post data from MyController to MySensors network
  17. `provider.protocol.transmitPreDelay` wait till this time and sends the data to provider network
  18. `provider.protocol.reconnectDelay` this field will be deprecated
  19. `messageLogger.type` message logger type. support `file_logger` and `none`
  20. `messageLogger.flushInterval` how long once received message to be dumped to disk from memory
  21. `messageLogger.logRotateInterval` creates new file after this interval
  22. `messageLogger.maxSize` if the size reaches the `maxSize`, creates new file
  23. `messageLogger.maxAge`  if the age reaches the `maxAge`, creates new file
  24. `messageLogger.maxBackup` retention files count
  25. `labels` labels are a key value pair used across the system
  26. `labels.location` this particular gateway loaded to a gateway where the label matches

### Serial Gateway Sample configuration
Restricted to only serial config. For other fields on the [MQTT Gateway Config](/docs/user-interface/resources/gateway-mysensors/#mqtt-gateway-sample-configuration)

* Form view
  ![gateway-mysensors-serial](/doc-images/gateway-mysensors-serial.png)

* YAML View
  ```yaml
  provider:
    protocol:
      type: serial # (1)
      transmitPreDelay: 15ms # (2)
      portname: /dev/ttyUSB0 # (3)
      baudrate: 115200 # (4)
  ```
###### Configuration details
1. `provider.protocol.type` type of the gateway. here it is serial gateway
2. `provider.protocol.transmitPreDelay`  wait till this time and sends the data to provider network, can be used to avoid collision on the provider network
3. `provider.protocol.portname` name of the serial port
4. `provider.protocol.baudrate` baud rate of the serial port

### Ethernet Gateway Sample configuration
Restricted to only ethernet config. For other fields on the [MQTT Gateway Config](/docs/user-interface/resources/gateway-mysensors/#mqtt-gateway-sample-configuration)
* Form view
  ![gateway-mysensors-serial](/doc-images/gateway-mysensors-ethernet.png)

* YAML View
  ```yaml
  provider:
    protocol:
      type: ethernet # (1)
      transmitPreDelay: 15ms # (2)
      server: tcp://192.168.1.42 # (3)
  ```

###### Configuration details
1. `provider.protocol.type` type of the gateway. here it is serial gateway
2. `provider.protocol.transmitPreDelay`  wait till this time and sends the data to provider network, can be used to avoid collision on the provider network
3. `provider.protocol.server` tcp server url
