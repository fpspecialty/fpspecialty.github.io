#!/bin/bash

DIR=$1
QUALITY="100"

echo "_____"
echo "Converting all non-webp images in: \"$DIR\""
echo "Old images left untouched."
echo "No resizing."
echo "Quality: $QUALITY"

echo "Compression results in kB:"
for filename in $(find "${DIR}" -name '*.jpg' -or -name '*.png' -or -name '*.gif' -or -name '*.jpeg'); do

  # calculate names
  extension="${filename##*.}"
  base="$(basename -- "$filename" ".$extension")"
  dir="$(dirname $filename)"
  dest_filename="$dir/$base.webp"

  # memorize initial size
  size_before=$(du -sk "$filename" | cut -f1)

  # compress and memorize sizes
  convert "$filename" -quality "$QUALITY" -define webp:lossless=false -define webp:method=6 -define webp:partitions=3 -define webp:auto-filter=true "$dest_filename"
  dest_size=$(du -sk "$dest_filename" | cut -f1)

  # show results
  echo "$filename: $size_before -> $dest_size"
done
