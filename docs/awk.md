# AWK 1-Liners

Print the last element of ls -l output

```shell
% ls -l | awk -F '[ ]' '{print $9}'
LICENSE
README.md
docs
```

Display users with UIDs greater than 1000

```bash
awk -F: '$3 > 1000 { print $0 }' /etc/passwd
```

For everything else, this a [deep subject]; the [simplified] version.

[deep subject]:https://www.gnu.org/software/gawk/manual
[simplified]:https://www.grymoire.com/Unix/Awk.html
