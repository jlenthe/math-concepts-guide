#!/usr/bin/env bash

TEXLIVE_IMAGE="texlive/texlive:latest-full"
BUILD_PDF_SCRIPT="scripts/build-pdf.sh"
BUILD_WEB_SCRIPT="scripts/build-web.sh"

# Default target values
PDF=0
WEB=0
CLEAN=0

print_usage() {
    echo "Usage: $0 [target]"
    echo "Targets:"
    echo "    pdf      Build PDF"
    echo "    web      Build web version"
    echo "    all      Build both PDF and web versions"
    echo "    clean    Remove all files from the out directory"
    echo "    help     Show this help message"
    echo
    echo "Examples:"
    echo "  $0 pdf      # Build PDF"
    echo "  $0 all      # Build both PDF and web version"
    echo "  $0 clean    # Clean the output directory"
}

container_run() {
    if [[ "$CONTAINER_EXEC" == "podman" ]]; then
        $CONTAINER_EXEC run --rm \
            --userns keep-id \
            -v "$(pwd)":/workdir:Z \
            -w /workdir \
            "$TEXLIVE_IMAGE" \
            "$@"
    elif [[ "$CONTAINER_EXEC" == "docker" ]]; then
        $CONTAINER_EXEC run --rm \
            --user "$(id -u):$(id -g)" \
            -v "$(pwd)":/workdir \
            -w /workdir \
            "$TEXLIVE_IMAGE" \
            "$@"
    else
        echo "Unsupported container execution method: $CONTAINER_EXEC"
        exit 1
    fi
}

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        pdf)
            PDF=1
            ;;
        web)
            WEB=1
            ;;
        all)
            PDF=1
            WEB=1
            ;;
        clean)
            CLEAN=1
            ;;
        help)
            print_usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo
            print_usage
            exit 1
            ;;
    esac
    shift
done

# Check for docker or podman
if command -v podman &> /dev/null; then
    CONTAINER_EXEC="podman"
elif command -v docker &> /dev/null; then
    CONTAINER_EXEC="docker"
else
    echo "Neither podman nor docker is installed. Please install one of them to use this script."
    exit 1
fi

# Check for build scripts
if [[ "$PDF" -eq 1 && ! -f "$BUILD_PDF_SCRIPT" ]]; then
    echo "Error: build-pdf.sh not found! Freaking out over here. Check git status?"
    exit 1
fi
if [[ "$WEB" -eq 1 && ! -f "$BUILD_PDF_SCRIPT" ]]; then
    echo "Error: build-web.sh not found! Freaking out over here. Check git status?"
    exit 1
fi

# Clean
if [[ "$CLEAN" -eq 1 ]]; then
    if [ -d out ]; then
        echo "Cleaning 'out' directory..."
        rm -rf out/*
    else
        echo "No out directory to clean."
    fi
fi

# PDF build
if [[ "$PDF" -eq 1 ]]; then
    echo "Building PDF..."
    container_run sh "$BUILD_PDF_SCRIPT"
fi

# Web build
if [[ "$WEB" -eq 1 ]]; then
    echo "Building web version..."
    container_run sh "$BUILD_WEB_SCRIPT"
fi

if [[ "$PDF" -eq 0 && "$WEB" -eq 0 && "$CLEAN" -eq 0 ]]; then
    echo "No target specified. Use 'help' for usage information."
    exit 1
fi
