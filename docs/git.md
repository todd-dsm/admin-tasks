# git

These are scraps of git commands that I use regularly.

## Fetch all branches from origin

You'll do a git clone $repo..., check branches and find you only have main. Run this command to fetch all branches:

```sh
git branch -r | grep -v '\->' | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
git fetch --all
git pull --all
```

~[Wookie88]

## Reset the repo history back one/current commit

Sometimes you just need to boil everything down to a new starting point; for those times:

```sh
git reset $(git commit-tree HEAD^{tree} -m "Initial Commit")
```

~[taylorsmithgg]

[Wookie88]:https://stackoverflow.com/a/10312587
[taylorsmithgg]:https://github.com/taylorsmithgg
