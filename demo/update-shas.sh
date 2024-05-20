#!/usr/bin/env bash

type frizbee > /dev/null 2>&1 || {
    echo "no 'frizbee' installed, please install it from https://github.com/stacklok/frizbee"
    exit 1
}

echo "frizbee available, continue"

files=$(grep -sr "^FROM" * | cut -d":" -f1 | sort | uniq)

for file in $files; do
    echo "checking $file"

    base=$(grep "^FROM" $file | head -1 | cut -d' ' -f2)
    baseimg=$(echo $base | cut -d'@' -f1)
    prevhash=$(echo $base | cut -d'@' -f2 | cut -d' ' -f1)

    hash=$(frizbee containerimage one $baseimg | cut -d'@' -f2)
    [ $? -ne 0 ] && exit 1

    [ "x$verbose" != "x" ] && echo $prevhash ?= $hash

    if [ $prevhash != $hash ]; then
        echo "> updating hash in $file: $hash"

        sed -i s/$prevhash/$hash/ $file
    fi
done
