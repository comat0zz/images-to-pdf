#!/bin/env sh

IN_DIR="$1"
OUT_DIR="out"
LIST_DIR=$(find $IN_DIR -iregex '.*\.\(jpg\|png\|gif\|jpeg\)' -printf '%f\n')
OUT_EXT="jpg"

if [ -d "$OUT_DIR" ]; then
  rm -rf "$OUT_DIR"
elif [ -f "$OUT_DIR" ]; then
  echo "File with this name already exists, not a directory."
  exit
fi

mkdir -p $OUT_DIR

for file in $LIST_DIR
do
  filename=$(basename "$file" | cut -d. -f1)
  convert "$IN_DIR/$file" -quality 50% "$OUT_DIR/$filename.$OUT_EXT"
done 

convert "$OUT_DIR/*.$OUT_EXT" -compress jpeg pictures.pdf