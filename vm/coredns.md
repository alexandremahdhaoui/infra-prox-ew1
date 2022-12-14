# Alpine CoreDNS

## Install CoreDNS

```shell
apk update && apk upgrade

wget https://github.com/coredns/coredns/releases/download/v1.10.0/coredns_1.10.0_linux_amd64.tgz
tar -C $GOPATH/bin -xzf coredns_1.10.0_linux_amd64.tgz 
rm coredns_1.10.0_linux_amd64.tgz

coredns version
```

## Example

`Corefile`:
```text
mahdhaoui.com:53 {
    log stdout
    file dns_file
}
```

`dns_file`:
```text
$TTL    1M
$ORIGIN mahdhaoui.com.

mahdhaoui.com.              IN  SOA     sns.dns.icann.org. noc.dns.icann.org. 2015082541 7200 3600 1209600 3600
mahdhaoui.com.              IN  NS      b.iana-servers.net.
mahdhaoui.com.              IN  NS      a.iana-servers.net.
mahdhaoui.com.              IN  A       127.0.0.1

; Flagship: Test A Record
test.mahdhaoui.com.         IN  A       10.128.0.6

; Flagship: Test TXT Record
text.mahdhaoui.com.         IN  TXT     "This is a test text record"
```

## Open a socket listening for change on port 3000

### Listen on port 3000 & start coredns 
```shell
COMMAND="ps | grep 'coredns' | awk '{print \$1}'"
while true ; do 
  coredns -dns.port=1053 & 
  echo -e 'HTTP/1.1 200\r\n' | nc -lvp 3000
  echo $(eval $COMMAND)
  for x in $(eval $COMMAND); do kill -9 $x;done
done
```

### Restart the server
```shell
curl 10.128.254.254:3000 -i
```

### Test it

```shell
dig mahdhaoui.com @10.128.254.254
```

It should return:
```shell
xxxx@xxxx:~# dig mahdhaoui.com @10.128.254.254

; <<>> DiG xxxx-xxxx <<>> mahdhaoui.com @10.128.254.254
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 19406
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 2, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: 672eb03c620f0c46 (echoed)
;; QUESTION SECTION:
;mahdhaoui.com.                 IN      A

;; ANSWER SECTION:
mahdhaoui.com.          60      IN      A       127.0.0.1

;; AUTHORITY SECTION:
mahdhaoui.com.          60      IN      NS      b.iana-servers.net.
mahdhaoui.com.          60      IN      NS      a.iana-servers.net.

;; Query time: 0 msec
;; SERVER: 10.128.254.254#53(10.128.254.254)
;; WHEN: Fri Dec 09 00:21:37 CET 2022
;; MSG SIZE  rcvd: 173
```
