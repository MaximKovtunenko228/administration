#!/bin/bash

# Проверка на наличие аргумента
if [ $# -eq 0 ]; then
    echo "Unknown planet"
    exit 1
fi

# Ассоциативный массив с количеством спутников для каждой планеты
declare -A planets=(
    ["Mercury"]=0
    ["Venus"]=0
    ["Earth"]=1
    ["Mars"]=2
    ["Jupiter"]=98
    ["Saturn"]=83
    ["Uranus"]=27
    ["Neptune"]=14
)

# Получение названия планеты из аргумента
planet="$1"

# Проверка, существует ли планета в массиве
if [[ -z "${planets[$planet]}" ]]; then
    echo "Unknown planet"
else
    # Вывод количества спутников
    echo "${planets[$planet]}"
fi
