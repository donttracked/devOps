#!/bin/bash

if [ -d ~/myfolder ]; then
    file_count=$(find ~/myfolder -type f | wc -l)
    echo "В папке myfolder создано файлов: $file_count"

    if [ -f ~/myfolder/file2.txt ]; then
        chmod 664 ~/myfolder/file2.txt
    fi

    find ~/myfolder -type f -empty -delete

    for file in ~/myfolder/*; do
        if [ -f "$file" ]; then
            sed -i '2,$d' "$file"
        fi
    done
else
    echo "Папка ~/myfolder не найдена."
fi
