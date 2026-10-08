#!/bin/bash
# Builds everything in output/ from defaultbox.scad:
#   output/top.stl, bottom.stl, latch.stl  - printable parts
#   output/complete.stl                    - assembled box
#   docs/rendering.png                     - preview image used by the README
set -euo pipefail

cd "$(dirname "$0")/.."
src=defaultbox.scad
out=output
flags=(--enable=lazy-union --enable=textmetrics --backend=manifold)
stl=(--export-format binstl)

mkdir -p "$out/customized" docs

build() { # <View> <output file>
  echo "Building $2"
  openscad "${flags[@]}" "${stl[@]}" -D "View=\"$1\"" "$src" -o "$2"
}

build "Lid" "$out/top.stl"
build "Bottom" "$out/bottom.stl"
build "Latch" "$out/latch.stl"
build "Complete" "$out/complete.stl"

echo "Rendering docs/rendering.png"
openscad "${flags[@]}" -D 'View="Complete Open"' \
  --imgsize=1600,1200 --autocenter --viewall --projection=p \
  --camera=0,0,0,60,0,320,0 --colorscheme=Tomorrow \
  "$src" -o docs/rendering.png

echo "Done. Custom slicer projects live in $out/customized/"
