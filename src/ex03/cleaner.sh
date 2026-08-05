#!/bin/sh

INPUT="../ex02/hh_sorted.csv"
OUTPUT="hh_positions.csv"

head -n 1 "$INPUT" > "$OUTPUT"

tail -n +2 "$INPUT" |
while IFS= read -r line
do
  name=$(printf '%s\n' "$line" |
    sed -E 's/^"[^"]*","[^"]*","([^"]*)".*/\1/')

  position=$(printf '%s\n' "$name" |
    grep -oE 'Junior|Middle|Senior' |
    paste -sd '/' -)

  if [ -z "$position" ]; then
    position="-"
  fi

  printf '%s\n' "$line" |
    sed -E 's/^("[^"]*","[^"]*",)"[^"]*"/\1"'"$position"'"/' \
    >> "$OUTPUT"
done
