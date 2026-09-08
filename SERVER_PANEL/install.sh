#!/bin/bash
set -e

# ----------------------------------------------------------------------
# Server Panel Installer for Linux
# Downloads the source code, builds it with PyInstaller and installs
# the resulting binary
# ----------------------------------------------------------------------

REPO_RAW="https://raw.githubusercontent.com/joaoandradegp-wq/LinuxMint_HomeServer/refs/heads/main/SERVER_PANEL"
PY_FILE="server_panel.py"
INSTALL_DIR="$HOME/.local/bin"
WORKDIR="$(mktemp -d)"

cleanup() {
    rm -rf "$WORKDIR"
}
trap cleanup EXIT

echo "=== Server Panel - Installer ==="
echo ""
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
    echo "PyInstaller not found. Installing for the current user..."
    pip3 install --user pyinstaller
fi

echo ""
echo "Downloading source code..."
curl -fsSL "$REPO_RAW/$PY_FILE" -o "$WORKDIR/$PY_FILE"

cd "$WORKDIR"

echo "Building..."
python3 -m PyInstaller \
    "$PY_FILE" \
    --onefile \
    --noconsole \
    --name server_panel \
    --clean \
    --noupx

echo ""
echo "Installing binary to $INSTALL_DIR ..."
mkdir -p "$INSTALL_DIR"
cp "dist/server_panel" "$INSTALL_DIR/server_panel"
chmod +x "$INSTALL_DIR/server_panel"

echo ""
echo "Installation complete!"
echo "Binary: $INSTALL_DIR/server_panel"

# ----------------------------------------------------------------------
# Desktop icon
# ----------------------------------------------------------------------
DESKTOP_DIR="$(xdg-user-dir DESKTOP 2>/dev/null || echo "$HOME/Desktop")"
mkdir -p "$DESKTOP_DIR"
DESKTOP_FILE="$DESKTOP_DIR/server_panel.desktop"

cat > "$DESKTOP_FILE" << EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=Server Panel
Comment=Server Panel
Exec="$INSTALL_DIR/server_panel"
Icon=unity-tweak-tool
Terminal=false
Categories=Utility;
EOL

chmod +x "$DESKTOP_FILE"
# Marks the .desktop file as trusted so it can be launched with a double-click
# on file managers that check this (Nautilus/GNOME, Cinnamon/Nemo).
gio set "$DESKTOP_FILE" metadata::trusted true 2>/dev/null || true

echo "Desktop icon: $DESKTOP_FILE"

if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "WARNING: $INSTALL_DIR is not in your PATH."
    echo "Add this line to your ~/.bashrc (or ~/.profile):"
    echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo "Then run 'server_panel' from anywhere."
else
    echo "Run it with: server_panel"
fi
