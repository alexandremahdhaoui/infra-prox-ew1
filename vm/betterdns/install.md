# Betterdns Alpine

The steps to build binaries and configuration file are not detailed in this installation guide.

## Prerequisites

As a root user please run:
- Update & upgrade your system. 
- Reboot your system
- Create a non-root user.
- Grant permissions to betterdns & coredns to open ports.

```shell
apk update && apk upgrade --available && sync && reboot
```

```shell
adduser nonroot
mkdir -p /home/nonroot/betterdns_bin
# grant permissions to open ports.
apk add libcap
setcap 'cap_net_bind_service=+ep' /home/nonroot/betterdns_bin/betterdns 
setcap 'cap_net_bind_service=+ep' /home/nonroot/betterdns_bin/coredns
```

## Copy binaries

Using `scp`, copy `Corefile`, `Rocket.toml`, `coredns` & `betterdns`.

```shell
ssh-keygen -t ed25519
ssh-copy-id nonroot@${REMOTE_IP}

scp Corefile nonroot@${REMOTE_IP}:/home/nonroot/betterdns_bin
scp dns_manifest nonroot@${REMOTE_IP}:/home/nonroot/betterdns_bin
scp Rocket.toml nonroot@${REMOTE_IP}:/home/nonroot/betterdns_bin
scp go/bin/coredns nonroot@${REMOTE_IP}:/home/nonroot/betterdns_bin
scp betterdns/target/release/betterdns nonroot@${REMOTE_IP}:/home/nonroot/betterdns_bin
```

## Add betterdns_bin to the PATH

```shell
echo "export PATH=$PATH:/home/nonroot/betterdns_bin" >> /etc/profile
```

## Manual startup

```shell
ssh nonroot@${REMOTE_IP}
cd /home/nonroot/betterdns_bin/
betterdns &
exit
```

## Run the DNS at startup (not working)

```shell
cat <<EOF > /etc/local.d/betterdns.start
#!/bin/ash
su - nonroot
cd /home/nonroot/betterdns_bin/
betterdns &
EOF
chmod 755 /etc/local.d/betterdns.start
rc-service local start
rc-update add local default
```