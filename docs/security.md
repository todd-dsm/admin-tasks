# Security

---

## Local Network Investigation

[lsof] is for local network investigation. There are other tools, sure: [netcat], [netstat], but, lsof is likely the most informative of them all.

Use `lsof` to tie open, listening ports to service listeners:

```shell
sudo lsof -PiTCP -sTCP:LISTEN -i :8200
COMMAND    PID   USER    FD  TYPE DEVICE             SIZE/OFF  NODE NAME
Adobe\x20 1518  $USER    8u  IPv4 0xc1696697ef205a81      0t0  TCP  localhost:15292 (LISTEN)
cupsd     2439   root    8u  IPv6 0xc1696697cfe4d639      0t0  TCP  localhost:631   (LISTEN)
cupsd     2439   root    9u  IPv4 0xc1696697ed61af99      0t0  TCP  localhost:631   (LISTEN)
```

More detailed output; example:

```shell
% sudo lsof -OnP -i 4 -sTCP:LISTEN
COMMAND     PID           USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
launchd       1           root    8u  IPv4 0x8b17115bf97d4e6d      0t0  TCP *:22 (LISTEN)
launchd       1           root   35u  IPv4 0x8b17115bfaae582d      0t0  UDP *:137
launchd       1           root   36u  IPv4 0x8b17115bfaae5b3d      0t0  UDP *:138
launchd       1           root   44u  IPv4 0x8b17115bf97d5905      0t0  TCP *:47937 (LISTEN)
systemsta   105           root   16u  IPv4 0x8b17115bfaaeb40d      0t0  UDP *:*
configd     107           root   25u  IPv4 0x8b17115bfaae646d      0t0  UDP *:*
syslogd     129           root    6u  IPv4 0x8b17115bfaaea7cd      0t0  UDP *:60235
locationd   144     _locationd    8u  IPv4 0x8b17115bfaaeaadd      0t0  UDP *:*
bluetooth   159           root   24u  IPv4 0x8b17115bfaae987d      0t0  UDP *:*
...
mDNSRespo   183 _mdnsresponder    6u  IPv4 0x8b17115bfaae48dd      0t0  UDP *:5353
...
Google    42368         $USER   28u  IPv4 0x8b17115bfb21ad9d      0t0  UDP 10.0.0.111:53261->172.253.62.94:443
```

Of course, this hardly scratches the surface. Once the local workstation is _"clean"_ we can move on to the remote stuff.

---

## Remote Investigation

[nmap] answers the question: 

> _which ports, on a remote system, are open to the outside world?_

```shell
nmap $remoteIPAddr

Starting Nmap 7.40 ( https://nmap.org ) at 2017-06-02 12:23 CDT
...
PORT     STATE SERVICE
22/tcp   open  ssh
80/tcp   open  http
1023/tcp open  netvenuechat
2200/tcp open  ici
2222/tcp open  EtherNetIP-1
3128/tcp open  squid-http
5001/tcp open  commplex-link
5003/tcp open  filemaker
8080/tcp open  http-proxy
8081/tcp open  blackice-icecap
```

Hopefully, nobody ever sees output like this but, if you're not sure, give `nmap` a spin and find out for sure. 

Side note: `nmap` will completely offend any cloud (AWS/GCP) sensibilities; `npap` fits a specific profile and the big cloud providers will block this _type_ of activity after the behavior has been identified. And that's because, this is where hackers begin discovery too.


---

## Snag Public Certs

Sometimes,you just have to...

```shell
¯\_(ツ)_/¯
```

For those times:

`openssl s_client -host $IPAddr -port $portNo > /tmp/yo`

[lsof]:https://github.com/lsof-org/lsof#lsof
[nmap]:https://nmap.org
[netcat]:https://netcat.sourceforge.net
[netstat]:http://netstat.net
