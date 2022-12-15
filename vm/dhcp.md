# DHCP Alpine 

https://cylab.be/blog/221/a-light-nat-router-and-dhcp-server-with-alpine-linux
https://www.hiroom2.com/2017/08/22/alpinelinux-3-6-dhcp-en/

## Installation

```shell
apk update && apk upgrade --available && sync && reboot
```

```shell
apk add dhcp
```

## Configuration

```shell
cat <<EOF > /etc/dhcp/dhcpd.conf
subnet 10.128.0.0 netmask 255.255.0.0 {
  option domain-name "alexandre.mahdhaoui.com";
  option domain-name-servers 10.128.0.2, 10.128.0.1;
  option routers 10.128.0.1;
  range 10.128.128.0 10.128.255.255
}
EOF
```

```shell
rc-update add dhcpd
rc-service dhcpd start
```