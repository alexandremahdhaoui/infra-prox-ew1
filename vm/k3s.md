# K3S Alpine

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
if [[ "$REPLY" != "y" ]]; then echo "Aborting..."; exit 0; done
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
# Restart network
rc-service networking restart
```

Please note this script should be available at `/root/network-setup.sh`. Or maybe consider adding it to the `PATH`.

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
read -sp "Please enter the K3S_TOKEN: " K3S_TOKEN
curl -sfL https://get.k3s.io | sh -s - server --cluster-init
```

### Join the cluster 

```shell
read -sp "Please enter the K3S_TOKEN: " K3S_TOKEN
curl -sfL https://get.k3s.io | K3S_TOKEN=SECRET sh -s - server --server https://cp0.k0.alexandre.mahdhaoui.com:6443
```
