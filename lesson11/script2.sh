#!/bin/bash

# Константа для пути к директории
FOLDER_PATH=~/myfolder
TARGET_FILE="${FOLDER_PATH}/file2.txt"

# Проверяем, существует ли директория
if [ -d "$FOLDER_PATH" ]; then
    # Подсчитываем количество файлов в директории
    file_count=$(find "$FOLDER_PATH" -type f | wc -l)
    echo "В папке myfolder создано файлов: $file_count"

    # Изменяем права доступа для file2.txt, если файл существует
    if [ -f "$TARGET_FILE" ]; then
        chmod 664 "$TARGET_FILE"
    fi

    # Удаляем пустые файлы в директории
    find "$FOLDER_PATH" -type f -empty -delete

    # Удаляем содержимое всех файлов, кроме первой строки
    for file in "$FOLDER_PATH"/*; do
        if [ -f "$file" ]; then
            sed -i '2,$d' "$file"
        fi
    done
else
    echo "Папка $FOLDER_PATH не найдена."
fi
