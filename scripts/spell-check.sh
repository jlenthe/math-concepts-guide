#!/usr/bin/env sh
if ! command -v aspell >/dev/null 2>&1; then
  echo "Error: aspell is not installed." >&2
  exit 1
fi

for file in src/*.tex; do
  aspell --mode=tex --personal=./word-list.txt --dont-backup check "$file"
done

