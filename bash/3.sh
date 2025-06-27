#!/bin/bash

# Проверка на наличие аргументов
if [ $# -eq 0 ]; then
    echo "Ошибка: Не указаны файлы."
    exit 1
fi

# Перебор всех переданных файлов
for file in "$@"; do
    # Проверка на существование файла
    if [ ! -f "$file" ]; then
        echo "$file => not found"
    else
        # Подсчет количества строк в файле
        line_count=$(wc -l < "$file")
        echo "$file => $line_count"
    fi
done
