#!/bin/bash

# Проверка переменных окружения
if [[ "$FOO" == "5" && "$BAR" == "1" ]]; then
    echo "Запрещено запускать скрипт при FOO=5 и BAR=1."
    exit 1
fi

echo "Ожидание появления нового файла в текущем каталоге: $(pwd)"

shopt -s nullglob

# Получаем список файлов, которые уже есть в каталоге при старте
existing_files=(*)

while true; do
    sleep 2  # задержка между проверками

    # Получаем текущий список файлов
    current_files=(*)

    # Проверяем, есть ли новые файлы, которых не было в existing_files
    for f in "${current_files[@]}"; do
        # Проверяем, что это файл (не каталог)
        if [ -f "$f" ]; then
            # Проверяем, есть ли файл в списке существующих
            found=false
            for ef in "${existing_files[@]}"; do
                if [[ "$f" == "$ef" ]]; then
                    found=true
                    break
                fi
            done

            # Если файл новый — выводим сообщение и завершаем
            if ! $found; then
                echo "Новый файл '$f' появился в каталоге."
                exit 0
            fi
        fi
    done
done
