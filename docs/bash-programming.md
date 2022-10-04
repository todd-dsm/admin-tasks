# Bash Programming

## Common Tasks

redirect [all output to /dev/null]

```shell
> /dev/null 2>&1
```

example:

```shell
% ls -l /tmp/yo > /dev/null 2>&1
% ls -l /tmp/no > /dev/null 2>&1
```

`/tmp/yo` exists while `/tmp/no` does not; in both cases there is no output.

---

[all output to /dev/null]:https://unix.stackexchange.com/a/119650/111917
