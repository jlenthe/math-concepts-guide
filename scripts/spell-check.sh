#!/usr/bin/env sh

for file in src/*.tex; do
  aspell --mode=tex --personal=./word-list.txt --dont-backup check "$file"
done

