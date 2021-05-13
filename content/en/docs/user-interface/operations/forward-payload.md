---
title: "Forward Payload"
linkTitle: "Forward Payload"
weight: 5
---
Forward Payload sends the payload from a `source field` to `destination field`.<br>
Supports only for the `Field` resource.<br>

* Navigate to `Operations >> Forward Payload`
* Click on `Add` button

##### Form View
* On the `Source Field` and `Destination Field` type Field ID, displays matching ids as a dropdown.
  ![forward payload](/doc-images/forward_payload_add.png)

##### YAML View
```yaml
id: forward_water_level # (1)
description: Sends tank water level to display node # (2)
enabled: true # (3)
srcFieldId: field:mysensor.1.1.V_VOLUME # (4)
dstFieldId: field:mysensor.13.1.V_VOLUME # (5)
```
1. `id` - should be unique across forward payload
2. `description` of the entity
3. `enable` - enable/disable this entry
4. `srcFieldId` - source field id
5. `dstFieldId` - destination field id