#!/bin/bash
#
# Installation script for Screenshot & Annotate Tool
# Installs dependencies and sets up keyboard shortcut
#

set -e

# Color output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

print_message "$BLUE" "=== Screenshot & Annotate Tool Installation ==="
echo ""

# Step 1: Install dependencies
print_message "$YELLOW" "Step 1: Installing dependencies..."
sudo apt update
sudo apt install -y gnome-screenshot drawing xclip

# Verify installation
if command -v gnome-screenshot &> /dev/null && \
   command -v drawing &> /dev/null && \
   command -v xclip &> /dev/null; then
    print_message "$GREEN" "✓ All dependencies installed successfully"
else
    print_message "$RED" "✗ Some dependencies failed to install"
    exit 1
fi

# Step 2: Make script executable
print_message "$YELLOW" "Step 2: Making script executable..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
chmod +x "$SCRIPT_DIR/screenshot-annotate.sh"
print_message "$GREEN" "✓ Script is now executable"

# Step 3: Create symlink in ~/bin (optional but recommended)
print_message "$YELLOW" "Step 3: Setting up command shortcut..."
mkdir -p ~/bin

if [ ! -f ~/bin/screenshot-annotate ]; then
    ln -s "$SCRIPT_DIR/screenshot-annotate.sh" ~/bin/screenshot-annotate
    print_message "$GREEN" "✓ Created symlink: ~/bin/screenshot-annotate"
else
    print_message "$YELLOW" "⚠ Symlink already exists: ~/bin/screenshot-annotate"
fi

# Ensure ~/bin is in PATH
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
    print_message "$GREEN" "✓ Added ~/bin to PATH in ~/.bashrc"
    print_message "$YELLOW" "  Please run: source ~/.bashrc"
else
    print_message "$GREEN" "✓ ~/bin is already in PATH"
fi

# Step 4: Instructions for keyboard shortcut
echo ""
print_message "$BLUE" "=== Installation Complete! ==="
echo ""
print_message "$GREEN" "You can now run the tool with:"
print_message "$YELLOW" "  screenshot-annotate"
echo ""
print_message "$YELLOW" "To set up a keyboard shortcut (recommended: Ctrl+Shift+S):"
print_message "$BLUE" "1. Open Settings → Keyboard → Keyboard Shortcuts"
print_message "$BLUE" "2. Scroll down and click '+' to add custom shortcut"
print_message "$BLUE" "3. Name: Screenshot & Annotate"
print_message "$BLUE" "4. Command: $HOME/bin/screenshot-annotate"
print_message "$BLUE" "5. Shortcut: Press Ctrl+Shift+S (or your preferred combo)"
echo ""

# Step 5: Test the installation
print_message "$YELLOW" "Would you like to test the screenshot tool now? (y/n)"
read -r response
if [[ "$response" =~ ^[Yy]$ ]]; then
    print_message "$GREEN" "Launching screenshot tool..."
    "$SCRIPT_DIR/screenshot-annotate.sh"
else
    print_message "$GREEN" "You can test it later by running: screenshot-annotate"
fi

echo ""
print_message "$GREEN" "Setup complete! Enjoy your new screenshot tool! 📸"
