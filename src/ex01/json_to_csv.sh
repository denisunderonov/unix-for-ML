#!/bin/sh

if [ ! -f hh.json]; then 
    echo "Файл json не найден"
    exit 1
fi

jq -r -f filter.jq hh.json > hh.csv

if [ $? -eq 0 ] && [ -s hh.csv ]; then
  echo "Файл hh.csv успешно создан."
else
  echo "Ошибка при создании hh.csv"
  exit 1
fi
