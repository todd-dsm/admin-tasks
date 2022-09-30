# Package Managers

This will cover some highly useful stuff for each system:

* macOS
* Red Hat
* Debian
* Alpine (container os)

Everything else is derivative.

---

## Homebrew

If you're not using [homebrew] on macOS then you're working too hard. Just install it and follow the instructions. It's dead simple.


---

## Alpine

Get [Regular Stuff] Working; this covers some good basics; management of:
* Packages
* man pages
* disk/storage
* shell configuration

Package Management

10 Alpine Linux [apk-commands]

The Alpine Linux [Package Directory]

### The Wierd Ones

The Path to crond; first, enable the openrc init system:

```shell
apk add openrc --no-cache
```

---

## Yum

On RHEL systems, it used to be all about [yum] - might still be; I wouldn't know. I do know that newer Red Hat-based systems use [dnf] and it's all likely going that way if it hasn't already.

### Yum Operations

Clean up the yum db

`yum clean all`

Only install bugfix and security-related packages

`yum update --bugfix --security`

---

Fix messed-up yum repos with [yum groups]:

```shell
sudo yum group mark convert
```

### Configurations

Follow-up; reset groups back to 'compat':

```shell
yum-config-manager --save --setopt=group_command=compat
```

---

## apt-get

For Debian-based systems (Ubuntu, etc) these are the big go-tos for the `apt` system.

Update all packages: (safest on a new system)

```shell
$ apt-get update -y && apt-get upgrade -y
```

Remove a package from the system

```shell
$ sudo apt-get purge -y package_name
```

Interrogate the local database `dpkg` to see if a package is already installed: 

```shell
$ dpkg -P vim
```

### Package Search - available packages

The apt-cache program provides regex package search capability. See if package exists:

```shell
  apt-cache search ^package_name$
$ apt-cache search ^vim$
vim - Vi IMproved - enhanced vi editor
vim-athena - Vi IMproved - enhanced vi editor - with Athena GUI
vim-gtk3 - Vi IMproved - enhanced vi editor - with GTK3 GUI
vim-nox - Vi IMproved - enhanced vi editor - with scripting languages support
```

Look for all related packages:

```shell
$ apt-cache search ^vim-*
vim-migemo - VIM plugin for C/Migemo
vim-conque - plugin for running interactive commands in a Vim buffer
cream - VIM macros that make the VIM easier to use for beginners
vim-gocomplete - gocode integration for Vim
vim-syntax-go - Go programming language - Vim highlighting syntax files
vim-puppet - syntax highlighting for puppet manifests in vim
vim-python-jedi - autocompletion tool for Python - VIM addon files
vim - Vi IMproved - enhanced vi editor
vim-common - Vi IMproved - Common files
```

Install a package

```shell
$ sudo apt-get install -y vim
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  libgpm2 vim-common vim-runtime xxd
Suggested packages:
  gpm ctags vim-doc vim-scripts
The following NEW packages will be installed:
  libgpm2 vim vim-common vim-runtime xxd
...
```

Get package info: `show package_name`

```shell
$ apt-cache show vim
Package: vim
Version: 2:8.2.2434-3+deb11u1
...
```

### Package Search - installed packages

The apt-cache program provides regex package search capability.

```shell
  dpkg --get-selections | grep package_name
$ dpkg --get-selections | grep vim
vim						install
```

```shell
dpkg --get-selections | grep ^vim.*install$
vim						install
vim-common					install
vim-runtime					install
vim-tiny					install
```


### Search for Programs within Packages - apt-file: (like `yum whatprovides`).

```shell
apt-cache search ^apt-file$
apt-file - search for files within Debian packages (command-line interface)
```

Install the package

```shell
sudo apt-get -y install apt-file
```

Get the package database

```shell
apt-file update
```

Search for a given program

```shell
apt-file search /usr/bin/program-name
```

```shell
$ apt-file search /usr/bin/vim*
graphviz: /usr/bin/vimdot
vim: /usr/bin/vim.basic
vim-addon-manager: /usr/bin/vim-addon-manager
vim-addon-manager: /usr/bin/vim-addons
vim-athena: /usr/bin/vim.athena
vim-dbg: /usr/lib/debug/usr/bin/vim.athena
vim-dbg: /usr/lib/debug/usr/bin/vim.basic
vim-dbg: /usr/lib/debug/usr/bin/vim.gnome
vim-dbg: /usr/lib/debug/usr/bin/vim.gtk
vim-dbg: /usr/lib/debug/usr/bin/vim.nox
vim-dbg: /usr/lib/debug/usr/bin/vim.tiny
vim-gnome: /usr/bin/vim.gnome
vim-gtk: /usr/bin/vim.gtk
vim-nox: /usr/bin/vim.nox
vim-runtime: /usr/bin/vimtutor
vim-scripts: /usr/bin/vimplate
vim-tiny: /usr/bin/vim.tiny
```

### Adding Vendor Repos

Not all programs will come from the OS vendor; some will be shared with us through a company's repos. 

Listing PGP Keys

Without the grepping all keys will be displayed. From Debian there are 7 that are installed with each system.

```shell
$ apt-key list
----------------------------------------------------------
pub   4096R/2B90D010 2014-11-21 [expires: 2022-11-19]
uid                  Debian Archive Automatic Signing Key (8/jessie) <ftpmaster@debian.org>

/etc/apt/trusted.gpg.d/debian-archive-jessie-security-automatic.gpg
-------------------------------------------------------------------
...
```


Find the key in question

```shell
apt-key list | grep -B1 'Docker'
--------------------
pub   4096R/2C52609D 2015-07-14
uid                  Docker Release Tool (releasedocker) <docker@docker.com>
```


Removing a PGP Key

```shell
sudo apt-key del 2C52609D
OK
```

[homebrew]:https://brew.sh
[Regular Stuff]:https://wiki.alpinelinux.org/wiki/How_to_get_regular_stuff_working
[apk-commands]:https://www.cyberciti.biz/faq/10-alpine-linux-apk-command-examples/#8
[Package Directory]:https://pkgs.alpinelinux.org/packages
[yum]:https://access.redhat.com/solutions/9934
[dnf]:https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_basic_system_settings/managing-software-packages_configuring-basic-system-settings
[yum groups]:https://fedoraproject.org/wiki/Features/YumGroupsAsObjects