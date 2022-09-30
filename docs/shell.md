# The Shell

Understanding the shell is so critically important that it should be the first stop on every adventure. Thankfully, it's the most reliable mechanisms ever invented and you don't have to focus on it much.

## Bash

The Bash shell is ubiquitous. It's on UNIX, Linux, macOS and I hear Windows is even getting in on it. This is not an accident. It's highly configurable and therefore powerful but comes with a few limitations; it's no good for working with DBs; but, even that many not be true any more. 

Linux systems will maintain themselves fairly well and you will have a single binary at a static location on a per-distro basis. There are three main flavors:
1. Fedora: `/usr/bin/bash`
2. Debian: `/bin/bash`
3. macOS:
   1. comes with the OS: `/bin/bash`
   2. Installed by Homebrew on M1: `/opt/homebrew/bin/bash`
   3. Installed by Homebrew on Intel: `/usr/local/bin/bash`

As you can see, the location of the binary is different when some OS conditions change. So, if you take one thing away from all of this:

> _never call Bash directly_

Instead, always use `env` to [locate Bash] when writing a script:

| Do           | Do NOT      |
|--------------|-------------|
| `#!/usr/bin/env bash` | `#!/bin/bash` |

Use env and your scripts will work everywhere. Don't, and you're entering a world of pain.

## macOS and ZSH

The `macOS` operating system has switched to ZSH `/bin/zsh`. Of course, you can run Bash as well: `/opt/homebrew/bin/bash`. They can live harmoniously on the same system. I've noticed the younger folks seem to have a hard time parsing this for some reason.

Just know a few things:

1. If you're not using Oh My Zsh you're working too hard in the shell.
2. ZSH is your interactive shell. 
3. Bash can still be your programming shell.

The difference is the shebang at the top of the script. Point it at Bash, you've got a bash script; point it at ZSH, you'll execute the script against that binary = simple.

---

## Bash Programming Answers

There are dozens of bad technical answers for every good answer. The source of your inbound information is more important every day. If this is true, there
s really only one place to go: 

BashGuide - [Greg's Wiki]; these guys have forgotten more about Bash than most people will ever know - and they show their testing with the _whys_ and _why nots_. What more could you ask?

My Google search looks like this: `site:mywiki.wooledge.org searchString`; yours should too. 

They also run the `#bash` IRC channel on the freenode network. They _**are**_ the final word.

[locate Bash]:https://mywiki.wooledge.org/BashProgramming
[Greg's Wiki]:https://mywiki.wooledge.org/BashGuide
