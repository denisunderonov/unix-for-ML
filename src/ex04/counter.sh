#!/bin/sh

INPUT="../ex03/hh_positions.csv"
OUTPUT="hh_uniq_positions.csv"

printf '"name","count"\n' > "$OUTPUT"

tail -n +2 "$INPUT" |
  sed -E 's/^"[^"]*","[^"]*","([^"]*)".*/\1/' |
  sort |
  uniq -c |
  sort -rn |
  awk '{
    count = $1
    $1 = ""
    sub(/^ /, "")
    printf "\"%s\",%d\n", $0, count
  }' >> "$OUTPUT"
