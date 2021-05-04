---
title: "Architecture"
linkTitle: "Architecture"
weight: 2
description: ""
---

![architecture](/doc-images/architecture.png)

### Message bus
* All services rely on centralized message bus. Which leads we can have micro service for each block shown above.
* Most of the components based on a plugin approach. Other services can be included easily

### Gateway
* Gateway is a service that collects data from different networks. 
Also can do changes on the target network.
* Gateway is as plugin component, we can implement gateway for any provider
* [Supported providers list](/docs/overview/#supported-providers)


### Message Processor
* Collects data from a gateway and updates in storage and metrics database
* Sends received data as events, will be used in other services (Task, Forward Payload, etc.,)

### Forward Payload
* Forwards a payload from a `Field` to another `Field`
* Fields can be on a different gateways

### Task Service
* User defined tasks will be executed by `Task Service`
* Two types of tasks are available
1. Event based
    * Tasks can listen to specific events.
2. Execute on an interval
     * executes tasks based on the interval defined

* If task meets the defined criteria, posts the given parameters to the `Handler Service`

### Scheduler Service
* User defined schedules are executed by `Scheduler Service`
* outcome of the schedule execution handover the defined parameters to the `Handler Service`

### Handler Service
* Receives requests from `Task Service` and `Scheduler Service`
* Submits the parameters to a specific handler
* new handlers can be implemented easily as it is a plugin component

### API and Websocket Service
* Exposes set of APIs to consume and operate resources
* Websocket notifies the changes on the resources, helps to sync the dashboard realtime
* Web UI is client consumes query service APIs
  * User can add/modify most of the data here
  * Update Gateway details
  * Create a dashboard with different widgets
  * Add a schedule, task, handler, firmware
  * Run a backup, restore
  * etc...

### Storage Database
* Stores all the data other than metrics
  * gateways, Node, Source, Fields, Dashboard, Task, Scheduler, Handler, etc.,
* storage is a plugin type
* Currently there are two type of supported storage plugin
  * `in-memory`
    * Keeps all the configurations on the memory/RAM
    * Dumps into disk with defined intervals
    * On startup loads from the disk
  * `MongoDB`

### Metric Database
* Stores only the metrics data
* Metric is a plugin type
* Currently supports `InfluxDB`

