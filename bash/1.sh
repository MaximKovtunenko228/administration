#!/bin/bash

# Проверяем, переданы ли два аргумента: имя файла и длительность
if [ "$#" -ne 2 ]; then
    echo "Использование: $0 <имя_файла> <длительность_в_секундах>"
    exit 1
fi

output_file=$1
duration=$2

# Запоминаем текущее время в секундах
start_time=$(date +%s)

# Основной цикл, который работает в течение заданного времени
while [ $(($(date +%s) - start_time)) -lt $duration ]; do
    # Получаем текущее время в формате dd.mm.yy hh:mi
    current_time=$(date +"%d.%m.%y %H:%M")
    
    # Читаем среднюю загрузку системы из /proc/loadavg
    load_avg=$(cat /proc/loadavg)
    
    # Записываем данные в файл в указанном формате
    echo "$current_time = $load_avg" >> "$output_file"
    
    # Ждём 1 секунду перед следующей итерацией
    sleep 1
done

echo "Данные сохранены в $output_file"
