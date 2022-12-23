# K3S Alpine

## TODO
- automated setup
- improve the `k3s-template` with some aliases and automated script setup.

## Prerequisites

### Update your system
```shell
apk update && apk upgrade --available && sync && reboot
```

### Update your network configuration & Register to the Nameserver

Scripts are available at: 
- `/usr/local/bin/init-network`, 
- `/usr/local/bin/init-network-interactive`.


### Disable swap

Run `swapoff -a`, or permanently disable swap:
1. `vi /etc/fstab`
2. And comment out the line where `swap` is defined.

### Setup cgroups

#### Using cgroupfs-mount

Run this script:
- https://github.com/tianon/cgroupfs-mount/blob/master/cgroupfs-mount
- Or add it to the `PATH`

#### Finally run

```shell
sed -i 's/default_kernel_opts="pax_nouderef quiet rootfstype=ext4"/default_kernel_opts="pax_nouderef quiet rootfstype=ext4 cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory"/g' /etc/update-extlinux.conf
update-extlinux
reboot
```

### Install cni-plugins
```shell
apk add --no-cache cni-plugins --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
export PATH=$PATH:/usr/share/cni-plugins/bin
echo -e '#!/bin/sh\nexport PATH=$PATH:/usr/share/cni-plugins/bin' > /etc/profile.d/cni.sh
```

### Install iptables
```shell
apk add iptables
rc-update add iptables 
```

### Optional time-saving changes

```shell
cat <<EOF >> /etc/profile
alias ll=ls\ -laF
alias k=kubectl
alias kg=k\ get
alias kgp=kg\ pod
alias kd=k\ describe
alias kdp=kd\ pod
alias kl=k\ logs
alias kaf=k\ apply\ -f
EOF
```

## Installation

### Bootstrap the cluster

```shell
init-k3s-cluster
```

### Join the cluster as a control plane node

Please run:
```shell
init-k3s-server-interactive
```

NB: The value of the `K3S_TOKEN` can be found at `/var/lib/rancher/k3s/server/node-token`.

### Join the cluster as a worker node

Please run:
```shell
init-k3s-agent-interactive
```
