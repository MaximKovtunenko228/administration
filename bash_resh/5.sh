#!/bin/bash

output_file="logs.log"

# Очищаем файл вывода перед началом
> "$output_file"

# Проходим по всем файлам /var/log/*.log
for file in /var/log/*.log; do
    # Проверяем, что файл существует и это обычный файл
    if [ -f "$file" ]; then
        # Получаем последнюю строку
        last_line=$(tail -n 1 "$file")
        # Записываем в файл с указанием имени исходного файла
        echo "=== $file ===" >> "$output_file"
        echo "$last_line" >> "$output_file"
        echo >> "$output_file"  # пустая строка для разделения
    fi
done

echo "Последние строки файлов сохранены в '$output_file'."
