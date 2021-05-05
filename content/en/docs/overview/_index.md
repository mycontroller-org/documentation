---
title: "Overview"
linkTitle: "Overview"
weight: 1
description: ""
---
MyController.org is an IoT automation controller for home, office or any place. MyController.org is designed to run with limited resources. It can run on the first generation Raspberry PI.

MyController 2.x is completely redesigned.

## Technologies
* Backend
  * [GoLang](https://golang.org/)
  * [Nats.io](https://nats.io/) - Message Bus
* Databases
  * Storage
    * In-Memory - developed and maintained by MyController.org
    * [MongoDB](https://www.mongodb.com/)
  * Metrics
    * [InfluxDB](https://www.influxdata.com/products/influxdb/)
* Frontend - Web Console
  * [ReactJS](https://reactjs.org/)
  * [PatternFly](https://www.patternfly.org/)
  * [react-grid-layout](https://github.com/react-grid-layout/react-grid-layout) - Dashboard
* Documentation
  * [HUGO](https://gohugo.io/)
  * [docsy](https://www.docsy.dev/)

## [Architecture Guide](/docs/overview/architecture/)

## MyController Services and Bundles
MyController has many services and all communicates via `Message Bus`.

Based on the services and use cases, MyController bundled as follows,
  - [All-In-One bundle](#all-in-one-bundle-and-setup)
  - [Core bundle](#core-bundle-and-setup)
  - [Gateway bundle](#gateway-bundle-and-setup)

### All-In-One bundle and setup
![all-in-one setup](/doc-images/all-in-one-setup.png)
* **This is the most suitable package for most of the use cases**
* This package contains MyController Core services + Gateway service
* All the services combined and bundled as single binary
* With All-In-One package it is possible to use `Embedded` Bus, which cannot be accessible outside of the MyController server (**Options #1**)
* If you plan to use `external gateway` you have to go with [external bus service (natsio)](/docs/getting-started/install-natsio/) (**Option #2**)

### Core bundle and setup
![core setup](/doc-images/core-setup.png)
* This package contains MyController Core services only. Gateway service excluded
* It is mandatory to run external bus service for this setup to join a gateway

### Gateway bundle and setup
![gateway setup](/doc-images/gateway-setup.png)
* This package contains only gateway service component
* This service can be connected to a `Core Service` or `All-In-One service` via a external message bus.
* You can have a multiple gateway services on a different hosts

## Supported Providers
* [MySensors.org](https://www.mysensors.org/)
* [Tasmota](https://tasmota.github.io/)
* [Philips Hue](https://www.philips-hue.com/en-in)
* `System Monitoring` provided by MyController
  * Metrics of CPU, Memory, Disk, process, etc.,


## What next?
* [Getting Started](/docs/getting-started/)

