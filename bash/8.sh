#!/bin/bash

# Получаем все переменные окружения, начинающиеся с LC_
lc_vars=$(env | grep '^LC_' | cut -d= -f2)

# Если переменных LC_ нет, считаем, что проверка пройдена
if [ -z "$lc_vars" ]; then
    echo "Переменные LC_ не найдены."
    exit 0
fi

# Сохраняем первое значение для сравнения
first_value=$(echo "$lc_vars" | head -n1)

# Проверяем все значения
while IFS= read -r val; do
    if [ "$val" != "$first_value" ]; then
        echo "Ошибка: значения переменных LC_ не совпадают."
        exit 1
    fi
done <<< "$lc_vars"

echo "Все переменные LC_ имеют одинаковое значение: $first_value"
exit 0
