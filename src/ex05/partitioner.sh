#!/bin/sh

set -eu

INPUT=${1:-../ex03/hh_positions.csv}
OUTPUT_DIR=${2:-.}

HEADER=$(head -n 1 "$INPUT")

rm -f "$OUTPUT_DIR"/????-??-??.csv

tail -n +2 "$INPUT" |
while IFS= read -r line || [ -n "$line" ]
do
  date=$(printf '%s\n' "$line" |
    sed -E 's/^"[^"]*","([0-9]{4}-[0-9]{2}-[0-9]{2})T.*$/\1/')

  case "$date" in
    ????-??-??)
      ;;
    *)
      printf 'Не удалось извлечь дату из строки:\n%s\n' "$line" >&2
      exit 1
      ;;
  esac

  FILE="$OUTPUT_DIR/$date.csv"

  if [ ! -f "$FILE" ]; then
    printf '%s\n' "$HEADER" > "$FILE"
  fi

  printf '%s\n' "$line" >> "$FILE"
done
