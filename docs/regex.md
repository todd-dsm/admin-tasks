# regex

Looking for ***types*** of data is sometimes more revealing than digging through structured data. What we sometimes find are answers to questions we didn't think to ask.

There are some resources below.

## ORing

Based on this data, `grep` can be used to match elements that may OR may not be present on the line OR may be separated.

```shell
% cat /tmp/yo
secret/webapp
secret/webapp/config
secret/data/webapp/config
```

```shell
grep -E "secret/(data/)?(common/)?webapp(/config)?" /tmp/yo
```

Resources:

- [RegExOne] - learning
- [Regex101] - calculating

<!-- docs/refs -->

[Regex101]:https://regex101.com/
[RegExOne]:https://regexone.com/
