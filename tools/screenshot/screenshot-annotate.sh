#!/bin/bash
#
# Screenshot and Annotate Tool
# Solves the Flameshot HiDPI/multi-monitor scaling issue on Ubuntu
# Workflow: Screenshot → Drawing annotation → Clipboard
#
# Author: Auto-generated for ubuntu_init
# Compatible: Ubuntu 18.04+, X11/Wayland, HiDPI, Multi-monitor
#

set -e

# Configuration
TEMP_DIR="/tmp"
SCREENSHOT_FILE="${TEMP_DIR}/screenshot_$(date +%Y%m%d_%H%M%S).png"
NOTIFY_ENABLED=true

# Color output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function: Print colored message
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Function: Check dependencies
check_dependencies() {
    local missing_deps=()

    if ! command -v gnome-screenshot &> /dev/null; then
        missing_deps+=("gnome-screenshot")
    fi

    if ! command -v drawing &> /dev/null; then
        missing_deps+=("drawing")
    fi

    if ! command -v xclip &> /dev/null; then
        missing_deps+=("xclip")
    fi

    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_message "$RED" "Error: Missing dependencies: ${missing_deps[*]}"
        print_message "$YELLOW" "Please run: sudo apt install ${missing_deps[*]}"
        print_message "$YELLOW" "Or run the install.sh script in this directory"
        exit 1
    fi
}

# Function: Take screenshot
take_screenshot() {
    print_message "$GREEN" "Select area to screenshot..."

    if gnome-screenshot -a -f "$SCREENSHOT_FILE"; then
        print_message "$GREEN" "Screenshot captured: $SCREENSHOT_FILE"
        return 0
    else
        print_message "$RED" "Screenshot cancelled or failed"
        return 1
    fi
}

# Function: Open Drawing for annotation
annotate_screenshot() {
    print_message "$GREEN" "Opening Drawing for annotation..."
    print_message "$YELLOW" "Tip: Close Drawing window when done to copy to clipboard"

    # Open Drawing and wait for it to close
    drawing "$SCREENSHOT_FILE"

    print_message "$GREEN" "Annotation complete"
}

# Function: Copy to clipboard
copy_to_clipboard() {
    print_message "$GREEN" "Copying to clipboard..."

    # Check if file still exists (user might have saved it elsewhere)
    if [ ! -f "$SCREENSHOT_FILE" ]; then
        print_message "$RED" "Screenshot file not found. It may have been moved or deleted."
        return 1
    fi

    # Copy to clipboard using xclip
    if xclip -selection clipboard -t image/png -i "$SCREENSHOT_FILE"; then
        print_message "$GREEN" "Screenshot copied to clipboard! You can now paste it with Ctrl+V"

        # Send desktop notification if notify-send is available
        if command -v notify-send &> /dev/null && [ "$NOTIFY_ENABLED" = true ]; then
            notify-send "Screenshot Ready" "Annotated screenshot copied to clipboard" -i "$SCREENSHOT_FILE" -t 3000
        fi

        return 0
    else
        print_message "$RED" "Failed to copy to clipboard"
        return 1
    fi
}

# Function: Cleanup
cleanup() {
    # Optional: Remove temp file after a delay (keep it for a while in case user wants to save it)
    # Uncomment the following line if you want auto-cleanup:
    # sleep 300 && rm -f "$SCREENSHOT_FILE" &
    :
}

# Main workflow
main() {
    print_message "$GREEN" "=== Screenshot & Annotate Tool ==="
    print_message "$YELLOW" "Workflow: Screenshot → Annotation → Clipboard"
    echo ""

    # Check dependencies
    check_dependencies

    # Step 1: Take screenshot
    if ! take_screenshot; then
        exit 1
    fi

    # Step 2: Annotate with Drawing
    annotate_screenshot

    # Step 3: Copy to clipboard
    copy_to_clipboard

    # Cleanup
    cleanup

    print_message "$GREEN" "=== Done! ==="
}

# Run main function
main "$@"
