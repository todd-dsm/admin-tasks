# Miscellaneous Stuff

Download file to a specific directory

```shell
curl -o /path/to/bin https://x.y.z
wget -P /tmp/dirName "$URL"
```

The ECR (Extended Club Remix)

```shell
curl --url https://${URL} --output /tmp/file.tgz
```

Download and un-tar to the `/bin` directory

```shell
curl -fsSL https://${URL}/some-binary_0.4.4_linux_x86_64.tgz | sudo tar -xzfC /bin
```