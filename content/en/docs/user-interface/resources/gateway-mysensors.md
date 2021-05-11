---
title: "MySensors"
linkTitle: "Gateway MySensors"
weight: 3
---

[MySensors](https://www.mysensors.org/) is an open source hardware and software community focusing on do-it-yourself home automation and Internet of Things.
To know more about MySensors network [follow this link](https://www.mysensors.org/about/network)

## Provider Specific key points
* In a network MySensors can have maximum of 254 nodes
* node id `0` is always a gateway node
* node id `1` to `254` can be allocatable to any node
* Supported features in MyController
  * `OTA`features / Firmware update
  * `reboot` a node
  * `reset` a node
  * get a node info
  * discover nodes
  * `Heartbeat` request
  * Response to internal message like `I_TIME`, `I_CONFIG`, `I_ID_REQUEST`
  * Assigns NodeId if nodeId set as `AUTO` on a node

### Not implemented / supported features (that is supported on MyController 1.x)
  * Handle sleeping nodes
  * There is no node alive check

## Common Configuration
* Form view
  ![gateway-mysensors-provider](/doc-images/gateway-provider-mysensors.png)

* YAML View
  ```yaml
  provider:
    type: mysensors_v2 # (1)
    enableInternalMessageAck: true # (2)
    enableStreamMessageAck: false # (3)
    retryCount: 3 # (4)
    timeout: 1s # (5)
  ```
  1. `type` should be selected as `mysensors_v2`
  2. `enableInternalMessageAck` enable acknowledgement for internal messages
  3. `enableStreamMessageAck` enable acknowledgement for streaming messages. ie: OTA/firmware messages  
  4. `retryCount` - if do not receive the acknowledgement on the specified `timeout`, keeps resend the message till it reaches the retryCount 
  5. `timeout` - wait for the acknowledgement till this timeout

## Protocols
MySensors gateway supports the following protocols
  - [MQTT](#protocol-configuration---mqtt)
  - [Serial](#protocol-configuration---serial)
  - [Ethernet](#protocol-configuration---ethernet)

### Protocol Configuration - MQTT
* Form view
  ![gateway-mysensors](/doc-images/gateway-mysensors-mqtt.png)

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
      subscribe: out_rfm69/# # (7)
      publish: in_rfm69 # (8)
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
It is important to include `/#` at the end of `subscription` topic to receive from all the nodes. *example: `out_rfm69/#`*
{{< /alert >}}

### Protocol Configuration - Serial
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
  1. `type` of the protocol. here it should be `serial`
  2. `transmitPreDelay` - wait till this time to avoid collision and sends the data to provider network
  3. `portname` name of the serial port
  4. `baudrate` baud rate of the serial port

### Protocol Configuration - Ethernet
* Form view
  ![gateway-mysensors-serial](/doc-images/gateway-mysensors-ethernet.png)

* YAML View
  ```yaml
  provider:
    protocol:
      type: ethernet # (1)
      transmitPreDelay: 15ms # (2)
      server: tcp://192.168.1.42:5000 # (3)
      insecureSkipVerify: false # (4)
  ```
  1. `type` of the protocol. here it should be `ethernet`
  2. `transmitPreDelay` - wait till this time to avoid collision and sends the data to provider network
  3. `server` ethernet server address with port
  4. `insecureSkipVerify` if you want to skip the insecure ssl, enable this option
