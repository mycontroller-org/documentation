---
title: "Hints"
linkTitle: "Hints"
weight: 1
---

* if a boolean value left blank. It is consider as `false`
* if a number value left blank, It is consider as `0`

## Values on payloads
Payloads to a resource actions will be considered as follows<br>
* case in-sensitive
* `on`, `true`, `1`, `enable` == **true**
* `off`, `false`, `0`, `disable` == **false**

## Duration of the time
Across the system duration of the time follows the GoLand duration standards<br>
- `ns` - nanoseconds
- `us` - microseconds
- `ms` - milliseconds
- `s`  - seconds
- `m`  - minutes
- `h`  - hours

### Examples:
|Input    |Description                      |
|---------|---------------------------------|
|`0`      |0 seconds                        |
|`0s`     |0 seconds                        |
|`10s`    |10 seconds                       |
|`1m20s`  |1 minute and 20 seconds          |
|`1h20m5s`|1 hour 20 minutes and 5 seconds  |
|`-42s`   |-42 seconds                      |

{{< alert title="Note" color="primary" >}}
Negative number are supported.
{{< /alert >}}

## Labels
TBD

## Quick ID
TBD