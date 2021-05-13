---
title: "Parameters to Handler"
linkTitle: "Parameters to Handler"
weight: 21
---
Parameters used to send a configuration to [handlers](/docs/user-interface/operations/handlers/).<br>
Based on the the given configuration(via parameter) handler reacts<br>

##### Form View
![parameters to handler](/doc-images/parameters_to_handler.png)

Parameter has two fields,
* to add new parameter click `+` icon
* to remove a parameter click `-` icon
* `Name` of the field should be unique. There is no special meaning for the name. use it as your reference.
* `Value` - value can be one of the [type mentioned here](#parameter-types). To update a value click on edit icon

##### YAML View
In YAML view, the data is encoded with [base64](https://en.wikipedia.org/wiki/Base64) format to avoid syntax issues.
```yaml
handlerParameters:
  run_backup: >-
    {"type":"backup","disabled":"","data":"cHJvdmlkZXJUeXBlOiBkaXNrCnNwZWM6CiAgc3RvcmFnZUV4cG9ydFR5cGU6IHlhbWwKICByZXRlbnRpb25Db3VudDogNQogIHRhcmdldERpcmVjdG9yeTogJycKICBwcmVmaXg6ICcnCg=="}
  turn_on_light: >-
    {"type":"resource_by_quick_id","disabled":"","data":"cmVzb3VyY2VUeXBlOiBmaWVsZApxdWlja0lkOiB0YXNtb3RhLnRhc21vdGFfODg3NDIxLkNvbnRyb2wuUE9XRVIKcGF5bG9hZDogJ29uJwpwcmVEZWxheTogMTBzCg=="}
```

## Parameter Types
Parameter types are based on the supported handlers.

  * [Resource By Quick ID](#resource-by-quick-id)
  * [Resource By Labels](#resource-by-labels)
  * [Webhook](#webhook)
  * [Email](#email)
  * [Telegram](#telegram)
  * [Backup](#backup)

**Disabled** is a common field across all type of parameters.
  * a parameter can be enabled or disabled dynamically.
  * can be disabled by setting this field as `true`
  * default value for this field is `false`

{{< alert title="Note" >}}
All the parameter values supports template.<br>
With template we can update the value or part of the value dynamically.<br>
[Template Guide](/docs/user-interface/operations/template/)
{{< /alert >}}


### Resource By Quick ID
Resource can be selected by their [QuickID](/docs/getting-started/hints/#quick-id).<br>

##### Form View
![resource by quick id](/doc-images/parameter_resource_by_quick_id.png)
* Select a `Resource Type`
* enter the `id` of the resource, you will get a list of matching resources. Select a resource.
* on the payload update the action or value you want to set to the selected resource
* `Pre Delay` is used to wait some time and perform the action.
  `10s` - Resource handler waits 10 seconds and sets this value.

{{< alert title="Note" >}}
Pre delay parameters will be lost on the intermediate restart of the MyController server.<br>
*Example:*
  * You passed a resource parameter with pre delay as 1 hour.
  * The parameter passed to resource handler service and this handler can perform the resource action exactly after 1 hour.
  * This data is in resource handler service memory.
  * If you restart your MyController service, that particular action will be lost and will not be executed.
{{< /alert >}}


##### YAML View
```yaml
disabled: ''
type: resource_by_quick_id
data:
  resourceType: field
  quickId: tasmota.tasmota_887421.Control.POWER
  payload: 'on'
  preDelay: 10s
```

### Resource By Labels
* This is exactly same as [Resource By Quick ID](#resource-by-quick-id).
* The only different is, selecting resources by [Labels](/docs/getting-started/hints/#labels)
* When filtering with labels it possible to get more than on resource.
* Particular action will be applied to all the resources filter by labels.

##### Form View
![resource by labels](/doc-images/parameter_resource_by_labels.png)

##### YAML View
```yaml
disabled: ''
type: resource_by_labels
data:
  resourceType: field
  labels:
    group: lights
  payload: 'on'
  preDelay: 0s
```

### Webhook
TBD

### Email
* All the fields in email parameter is optional.
* If non of the fields entered here, taking all the fields from the [Email Handler](/docs/user-interface/operations/handlers/#email-handler)
* The field enter here is taken, for empty values updates from the [Email Handler](/docs/user-interface/operations/handlers/#email-handler)

##### Form View
![resource by quick id](/doc-images/parameter_email.png)

##### YAML View
```yaml
disabled: ''
type: email
data:
  from: example@example.com
  to:
    - example1@example.com
    - example2@example.com
  subject: 'Alert: Overheat detected on CPU'
  body: |-
    Alert: Overheat detected on CPU.
    Check the status of the CPU Fan.
```

### Telegram
* other than the `Text` all the fields are optional
* empty values are taken from [Telegram Handler](/docs/user-interface/operations/handlers/#telegram-handler)
* telegram supports different `Text` parse modes, `Text`, `Markdown`, `Markdown V2`, `HTML`.

{{< alert title="Important" color="warning" >}}
All the syntax are supported from `Markdown`, `Markdown V2`, `HTML`.<br>
Refer [Telegram API Guide](https://core.telegram.org/bots/api#formatting-options) for the detailed format options.<br>
{{< /alert >}}

##### Form View
![resource by quick id](/doc-images/parameter_telegram.png)

##### YAML View
```yaml
disabled: ''
type: telegram
data:
  chatIds:
    - '20000000'
    - '-4000000'
  parseMode: Text
  text: |-
    Alert: Overheat detected on CPU.
    Check the status of the CPU Fan.
```

### Backup
Backup parameter used to execute a backup via a schedule or from a task.<br>
* Other than the `Provider` and `Retention Count`, all other inputs are optional
* empty values are taken from the [Backup Handler](/docs/user-interface/operations/handlers/#backup-handler)
* If you enter `Retention Count` as `0`, the value will be taken from the [Backup Handler](/docs/user-interface/operations/handlers/#backup-handler)

{{< alert title="Restore" >}}
To restore a backup follow the [Restore Guide](/docs/user-interface/settings/backup_and_restore/#restore)
{{< /alert >}}

##### Form View
![resource by quick id](/doc-images/parameter_backup.png)

##### YAML View
```yaml
disabled: ''
type: backup
data:
  providerType: disk
  spec:
    storageExportType: yaml
    targetDirectory: /mc_home/backups
    prefix: scheduled
    retentionCount: 10
```