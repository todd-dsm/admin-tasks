# The Shell

Understanding the shell is so critically important that it should be the first stop on every adventure. Thankfully, it's extremely reliable and doesn't require much attention. These are also the reasons it gets overlooked. So, Bash:

* Is a binary (`/bin/bash`) that:
  * Manages the interactive shell on Linux systems, **_AND_**
  * Is an interpreter

## Bash

The Bash shell is ubiquitous and, therefore, unavoidable; that means - you _have to_ know it.

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

| Do                    | Do NOT        |
|-----------------------|---------------|
| `#!/usr/bin/env bash` | `#!/bin/bash` |

Use env and your scripts will work everywhere. Don't, and you're entering a world of pain.

## macOS and ZSH

The `macOS` operating system has switched to ZSH `/bin/zsh`. Of course, you can run Bash as well: `/opt/homebrew/bin/bash`. They can live harmoniously on the same system. I've noticed the younger folks seem to have a hard time parsing this concept for some reason. In this scenario, ZSH becomes the "interactive shell" while you're still able to point your script at a binary: `#!/usr/bin/env bash`. This is how code is directed to be interpreted by the proper binary.

Just know a few things:

1. If you're not using Oh My Zsh you're working too hard in the shell.
2. ZSH is your interactive shell.
3. Bash can still be your programming shell.

The difference in a python script vs a bash script:

```shell
% head ~/code/path/to/file/istio/istio-install.sh
#!/usr/bin/env bash

% head ~/code/path/to/file/change_file_perms_stig.py        
#!/usr/bin/env python
```

The file extensions are for humans; they are irrelevant to the system. The relevant part is the shebang.

---

## Bash Programming Answers

On the internet, there are dozens of bad technical answers for every good answer. The source of your inbound information is more important every day. If this is true, there
s really only one place to go for Bash scripting answers.

BashGuide - [Greg's Wiki]; these guys have forgotten more about Bash than most people will ever know - and they show their testing with the _whys_ and _why-nots_. What more could you ask?

My Google search looks like this: `site:mywiki.wooledge.org searchString`; yours should too. 

They also run the `#bash` IRC channel on the freenode network. Even the guy that writes/maintains Bash for the rest of the world hangs out in this IRC channel.

This crew is **_the final word_** on Bash.

[locate Bash]:https://mywiki.wooledge.org/BashProgramming
[Greg's Wiki]:https://mywiki.wooledge.org/BashGuide
