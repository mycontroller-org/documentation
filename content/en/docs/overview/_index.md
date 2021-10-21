---
title: "Overview"
linkTitle: "Overview"
weight: 1
---

MyController is an IoT automation controller for home, office or any place.<br>
There is no internet requirement for the MyController.
You can run the complete setup on your private environment<br>
MyController is designed to run with a limited resources.
It can run on the first generation of the Raspberry PI.<br>

MyController 2.x is completely redesigned. You can not upgrade from MyController 1.x

## Technologies Used
* Backend
  * [GoLang](https://golang.org/)
  * [Nats.io](https://nats.io/) - Message Bus
* Supported Databases
  * Storage
    * [In-Memory](https://github.com/mycontroller-org/server/tree/master/plugin/database/storage/memory) - developed and maintained by MyController community
    * [MongoDB](https://www.mongodb.com/)
  * Metric
    * [InfluxDB](https://www.influxdata.com/products/influxdb/)
* Frontend - Web Console
  * [ReactJS](https://reactjs.org/)
  * [PatternFly](https://www.patternfly.org/) - Web Console
  * [react-grid-layout](https://github.com/react-grid-layout/react-grid-layout) - Dashboard
* Documentation
  * [gohugo](https://gohugo.io/)
  * [docsy](https://www.docsy.dev/)

## [Architecture Guide](/docs/overview/architecture/)

## MyController Services and Bundles
MyController has many services and all communicates via `Message Bus`.<br>
Based on the services and use cases, MyController bundled as follows,
  - [Server](#server-setup)
  - [Gateway](#gateway-setup)
  - [Handler](#handler-setup)

### Server Setup
![server setup](/doc-images/server-setup.png)
* This package contains MyController Server + Gateway + Handler services
* All the services combined and bundled as single binary
* As it has all the services in a single binary, It is possible to use `embedded` Bus, which cannot be accessible outside of the MyController server (**Options #1**)
* If you have plan to use external `gateway`, or `handler` you have to go with [external bus service (natsio)](/docs/getting-started/install-natsio/) (**Option #2**)

### Gateway Setup
![gateway setup](/doc-images/gateway-setup.png)
* There is a gateway only bundle
* This service can be connected to a MyController server via the external message bus.
* You can have many number of gateway services on different hosts

### Handler Setup
![handler setup](/doc-images/handler-setup.png)
* There is a handler only bundle
* This service can be connected to a MyController server via the external message bus.
* You can have many number of handler services on different hosts

## Supported Providers
* [ESPHome](https://esphome.io/)
* [MySensors.org](https://www.mysensors.org/)
* [Philips Hue](https://www.philips-hue.com/en-in)
* [System Monitoring](/docs/user-interface/resources/gateway-system-monitoring/)
* [Tasmota](https://tasmota.github.io/)

## What next?
* [Getting Started](/docs/getting-started/)

