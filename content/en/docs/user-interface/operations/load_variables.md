---
title: "Load Variables"
linkTitle: "Load Variables"
weight: 20
---
Load Variables is a sub configuration in a [Task](/docs/user-interface/operations/tasks/) or in a [Schedule](/docs/user-interface/operations/schedules/).<br>
You can load any number of variables for the further operations.<br>

##### Form View
![load variables](/doc-images/load_variables.png)
* `Variable Name` is used a internal reference for further operations. should be unique.
* Add new variable click `+` icon
* To delete a variable click `-` icon
* By clicking edit icon of a value, can offer to select different [data types](#data-types).

##### YAML View
In YAML view, the data is encoded with [base64](https://en.wikipedia.org/wiki/Base64) format to avoid syntax issues.
```yaml
variables:
  water_level: >-
    {"type":"resource_by_quick_id","disabled":"","data":"cmVzb3VyY2VUeXBlOiBmaWVsZApxdWlja0lkOiBteXNlbnNvci4xLjEuVl9WT0xVTUUKc2VsZWN0b3I6IGN1cnJlbnQudmFsdWUK"}
  motor_status: >-
    {"type":"resource_by_quick_id","disabled":"","data":"cmVzb3VyY2VUeXBlOiBmaWVsZApxdWlja0lkOiBteXNlbnNvci4xMy4xLlZfU1RBVFVTCnNlbGVjdG9yOiBjdXJyZW50LnZhbHVlCg=="}
```

## Data Types
Following data types are supported in `Load Variables`.

  * [String](#string)
  * [Resource By QuickID](#resource-by-quickid)
  * [Resource By Labels](#resource-by-labels)

### String
String is static type. It assigns the given value to that variable.

### Resource By QuickID
Resource can be selected by their [QuickID](/docs/getting-started/hints/#quick-id).<br>

##### Form View
![load variable by quick id](/doc-images/load_variables_resource_by_quick_id.png)
* Select a `Resource Type`
* enter the `id` of the resource, you will get a list of matching resources. Select a resource.
* On the `Selector` field enter the exact path to get value. See [Selector Guide](#selector)

##### YAML View
```yaml
type: resource_by_quick_id
data:
  resourceType: field
  quickId: tasmota.tasmota_0B8E60.Control.POWER
  selector: current.value
```

### Resource By Labels
Resource can be selected by their [Labels](/docs/getting-started/hints/#labels).<br>

{{< alert title="Note" >}}
If a list of resources received, the very first resource will be taken for further actions.
{{< /alert >}}

##### Form View
![load variable by quick id](/doc-images/load_variables_resource_by_labels.png)
* Select a `Resource Type`
* enter key value of a label. enter as many labels you want.
* On the `Selector` field enter the exact path to get value. See [Selector Guide](#selector)

##### YAML View
```yaml
type: resource_by_labels
data:
  resourceType: field
  labels:
    location: hall
  selector: current.value
```

## Selector
Selector is dot(`.`) separated path used to select a value on the given resource.<br>
If the path not found returns empty value.<br>
To make the path, you should know the supported keys on a resource.<br>

To know more about supported keys of a resource,
  * go to that particular resource details page
  * click on edit
  * select the `YAML View`.

### Some of the references

#### Resource - Field
  * `current.value` - current value
  * `current.timestamp` - current value received timestamp
  * `noChangeSince` - There is no change on the received value from this time
  * `previous.value` - previous value
  * `previous.timestamp` - previous value received timestamp

#### Resource - Gateway
  * `state.status` - status of the gateway. can be `up`, `down`, `error`, etc.,
  * `enabled` - enabled or disabled