#!/usr/bin/env bash
set -x

catalog_file="$HOME/code/00-project_catalog.txt"

{
    printf "# Project Catalog - %s\n\n" "$(date +%F)"

    find ~/code -type f -path '*/.git/config' -print0 |
        xargs -0 -I {} sh -c "
            project_dir=\$(dirname \"\$(dirname \"{}\")\")
            url=\$(git -C \"\$project_dir\" config --get remote.origin.url 2>/dev/null)
            [ -n \"\$url\" ] && printf \"%-60s %s\n\" \"\${project_dir#\$HOME/code/}\" \"\$url\"
        " |
        sort -k1,1
} > "$catalog_file"

cat "$catalog_file"

