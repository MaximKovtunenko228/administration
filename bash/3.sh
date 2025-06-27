#!/bin/bash

if [ "$#" -eq 0 ]; then
    echo "Использование: $0 <файл1> <файл2> ... <файлN>"
    echo "Если указан путь — подсчитывается строки в этом файле."
    echo "Если указано только имя файла — ищутся все файлы с таким именем по всему диску."
    exit 1
fi

for input in "$@"; do
    if [[ "$input" == */* ]]; then
        # Путь указан
        if [ ! -e "$input" ]; then
            echo "Ошибка: файл '$input' не существует."
            continue
        fi
        if [ ! -f "$input" ]; then
            echo "Ошибка: '$input' не является обычным файлом."
            continue
        fi
        line_count=$(wc -l < "$input")
        echo "Файл '$input' содержит $line_count строк(и)."
    else
        # Только имя файла — ищем по всему диску
        echo "Ищем файлы с именем '$input' по всему диску..."
        # Используем find, игнорируя ошибки доступа
        mapfile -t found_files < <(find / -type f -name "$input" 2>/dev/null)

        if [ "${#found_files[@]}" -eq 0 ]; then
            echo "Файлы с именем '$input' не найдены."
            continue
        fi

        for f in "${found_files[@]}"; do
            line_count=$(wc -l < "$f")
            echo "Файл '$f' содержит $line_count строк(и)."
        done
    fi
done
