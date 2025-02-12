#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

dir="$1"

# Find all image files
# (case insensitive)
images=($(find "$dir" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" \) | sort))

if [ ${#images[@]} -eq 0 ]; then
  echo "No images found in the specified directory."
  exit 1
fi

# The generated table will be quite messy, and we don't have a way of validating it
# unless we get into parsing HTML with regex or something
# https://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags
echo "| Column 1 | Column 2 | Column 3 | Column 4 |"
echo "| -------- | -------- | -------- | -------- |"

for ((i = 0; i < ${#images[@]}; i += 4)); do
  row="|"
  for ((j = 0; j < 4; j++)); do
    if ((i + j < ${#images[@]})); then
      file="${images[i + j]}"
      filename="$(basename "$file")"
      filepath="./${file#*/}"
      row+=" ![$filename]($filepath) |"
    else
      row+="  |" # empty cell if no image
    fi
  done
  echo "$row"
done
