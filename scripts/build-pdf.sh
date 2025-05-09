#!/usr/bin/env sh

# Configuration vars
SRC_DIR="src"
OUT_DIR="../out/pdf"
TEX_FILE="main.tex"
JOB_NAME="Guide-to-Basic-Mathematical-Concepts"

set -eu  # Exit on error. Treat unset variables as errors.

compile_latex() {
    echo "Running pdflatex ($1 pass)..."
    if ! pdflatex -halt-on-error \
                  -output-directory="$OUT_DIR" \
                  -jobname="$JOB_NAME" \
                  "$TEX_FILE"; then
        echo "pdflatex failed during $1 pass." >&2
        exit 1
    fi
}

(
    cd "$SRC_DIR"
    mkdir -p "$OUT_DIR"

    # Run LaTeX in two passes.
    # The second pass is needed to resolve the table of contents.
    compile_latex "first"
    compile_latex "second"
)
