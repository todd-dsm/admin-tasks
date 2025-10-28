# Sample Scripts

Example scripts, using these few tools.

## The Scripts

I'm starting to move some old stuff over for reference. It's slow but more is coming.

### project-catalog.sh

Generates a catalog of all Git repositories under `~/code` with their remote URLs.

- Searches recursively for all `.git/config` files
- Extracts the remote origin URL from each repository
- Outputs a sorted list showing project paths and their corresponding Git URLs
- Creates `project_catalog.txt` with timestamped results

Example output

```shell
# Project Catalog - 2025-10-27
client/project-alpha            git@github.com:user/project-alpha.git
internal/tools/helper           https://github.com/user/helper.git
web/my-app                      git@github.com:user/my-app.git
```

*NOTE: ignores repositories without a configured remote origin URL.*

### ???
