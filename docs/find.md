# find

Always check Wooledge’s [site] - always. There are some unsafe ways to use `find`; you'll want to avoid them. Here's a good example of something with potentially catastrophic consequences:

## Search and Replace on bulk files

I still use this one regularly:

```shell
find . -type f -exec grep 'strX' -l {} \; -exec sed -i 's/strX/strY/g' {} \;
```

I once turned a 3-month job into a 15-minute job with this command - just by being dilligent in the search for better answers. They hired me for the remaining 3-months by the way.

Using multiple [name expressions], [an example].

## Search for multiple strings

```shell
find . -type f -exec grep -E '(strX|strY)' {} +
```

This one is good for validations, like: did the first command actually change `strX -> strY`?

---

## Changing permissions en masse

```shell
find . -type f -exec chmod 644 {} \;
find . -type d -exec chmod 755 {} \;
find . -uid 1000 -exec chown 1010:1010 {} \;
```

## find and remove files in bulk

Given this very common and annoying set of conditions:

```shell
% find "$HOME/vms" -type f -name '.DS_Store'
/Users/user/vms/macos/ventura/.DS_Store
/Users/user/vms/macos/.DS_Store
/Users/user/vms/macos/monterey/.DS_Store
/Users/user/vms/macos/sonoma/.DS_Store
/Users/user/vms/.DS_Store
... (can be 100s of lines long)
```

The file(s) in question can easily be removed:

```shell
% find "$HOME/vms" -name '.DS_Store' -print0 | xargs -0 rm
```

## Find files by size

```shell
% find ~/Downloads -type f -size +1024k -exec ls -lh {} \; | awk '{ print $5 ": " $9 }'
2.3M: /Users/user/Downloads/00-business-plan-sol-burger.docx
25M: /Users/user/Downloads/Toontrack_Product_Manager_MAC
9.2M: /Users/user/Downloads/vimsimple-works.tgz
3.4G: /Users/user/Downloads/UAD-v10.1.0-Mac/UAD-v10.1.0-Mac.pkg
206M: /Users/user/Downloads/plugins/Install_Waves_Central.dmg
198M: /Users/user/Downloads/plugins/UA_Connect_1_2_2_1327_Mac.dmg
3.6G: /Users/user/Downloads/music-production/UAD-v10.1.0-Mac.zip
363M: /Users/user/Downloads/music-production/neuraldsp/Darkglass
7.8M: /Users/user/Downloads/solarized/img/solarized
...
```

### Find any file over 1MB; output: file size and path

```shell
find "$HOME" -type f -size +1024k -exec ls -lh {} \; | awk '{ print $5 ": " $9 }'
...
1.8M: /Users/$USER/Pictures/Photos
```

### Find any files `>500MB`

```shell
% find ~/Downloads -type f -size +500000k -exec ls -lh {} \; | awk '{ print $5 ": " $9 }'
3.4G: /Users/user/Downloads/UAD-v10.1.0-Mac/UAD-v10.1.0-Mac.pkg
3.6G: /Users/user/Downloads/music-production/UAD-v10.1.0-Mac.zip
```

### Find file exactly n bytes:

```shell
% find ~/Downloads -type f -size 22073c -exec ls -lh {} \; | awk '{ print $5 ": " $9 }'
22K: /Users/user/Downloads/solarized/img/andalemono14/screen-javascript-light.png
```

## Find files by date/time with sorting

