---
title: "PhilipsHue"
linkTitle: "Gateway PhilipsHue"
weight: 5
---

[PhilipsHue](https://www.philips-hue.com/en-in) is smart home lighting.<br>
To know more about PhilipsHue developer API [follow this link](https://developers.meethue.com/)

## Configuration
* Form view
  ![gateway-philipshue](/doc-images/gateway-philipshue.png)

* YAML View
  ```yaml
  provider:
    type: philips_hue # (1)
    host: http://192.168.1.34:80 # (2)
    username: myhueuser # (3)
    syncInterval: 10m # (4)
    bridgeSyncInterval: 10m # (5)
  ```
  1. `type` should be selected as `philips_hue`
  2. `host` - PhilipsHue bridge address to communicate
  3. `username` of the PhilipsHue bridge
  4. `syncInterval` - polls the connected devices status from the PhilipsHue bridge
  5. `bridgeSyncInterval` - gets the PhilipsHue bridge configurations on this interval
