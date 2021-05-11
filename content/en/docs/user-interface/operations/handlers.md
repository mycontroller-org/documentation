---
title: "Handlers"
linkTitle: "Handlers"
weight: 4
---
Handlers are performing an action based on the input parameters.<br>
Different type of handlers supported by MyController.<br>
Handler is a plugin component.

## Type of Handlers
  - [Noop Handler](#noop-handler)
  - [Resource Handler](#resource-handler)
  - [Email Handler](#email-handler)
  - [Telegram Handler](#telegram-handler)
  - [Backup Handler](#backup-handler)

{{< alert title="Note" color="primary" >}}
Some of the configurations in the handler can be overrides by the input parameters.
{{< /alert >}}

### Noop Handler
Noop is a *No Operation* handler. It does nothing.<br>
The idea behind `Noop` handler is, in the future plan to introduce hidden handlers externally.<br>
Right now, there is no use.

### Resource Handler
Resource handler sends payload to the nodes, performs an actions on resource, operation, etc.,<br>

### Email Handler
Sends email to the recipients. Supports smtp server.

![email handler](/doc-images/mc_email_handler.png)

```yaml
type: email # (1)
spec:
  host: smtp.example.com # (2)
  port: 465 # (3)
  insecureSkipVerify: true # (4)
  username: username@example.com # (5)
  password: mypassword # (6)
  fromEmail: from@example.com # (7)
  toEmails: to1@example.com,to2@example.com # (8)
```
1. `type` should be selected as `email`
2. `host` - email server host
3. `port` - email server port
4. `insecureSkipVerify` - enables/disables insecure
5. `username` of the account
6. `password` of the account
7. `fromEmail` from email address
8. `toEmails` to emails list comma separated

### Telegram Handler
Sends telegram message to persons and/or groups.<br>
[Follow this guide to get the telegram token and chatId](/docs/appendix/telegram/)<br>

![telegram handler](/doc-images/mc_telegram_handler.png)

```yaml
type: telegram # (1)
spec:
  token: 500000000:AAHKsdsdckwendlwwqNKJBmbjknm9jA # (2)
  chatIds: # (3)
    - '200000000'
    - '300000000'
```
1. `type` should be selected as `telegram`
2. `token` of the telegram account
3. `chatIds` - list of person or group ids

### Backup Handler
Backup handler performs backup operation and keeps the backup archives at the specified target location<br>

{{< alert title="Important" color="danger" >}}
Backup covers only the storage database and firmware's.<br>
**Metrics data will not be backed up.**<br>
User has to handle metrics database backup/restore themselves.
{{< /alert >}}

![backup handler](/doc-images/mc_backup_handler.png)
```yaml
type: backup # (1)
spec:
  providerType: disk # (2)
  spec:
    storageExportType: yaml # (3)
    targetDirectory: /mc_home/backups/ # (4)
    prefix: primary # (5)
    retentionCount: 10 # (6)
```
1. `type` should be selected as `backup`
2. `providerType` should be selected as `disk`. Only this provider supported now
3. `storageExportType` - storage database data will be exported in this format. options: `yaml`, `json`
4. `targetDirectory` - location to keep the backup archives
5. `prefix` of the backup file
6. `retentionCount` - If the number of backup archives goes beyond this count,older files will be deleted permanently.
