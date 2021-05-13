---
title: "Notify Handlers"
linkTitle: "Notify Handlers"
weight: 22
---
Handlers should be created prior to this section. Follow [Handlers Guide](/docs/user-interface/operations/handlers/) to create a handler.<br>

Notify handlers holds a list of handler ids.
Sends all the parameters to the specified handler services.<br>
Based on the [Parameters type](/docs/user-interface/operations/parameters_to_handler/#parameter-types) a particular [Handler service](/docs/user-interface/operations/handlers/#type-of-handlers) can filters supported type(s) and executes it.<br>

##### Form View
![notify handlers](/doc-images/notify_handlers.png)
* Click `+` icon to add new handler id
* Click `-` icon to delete a handler id

##### YAML View
```yaml
handlers:
  - telegram_home_group
  - resource_handler
```