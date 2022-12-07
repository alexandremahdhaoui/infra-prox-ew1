# Network interfaces

## test config:
```shell
ifup vmbr1
```
## restart networking: (make sure ifupdown2 is installed)
```shell
ifupdown2 # or service networking restart
```

```shell
vi /etc/network/interfaces
```

```text
auto xxxx
iface xxxx inet loopback

iface xxxxxxx inet manual

auto xxxxx
iface xxxxx inet static
        address xxxxxxxxxxx/xx
        gateway xxxxxxxxxxx
        bridge-ports xxxxxxx
        bridge-stp off
        bridge-fd 0

iface xxxxxxx inet manual
iface xxxxxxx inet manual
iface xxxxxxx inet manual

auto xxxxx
iface xxxxx inet static
        address xxxxxxxxxx
        netmask xxxxxxxxxxx
        bridge_ports none
        bridge_stp off
        bridge_fd 0
        post-up echo 1 > /proc/sys/net/ipv4/ip_forward
        post-up iptables -t nat -A POSTROUTING -s 'xxxxxxxxxx/xx -o xxxxx -j MASQUERADE
        post-down iptables -t nat -D POSTROUTING -s 'xxxxxxxxxx/xx' -o xxxxx -j MASQUERADE
```
