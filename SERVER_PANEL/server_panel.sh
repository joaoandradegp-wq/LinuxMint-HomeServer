#!/bin/bash
set -e

# ----------------------------------------------------------------------
# Build of the Server Panel for Linux
# ----------------------------------------------------------------------

echo "Checking dependencies..."

if ! command -v python3 &> /dev/null; then
    echo "ERROR: python3 not found. Install it with: sudo apt install python3"
    exit 1
fi

if ! python3 -c "import tkinter" &> /dev/null; then
    echo "ERROR: tkinter module not found."
    echo "Install it with: sudo apt install python3-tk"
    exit 1
fi

if ! python3 -m PyInstaller --version &> /dev/null; then
    echo "ERROR: PyInstaller not found."
    echo "Install it with: pip3 install pyinstaller"
    exit 1
fi

echo "Building launcher..."

python3 -m PyInstaller \
    server_panel.py \
    --onefile \
    --noconsole \
    --name server_panel \
    --clean \
    --noupx

echo ""
echo "Build completed!"