---
title: "Resources"
linkTitle: "Resources"
weight: 1
---

![resources](/doc-images/resources.png)

Resources are the key components in MyController.

## Gateway
Gateway is the entry and exit point in MyController.
It connects your network and MyController.

## Node
Node is a kind of end point in the sensor world.

## Source
Source is a single or group of `fields`

## Field
Field is a final measurement point

## Example
* Take a couple ESP8266 boards
* Those ESP8266 boards can be operated via `MQTT` protocol
* Each board has sensors like, `temperature`, `humidity`, `relay`, `push button`, etc.,
* Now relate with MyController resources
  * All the boards can be connected via `MQTT` to MyController - is called `gateway`
  * A board is a endpoint - is called `node`
  * `temperature`, `humidity`, etc., measurements are called `field`
  * group of `fields` or a single `field` goes under a `source`