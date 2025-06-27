#!/bin/bash

# Получаем все переменные окружения, начинающиеся на LC_
lc_vars=$(env | grep '^LC_')

# Проверяем, все ли LC_* переменные имеют одинаковое значение
first_value=$(echo "$lc_vars" | head -n 1 | cut -d= -f2)
all_equal=true

while IFS= read -r var; do
    current_value=$(echo "$var" | cut -d= -f2)
    if [ "$current_value" != "$first_value" ]; then
        all_equal=false
        break
    fi
done <<< "$lc_vars"

# Выводим результат
if $all_equal; then
    echo "Все LC_* переменные имеют одинаковое значение: $first_value"
else
    echo "Ошибка: Не все LC_* переменные имеют одинаковое значение."
    exit 1
fi
