---
title: "Hints"
linkTitle: "Hints"
weight: 1
---

* if a boolean value is left blank. It is considered as `false`
* if a numerical value is left blank, It is considered as `0`

## Values on payloads
Payloads sent to a resource will be considered as follows<br>
* case in-sensitive
* `on`, `true`, `1`, `enable` == **true**  ########should tripped be here too?#######
* `off`, `false`, `0`, `disable` == **false**  #######likewise untripped#######

## Duration of the time
System time durations follow the GoLand standards as follows...<br>
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
Negative numbers are supported.
{{< /alert >}}

## Labels
TBD

## Quick ID
TBD