#!/usr/bin/env bash

# find all post files, append their date, sort by date, then remove the date again
post_sources="$(find src/posts -type f -exec bash -c 'echo "{} $(grep "date:" {} | cut -c7-)"' \; | sort -rk2 | cut -d' ' -f1)"
cp src/index.md index-p.md

for file in $post_sources; do
    title="$(grep "title:" "$file" | cut -c8- )"
    if [ -n "$title" ]; then
        url="$(echo "${file%.md}.html" | cut -c4- )"
        echo "* [$title]($url)" >> index-p.md
    fi
done
