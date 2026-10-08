#!/bin/bash

model_name=$(basename "$1" .scad)
output_file=/tmp/$model_name.3mf

echo "Building $model_name"
rm -f "$output_file"

openscad --enable=lazy-union --enable=textmetrics --backend=manifold "$1" -o "$output_file"

if [ ! -f "$output_file" ]; then
  echo "ERROR: Build failed - $output_file was not created!" >&2
  exit 1
fi

open -a "BambuStudio" "$output_file"
