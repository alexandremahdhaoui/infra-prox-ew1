# Alpine Golang

## Installing Golang

```shell
go_version=1.19.4

apk update && apk upgrade
apk add --update --no-cache musl-dev
mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

wget https://golang.org/dl/go${go_version}.linux-amd64.tar.gz
tar -C /usr/local -xzf go${go_version}.linux-amd64.tar.gz
rm go${go_version}.linux-amd64.tar.gz
echo -e "export GOPATH=/root/go\nexport PATH=${GOPATH}/bin:/usr/local/go/bin:${PATH}" >> /etc/profile
. /etc/profile
go version
```

## With apk

https://fukubaka0825.medium.com/how-to-resolve-the-trouble-occurred-when-i-install-go-into-the-alpine-image-3c1e84f2315a

```shell
apk update && apk upgrade
apk add --update --no-cache musl-dev go
export GOPATH=/root/go
export PATH=${GOPATH}/bin:/usr/local/go/bin:${PATH}
```
