# OpenSSH Tasks

This is where automation begins - with a key exchange. 

## Setup SSH key-based logins
* How RSA & PKI works and [the math] behind it.
* Historic Context: The [Science Of Secrecy], Going Public, Part 2; Clifford Cocks
* [Advanced ssh] usage

## Get Fingerprint

This is a "4 times in a lifetime" type of thing. But, when you need it, there is no substitute.

`ssh-keygen -E md5 -lf ~/.ssh/id_rsa.pub`

## Creating an ssh key for your local user to do remote work:

Create user-specific key and store in standard location:

Present day:

```shell
ssh-keygen -t ed25519 -C "purpose/email_add"
```

On older systems you may have to fall back to supported encryption algorithms:

```shell
ssh-keygen -t rsa -b 4096 -C "purpose/email_add"
```

> _NOTE: TL;DR: when in doubt, use RSA keys._


## Linux: Copy key to remote host

```shell
ssh-copy-id -i ~/.ssh/id_rsa.pub user@remotehostname
```

macOS: Copy key to remote host (no ssh-copy-id on macs)

```shell
cat ~/.ssh/user_hostname.pub | ssh user@hostname 'cat >> ~/.ssh/authorized_keys'
```

Or, what I prefer is to install the UNIX package that allows macOS to behave like all the other systems:

```shell
brew install ssh-copy-id 
```

## Remote Host's RSA keys / Known Hosts

### Add the keys for a remote host to known_hosts

```shell
printf '%s\n' "  Adding $hostRemote public key to our known_hosts file..."
ssh-keyscan -t 'rsa' "$hostRemote" >> "$knownHosts"
```

### Remove the keys for a remote host to known_hosts

```shell
printf '\n%s\n' "Removing the $hostRemote public key from our known_hosts file..."
ssh-keygen -f "$knownHosts" -R "$hostRemote"
```

---

## Troubleshooting

### If you failed to login using SSH publickey authentication

The most common cause of problems with getting key-based ssh authentication to work is file permissions on the remote ssh server.

1) If the above steps were followed and ssh'ing to the appropriate user is still prompting for passwords, inspect the permissions on both the local and remote user's files, per the following command:

```shell
[user@ssh-server ~]$ ls -ld ~/{,.ssh,.ssh/authorized_keys*}
drwx------. 25 user user 4096 Aug 21 11:01 /home/user/
drwx------.  2 user user 4096 Aug 17 13:13 /home/user/.ssh
-rw-------.  1 user user  420 Aug 17 13:13 /home/user/.ssh/authorized_keys
```

2) Ensure that the permissions to the directory and file is as follows:

```shell
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh/
```

3) If group or other permissions for any of those 3 files contain w (write), key-based authentication will fail. If the requirement is to keep the permissions other than those specified above, disable `strictmodes` in `/etc/ssh/sshd_config`:

`StrictModes no`

4) Restart sshd service:

```shell
[root@ssh-server ~]# service sshd restart
```

_NOTE: After disabling strict modes sshd would not check file modes and ownership of the user’s files and home directory before accepting login.*_

Red Hat Only; SELinux can also _potentially_ prevent sshd from accessing the `~/.ssh` directory on the server
This problem can be ruled out (or resolved) by running `restorecon` as follows on the remote user's `~/.ssh directory`:

```shell
[user@ssh-server ~]$ restorecon -Rv ~/.ssh
```

### How to use RSA public key authentication:

RSA Must be configured to `/etc/ssh/sshd_config` - which it usually is - but verify:

```shell
RSAAuthentication yes
PubkeyAuthentication yes
```

To enable the change, restart the SSH daemon:

```shell
systemctl restart sshd, or
service sshd restart
```

---

# sshfs

This program works great to mount a remote share as if it were local. If you'd even like to mount it at boot time, add it to `/etc/fstab` as you would any other mount.

Create a mount directory

`sudo mkdir /mnt/yo`

Connect pull the remote directory into the local filesystem

`sudo sshfs -o allow_other,defer_permissions,IdentityFile=~/.ssh/id_rsa user@remote: /mnt/yo/`

Verify the remote share has mounted

```shell
ls -l /mnt/yo
total 36
drwxr-xr-x 1 root wheel 4096 Jan 24 10:40 Desktop
drwxr-xr-x 1 root wheel 4096 Jan 24 10:40 Documents
...
drwxrwxr-x 1 root wheel 4096 Jan 24 10:50 vms
```

Unmount when done

```shell
sudo umount /mnt/yo/
```

Verify the share is unmounted

```shell
ls -l /mnt/yo
total 0
```

Remove the local mount point

```shell
sudo rm -rf /mnt/yo
```

[the math]:https://youtu.be/q7E1VDOKryc?t=271
[Science Of Secrecy]:https://youtu.be/oR0_LPbWxe4
[Advanced ssh]:https://fedoramagazine.org/fedora-28-better-smart-card-support-openssh/
[RSA vs. DSA]:https://docs.google.com/document/d/18r-GQryX9imXMURP9EFvBQ6KFVI5_JkDX0iEMFn0sK4/edit#heading=h.dz6pm9c3wob1