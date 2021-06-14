---
title: "Getting Started"
linkTitle: "Getting Started"
weight: 2
---

## Prerequisites
Installation can be done in two different methods,
* Run from the executable binary bundles
* Run it as a container

### Hardware Requirements
* Disk Space: ~100 MiB
* Memory(RAM): ~50 MiB

### Software Requirements
* InfluxDB - used as a metric store
* Optional
  * Docker or any container orchestration (if you plan to run it the MyController container image)
  * MongoDB - used as a entity store

## Dependencies Installation
* [InfluxDB](/docs/getting-started/install-influxdb/)
* [Docker](/docs/getting-started/install-docker/)
* [natsio Bus](/docs/getting-started/install-natsio/)
* [Mosquitto MQTT Broker](/docs/getting-started/install-mosquitto/)

## Migrating to MyController 2.0
* MyController 2.0 is completely redesigned.
* You can not migrate from MyController 1.x to 2.0
* However for sometime you can run 1.x and 2.0 simultaneously to migrate your automation
* If you are using MySensors serial port to connect your sensors use [2mqtt](https://github.com/mycontroller-org/2mqtt) to share your connection to 1.x and 2.0

## Install MyController Server
* [Quick Installation](/docs/quick-installation/)
* [Advanced Installation](/docs/advanced-installation/)

## What Next?
* [Hints](/docs/getting-started/hints/)