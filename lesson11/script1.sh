#!/bin/bash

# Константа для пути к директории
FOLDER_PATH=~/myfolder

# Массив с именами файлов
FILES=("file1.txt" "file2.txt" "file3.txt" "file4.txt" "file5.txt")

# Создаем директорию, если она не существует
mkdir -p "$FOLDER_PATH"

# Записываем приветствие и текущую дату в первый файл
echo -e "Привет!\n$(date)" > "${FOLDER_PATH}/${FILES[0]}"

# Создаем остальные файлы и применяем необходимые операции
for file in "${FILES[@]:1}"; do
    touch "${FOLDER_PATH}/$file"
done

# Применяем особые действия для file2.txt и file3.txt
chmod 777 "${FOLDER_PATH}/${FILES[1]}"
< /dev/urandom tr -dc 'A-Za-z0-9' | head -c 20 > "${FOLDER_PATH}/${FILES[2]}"
echo "" >> "${FOLDER_PATH}/${FILES[2]}"  # Добавляем перевод строки

# Проверка на успешное выполнение всех операций
all_files_created=true
for file in "${FILES[@]}"; do
    if [[ ! -f "${FOLDER_PATH}/$file" ]]; then
        all_files_created=false
        break
    fi
done

if $all_files_created; then
    echo "Все операции выполнены успешно."
    exit 0  # Успешный код возврата
else
    echo "Произошла ошибка при выполнении операций."
    exit 1  # Код возврата при ошибке
fi
