#!/bin/bash

display_help() {
    echo "Использование: $0 <путь к директории в кавычках для корректной обработки директорий с пробелами>"
    echo "Создает текстовые файлы с названиями подкаталогов и количеством элементов в каждом подкаталоге,"
    echo "а также файл с количеством элементов в самой указанной директории."
    echo "Файлы создаются в указанной директории."
}

if [ "$#" -ne 1 ]; then
    display_help
    exit 1
fi

TARGET_PATH="$1"

if [ ! -d "$TARGET_PATH" ]; then
    echo "Ошибка: Указанный путь '$TARGET_PATH' не существует или не является директорией."
    exit 1
fi

echo "Обработка директории: '$TARGET_PATH'"

# Подсчёт элементов в указанной директории
num_elements_root=$(ls -1q "$TARGET_PATH" | wc -l)
root_filename="${TARGET_PATH}/_root_directory.txt"
echo "$num_elements_root" > "$root_filename"
echo "Создан файл '$root_filename' с содержимым: $num_elements_root"

# Подсчёт элементов в каждом подкаталоге
find "$TARGET_PATH" -mindepth 1 -maxdepth 1 -type d | while read -r subdir; do
    subdir_name=$(basename "$subdir")
    num_elements=$(ls -1q "$subdir" | wc -l)
    output_filename="${TARGET_PATH}/${subdir_name}.txt"
    echo "$num_elements" > "$output_filename"
    echo "Создан файл '$output_filename' с содержимым: $num_elements"
done

echo "Обработка завершена!"
