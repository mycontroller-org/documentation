---
title: "Install natsio"
linkTitle: "Install natsio"
weight: 3
---

{{< alert title="Supported Versions" >}}
MyController supports natsio 2.2.2 or above
{{< /alert >}}

[nats.io](https://nats.io/) server can be installed in different way. Here we are focusing to setup it on docker and NatsIO 2.2.2 version.

##### Install
```
sudo docker run --detach --name mc_natsio \
    --publish 4222:4222 \
    --env TZ="Asia/Kolkata" \
    --restart unless-stopped \
    nats:2.2.2-alpine
```

##### Restart
```
sudo docker restart mc_natsio
```

##### Uninstall
```
sudo docker stop mc_natsio
sudo docker rm mc_natsio
```
