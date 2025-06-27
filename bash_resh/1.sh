#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Использование: $0 <имя_файла> <время_в_секундах>"
    exit 1
fi

OUTFILE="$1"
DURATION="$2"

# Очистка файла перед началом записи
> "$OUTFILE"

end=$((SECONDS + DURATION))

while [ $SECONDS -lt $end ]; do
    timestamp=$(date +"[%d.%m.%y %H:%M:%S]")
    loadavg=$(cat /proc/loadavg)
    echo "$timestamp = $loadavg" >> "$OUTFILE"
    sleep 1
done

