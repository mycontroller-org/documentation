---
title: "Install natsio"
linkTitle: "Install natsio"
weight: 4
---

{{< alert title="Supported Versions" >}}
MyController server tested on nats.io 2.2.2
{{< /alert >}}

[nats.io](https://nats.io/) server can be installed in different way. Here we are focusing to setup it on docker and nats.io 2.2.2 version.<br>

**To install natsio on your host system [follow this guide](https://docs.nats.io/nats-server/installation#downloading-a-release-build)**

{{< alert title="Note" >}}
Assuming that you are running all the commands as a `root` user.<br>
If you are running from non-root user, you should include `sudo` in the beginning of the commands.
{{< /alert >}}


### Install
```bash
docker run --detach --name mc_natsio \
    --publish 4222:4222 \
    --env TZ="Asia/Kolkata" \
    --restart unless-stopped \
    nats:2.2.2-alpine
```

### To see the logs
* Prints all available logs
  ```bash
  docker logs mc_natsio
  ```
* Prints and tails the logs, to get exit do `Ctrl+C`
  ```bash
  docker logs --follow mc_natsio
  ```

### Stop
```bash
docker stop mc_natsio
```

### Restart
```bash
docker restart mc_natsio
```

### Uninstall
```bash
docker stop mc_natsio
docker rm mc_natsio
```
