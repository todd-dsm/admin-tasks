# sed

Some of these operations are very similar to the ones in `vim` but those operations happen in the editor and these happen at the terminal but they do roughly the same thing. For all-else there is the [official reference]; here's the useful stuff:

### Test REGEX Expressions by Printing

`sed -n '/string/p'`

Given this grid, we can start getting surgical:

```shell
% cat /tmp/yo
a1 b1 c1
a2 b2 c2
a3 b3 c3
```


Example: find the line containing `b2`:

```shell
% sed -n '/b2/p' /tmp/yo
a2 b2 c2
```

### Search and Replace on a file

Search for stringA then replace with stringB

`sed -i 's/stringA/stringB/g' file`

```shell
% sed -i 's/b2/b2.5/g' /tmp/yo
a1 b1 c1
a2 b2.5 c2
a3 b3 c3
```

Search for stringA then replace stringB on the same line with stringC

```shell
% sed -i '/a2/ s/c2/c2.5/g' /tmp/yo
a1 b1 c1
a2 b2 c2.5
a3 b3 c3
```

### Changing the delimiter

This helps keep the registers separated visually, especially when working with file paths.

```shell
sed -i 's|/path/in/file|/new/path/in/file|g' /etc/permissions
```

I think the delimiter can be a range of characters.

### Delete lines matching pattern

`sed '/pattern/d'`

```shell
% sed '/b2/d' /tmp/yo
a1 b1 c1
a2 c2         <- b2 has been removed
a3 b3 c3
```

Insert a line above the string for which you've searched

```shell
sed '\|/usr/local/bin|i /usr/local/opt/coreutils/libexec/gnubin' /tmp/path
```

```shell
% sed '/b2/i \yo' /tmp/yo
a1 b1 c1
yo            <- inserted before
a2 b2 c2
a3 b3 c3
```

Also:

```shell
sed '\|/file/path|i file/pathx' /tmp/yo
```

Append a line below the string for which you've searched

```shell
% sed '/b2/a \yo' /tmp/yo 
a1 b1 c1
a2 b2 c2
yo            <- appended after
a3 b3 c3
```

Replace the nth Occurrence of $string
`sudo sed -i "s/localhost$/$(hostname -s)/1" /etc/hosts`

Where 1 is the nth occurrence of the string.

Or, another way:
```shell
sed -i '0,s|^.*bash|#\!/usr/bin/env bash|g' *.sh
sed -i '0,\|^.*bash|a set -x' *.sh
```

---

### The OR operator (match multiple conditions)

Test the expression: matches `>1` condition

```shell
% sed -n '/b2\|c3/p' /tmp/yo
a2 b2 c2
a3 b3 c3
```

Returns both lines that match the search criteria.

Test the output

```shell
% sed -n '/b2\|c3/ s/^/#/p' /tmp/yo
#a2 b2 c2
#a3 b3 c3

```

Make the change

`% sed -i '/b2\|c3/ s/^/#/p' /tmp/yo`

Verify the change
sed -n '/PAGER\|LESS/p' /path/file       

```shell
% cat /tmp/yo
a1 b1 c1
#a2 b2 c2
#a3 b3 c3
```







[official reference]:http://sed.sourceforge.net/sed1line.txt
