path=docs/figures
for entry in "$path"/*.typ
do
  name=${entry#*figures/}
  name=${name%.*}
  out="$path/out/$name"
  echo "$name"
  typst c "$entry" "$out.svg" --format svg --root .
  typst c "$entry" "$out-dark.svg" --format svg --root . --input dark=true
done