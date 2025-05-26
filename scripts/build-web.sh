#!/usr/bin/env sh

# Configuration
SRC_DIR="src"
OUT_DIR="out/html"
TEX_FILE="main.tex"

set -eu  # Exit on error. Treat unset variables as errors.

mkdir -p "$OUT_DIR"
cp "$SRC_DIR"/*.tex "$OUT_DIR/"
cp -r "$SRC_DIR"/images "$OUT_DIR/"

# Run make4ht inside the output directory
cd "$OUT_DIR"
make4ht "$TEX_FILE" "mathjax,mathml,html5"
rm -f ./*.tex  # Clean up copied .tex files

