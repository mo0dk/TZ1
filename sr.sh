#!/bin/bash

#    проверка на корректность ввода
if [ $# -ne 2 ]; then
  echo "Usage: $0 <input_dir> <output_dir>"
  exit 1
fi

input_dir="$1"
output_dir="$2"

# проверка на существование входной директории
if [ ! -d "$input_dir" ]; then
  echo "Input directory $input_dir does not exist"
  exit 1
fi

# если нет выходной, то создаем
mkdir -p "$output_dir"

# функция копирование файлов
copy_file() {
  local src="$1"
  local dst="$2"
  
  if [ -f "$dst" ]; then
    local i=1
    while [ -f "$dst.$i" ]; do
      ((i++))
    done
    dst="$dst.$i"
  fi
  
  cp "$src" "$dst"
}

# рекурсивный обход
shopt -s globstar
for file in "$input_dir"/**/*; do
  if [ -f "$file" ]; then
    filename=$(basename "$file")
    copy_file "$file" "$output_dir/$filename"
  fi
done