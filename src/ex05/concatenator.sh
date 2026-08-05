#!/bin/sh

set -eu

OUTPUT="hh_positions.csv"

if [ "$#" -eq 0 ]; then
  set -- ./????-??-??.csv
fi

if [ ! -f "$1" ]; then
  printf 'Не найдены файлы с партициями\n' >&2
  exit 1
fi

first_file=true

for FILE in $(printf '%s\n' "$@" | LC_ALL=C sort)
do
  if [ "$first_file" = true ]; then
    cat "$FILE" > "$OUTPUT"
    first_file=false
  else
    tail -n +2 "$FILE" >> "$OUTPUT"
  fi
done