```shell
find ~/code -type f -name actuate.tf -exec stat -c '%y %n' {} + | awk '{ print $1 " @ " $2 " " $4}' | sort -r
2022-09-29 @ 17:40:17.593810169 /Users/user/Downloads/pos-requirements.pdf
2022-09-26 @ 18:30:33.776752815 /Users/user/Downloads/TheTerraformBook.pdf
2022-09-26 @ 18:30:25.742799705 /Users/user/Downloads/ThePackerBook.pdf
2022-09-26 @ 18:13:05.541643351 /Users/user/Downloads/Todd_prescriptionSchedule.pdf
2022-09-25 @ 19:36:07.811683018 /Users/user/Downloads/bug-report.tar.gz
...
2022-05-17 @ 09:04:00.000000000 /Users/user/Downloads/UAD-v10.1.0-Mac/.DS_Store
2022-05-17 @ 08:52:57.000000000 /Users/user/Downloads/UAD-v10.1.0-Mac/UAD-v10.1.0-Mac.pkg
2022-05-16 @ 09:31:30.000000000 /Users/user/Downloads/UAD-v10.1.0-Mac/UA
2019-12-11 @ 05:20:24.000000000 /Users/user/Downloads/music-production/neuraldsp/Darkglass
2019-11-29 @ 06:10:08.000000000 /Users/user/Downloads/music-production/neuraldsp/Darkglass
...
```

### Find files created/modified within the last 10 minutes:

```shell
% sudo find /var/log -cmin -5
/var/log/powermanagement/StoreData
/var/log/powermanagement/2022.09.30.asl
...
/var/log/system.log
````

### Within the last 60 days:

```shell
% sudo find /etc/ -iname "*.txt" -mtime -60 -print
/etc/hosts
```

This one searches for:

* any FILE, skip directories
* file > 50MB but < 500MB
* date of file: measure -mtime (last 24hrs) from the beginning of today

```shell
% find "$HOME" -type f -size +50M -size -500M -mtime 1 -daystart -exec ls -lh {} \; | awk '{ print $5 ": " $9 }'
86M: /Users/user/Library/Application
```

## Find files by Content

For a majority of searches this works great

```shell
% sudo find /dir/path/ -type f -exec grep 'string' {} +
```

Or, add line numbers by passing the `-n` argument to `grep`

```shell
$ sudo find /etc/ -type f -name 'shells' -exec grep -Hn bash {} +
/etc/shells:2:/bin/bash
/etc/shells:4:/usr/bin/bash
```

## Find any links to reference file ('/tmp/yo') and grep found files for a string

```shell
% ln -s /tmp/yo yo

% cat yo
a1 b1 c1
a2 b2 c2
a3 b3 c3

find -L . -type f -samefile /tmp/yo
./yo

find -L . -type f -samefile /tmp/yo -print0 | xargs -0 grep -FzZ 'b2'
```

* -F, Interpret PATTERN as a list of fixed strings, separated by newlines, any of which is to be matched.
* -Z, Output a zero byte (the ASCII NUL character) instead of the character that normally follows a file name.
* -z, Treat the input as a set of lines, each terminated by a zero byte (the ASCII NUL character) instead of a newline.

## Being Selective

Don't descend past the root directory, in this case: `/etc/`

```shell
% sudo find /etc/ -maxdepth 1 -type f -exec grep -i 'localhost' {} +
```

### Pruning

Search the whole filesystem except...

```shell
$ sudo find / -name "proc" -prune , -name "dev" -prune , -name "udev" -prune , -name "sys" -prune , -perm -0002
```

## Save all output to a file:

```shell
sudo find / -name "proc" -prune , -name "run" -prune -o -perm -0002 -type f \( -fprintf /tmp/find-out.log '%#M  %u  %g  %p\n' \)
```

### Create a list of dates associated with file names:

```shell
find ~/code/ -type f -name '*.sh' \( -fprintf /tmp/find-out.log '%AY%Am%Ad %p\n' \)
```

The list can later be sorted by date to find the latest files touched.

## List Contents of All found Zip files

```shell
find ~/Downloads -type f -name '*.zip' -exec zipinfo -m {} \;
```

[site]:https://mywiki.wooledge.org/UsingFind
[name expressions]:https://alvinalexander.com/blog/post/linux-unix/find-how-multiple-search-patterns-filename-command/
[an example]:https://stackoverflow.com/a/1583282
