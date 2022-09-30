# Systems Programming

### Vim - The Power and The Glory

* [Using Vim]
* [Customizing Vim]

Global Search and Replace

```shell
:%s/search_string/replacement_string/g
```

Delete a range of lines, starting with line n through m, followed by a d (delete):

```shell
:1,7d
```
(this will delete the range of lines 1 through 7)

Comment multiple lines

```shell
:1,$s/^#/\ \ /g
```

This line can be broken down as
* To start from 1st line
* `$` To end at the last line
* `s/^` Search for the start of the line
* `/#`  Replace with # (but this could be any system-specific ASCII character;
* `/g`  Replace globally (all occurrences). Omit this final ‘g’ to make it non-global.

Again, only for line 39

`39,%s/^/\ /g`

Uncomment lines 4-45

`4,45s/^#//g`

Move indentation to left for every line

`:%normal <<`

Move indentation to left for lines between 13-22

`:1,$%normal <<`

Remove the first 2 characters of every line:

`:%normal 2x`

Again, only for lines between 44-1006

`:44,1006%normal 2x`

Remove first 2 characters of every line, only if they're spaces:

`:%s/^  /`

Again, only for lines between 10-16

`:10,16%s/^  /`

And so on. Here are some more [helpers]; a vim [cookbook].

[Using Vim]:https://jovicailic.org/mastering-vim-quickly/
[Customizing Vim]:https://learnvimscriptthehardway.stevelosh.com/
[helpers]:http://vim.wikia.com/wiki/Search_and_replace
[cookbook]:http://www.oualline.com/vim/vim-cook.html
