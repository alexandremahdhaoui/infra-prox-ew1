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

```shell
#!/bin/ash
# Enter your configuration
read -p "Enter your hostname, e.g. \"k3s-template\": " HOSTNAME
read -p "Enter your desired ip address, e.g. \"10.128.255.0\": " IP_ADDR 
read -p "Please specify the netmask, e.g. \"255.255.0.0\": " NETMASK
read -p "Please enter the address of the gateway, e.g. \"10.128.0.1\": " GATEWAY

echo "Your desired configuration is:
HOSTNAME: $HOSTNAME
IP_ADDR:  $IP_ADDR
NETMASK:  $NETMASK
GATEWAY:  $GATEWAY
"
read -p "Do you wish to continue [y/n]: " REPLY
if [[ "$REPLY" != "y" ]]; then echo "Aborting..."; exit 0; fi
# Update your hostname
echo "$HOSTNAME" > /etc/hostname
# Update the nameserver configuration, if not done already.
cat <<EOF > /etc/resolv.conf
nameserver 10.128.0.2
nameserver 10.128.0.1
nameserver 8.8.8.8
EOF
# Update your network interface
cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
        address ${IP_ADDR}
        netmask ${NETMASK}
        gateway ${GATEWAY}
EOF
# Register to the nameserver
curl -XPOST dns.alexandre.mahdhaoui.com:8000/a --data "{\"name\": \"$HOSTNAME\", \"class\": \"IN\", \"record_type\": \"A\", \"value\": \"${IP_ADDR}\"}"
# Reboot the system
reboot
```

Please note this script is available at `/usr/local/bin/network-setup`. 

The non-interactive version of the script is available at `/usr/local/bin/network-setup-non-interactive`:
```shell
#!/bin/ash
HOSTNAME=$1
IP_ADDR=$2
NETMASK=$3
GATEWAY=$4
echo "$HOSTNAME" > /etc/hostname
cat <<EOF > /etc/resolv.conf
nameserver 10.128.0.2
nameserver 10.128.0.1
nameserver 8.8.8.8
EOF
cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback
auto eth0
iface eth0 inet static
        address ${IP_ADDR}
        netmask ${NETMASK}
        gateway ${GATEWAY}
EOF
curl -XPOST dns.alexandre.mahdhaoui.com:8000/a --data "{\"name\": \"$HOSTNAME\", \"class\": \"I
reboot
```


### Disable swap

Run `swapoff -a`, or permanently disable swap:
1. `vi /etc/fstab`
2. And comment out the line where `swap` is defined.

### Setup cgroups
```shell
apk add --no-cache curl
echo "cgroup /sys/fs/cgroup cgroup defaults 0 0" >> /etc/fstab
cat > /etc/cgconfig.conf <<EOF
mount {
    cpuacct = /cgroup/cpuacct;
    memory  = /cgroup/memory;
    devices = /cgroup/devices;
    freezer = /cgroup/freezer;
    net_cls = /cgroup/net_cls;
    blkio   = /cgroup/blkio;
    cpuset  = /cgroup/cpuset;
    cpu     = /cgroup/cpu;
}
EOF
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

## Installation

### Bootstrap the cluster

```shell
curl -sfL https://get.k3s.io | sh -s - server --cluster-init
```

### Join the cluster as a control plane node

The value of the `K3S_TOKEN` can be found at `/var/lib/rancher/k3s/server/node-token`. 

```shell
read -p "Please enter the K3S_URL, e.g. \"k0cp0.alexandre.mahdhaoui.com\": " K3S_URL
read -sp "Please enter the K3S_TOKEN: " K3S_TOKEN

K3S_URL=https://${K3S_URL}:6443
curl -sfL https://get.k3s.io | sh -s - server\
  --server $K3S_URL\
  --token $K3S_TOKEN
```

### Join the cluster as a worker node

```shell
read -p "Please enter the K3S_URL, e.g. \"k0cp0.alexandre.mahdhaoui.com\": " K3S_URL
read -sp "Please enter the K3S_AGENT_TOKEN: " K3S_AGENT_TOKEN

K3S_URL=https://${K3S_URL}:6443
curl -sfL https://get.k3s.io | sh -s - agent\
  --server $K3S_URL\
  --token $K3S_AGENT_TOKEN
```
