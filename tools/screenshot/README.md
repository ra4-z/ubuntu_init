# Screenshot & Annotate Tool

A reliable screenshot and annotation solution for Ubuntu that **solves the Flameshot HiDPI/multi-monitor scaling issues**.

## Problem Solved

Flameshot (especially version 0.6.0) has critical bugs when switching between different resolution monitors (e.g., 1080P → 2K):
- ❌ Only captures partial screen area
- ❌ Coordinate offset issues with HiDPI scaling
- ❌ Broken on multi-monitor setups with different DPIs

This tool uses **GNOME Screenshot + Drawing** which:
- ✅ Works perfectly with HiDPI and mixed DPI monitors
- ✅ Stable on both X11 and Wayland
- ✅ No coordinate offset issues
- ✅ Native Ubuntu integration

## Features

- 📸 **Accurate screenshot capture** - Works on 2K/4K/multi-monitor setups
- 🎨 **Full annotation support** - Rectangles, arrows, text, blur, freehand drawing
- 📋 **Clipboard integration** - Automatically copies annotated image for instant paste
- 🔔 **Desktop notifications** - Visual feedback when screenshot is ready
- ⚡ **Fast workflow** - One command from screenshot to clipboard
- 🎯 **No DPI issues** - Unlike Flameshot, coordinates are always correct

## Workflow

```
1. Run command (or press keyboard shortcut)
   ↓
2. Select screen area to capture
   ↓
3. Drawing app opens automatically with your screenshot
   ↓
4. Annotate (add arrows, text, rectangles, blur, etc.)
   ↓
5. Close Drawing window
   ↓
6. Screenshot automatically copied to clipboard
   ↓
7. Paste anywhere with Ctrl+V
```

## Requirements

- Ubuntu 18.04+ (or any GNOME-based distribution)
- X11 or Wayland session
- Internet connection for initial package installation

## Installation

### Quick Install (Recommended)

```bash
cd tools/screenshot
./install.sh
```

The installation script will:
1. Install all dependencies (`gnome-screenshot`, `drawing`, `xclip`)
2. Make the script executable
3. Create a convenient `screenshot-annotate` command
4. Provide instructions for keyboard shortcut setup

### Manual Installation

If you prefer to install manually:

```bash
# Install dependencies
sudo apt update
sudo apt install gnome-screenshot drawing xclip

# Make script executable
chmod +x screenshot-annotate.sh

# Create symlink (optional)
mkdir -p ~/bin
ln -s $(pwd)/screenshot-annotate.sh ~/bin/screenshot-annotate
```

## Usage

### Command Line

```bash
# If you installed via install.sh
screenshot-annotate

# Or run directly
./screenshot-annotate.sh
```

### Keyboard Shortcut (Recommended)

Set up a keyboard shortcut for instant access:

1. Open **Settings** → **Keyboard** → **Keyboard Shortcuts**
2. Scroll to bottom and click **+** (Add custom shortcut)
3. Fill in:
   - **Name:** `Screenshot & Annotate`
   - **Command:** `/home/YOUR_USERNAME/bin/screenshot-annotate`
   - **Shortcut:** Press `Ctrl+Shift+S` (or any preferred combination)
4. Click **Add**

Now you can press `Ctrl+Shift+S` anytime to start the screenshot workflow!

## Drawing App - Annotation Tools

When Drawing opens, you'll have access to:

| Tool | Icon | Description |
|------|------|-------------|
| Rectangle | 🟥 | Draw boxes to highlight areas |
| Arrow | ➡️ | Point to specific elements |
| Line | ➖ | Draw straight lines |
| Freehand | ✏️ | Draw freeform shapes |
| Text | 🅰️ | Add text annotations |
| Blur | 🌫 | Blur/pixelate sensitive information |
| Color Picker | 🎨 | Change colors of annotations |
| Undo/Redo | ↩️↪️ | Fix mistakes |

### Shortcuts in Drawing

- `Ctrl+Z` - Undo
- `Ctrl+Y` - Redo
- `Ctrl+S` - Save
- `Ctrl+C` - Copy to clipboard
- `Ctrl+Q` - Quit (triggers auto-copy)

## Technical Details

### Why This Works Better Than Flameshot

1. **GNOME Screenshot** reads directly from the compositor's framebuffer
   - No Qt scaling issues
   - No logical-to-physical pixel conversion errors
   - Native Wayland support

2. **Drawing** uses GTK (not Qt)
   - Perfect DPI awareness
   - No HiDPI scaling bugs
   - Lightweight and fast

3. **Direct clipboard integration**
   - Uses `xclip` for reliable clipboard operations
   - Supports PNG format
   - Works with all applications (browsers, chat apps, documents)

### Compatibility Matrix

| Environment | Status |
|-------------|--------|
| Ubuntu 18.04+ | ✅ Fully supported |
| X11 | ✅ Fully supported |
| Wayland | ✅ Fully supported |
| HiDPI (2K/4K) | ✅ Perfect scaling |
| Multi-monitor | ✅ No offset issues |
| Mixed DPI monitors | ✅ Works correctly |

## Troubleshooting

### "Command not found: screenshot-annotate"

Make sure `~/bin` is in your PATH:

```bash
export PATH="$HOME/bin:$PATH"
source ~/.bashrc
```

### "Missing dependencies" error

Run the installation script again:

```bash
./install.sh
```

Or install manually:

```bash
sudo apt install gnome-screenshot drawing xclip
```

### Screenshot not copying to clipboard

1. Make sure you **close the Drawing window** (don't just minimize it)
2. Verify `xclip` is installed: `which xclip`
3. On Wayland, ensure clipboard permissions are granted

### Drawing doesn't open

Check if Drawing is installed:

```bash
which drawing
```

If not found:

```bash
sudo apt install drawing
```

## Configuration

You can customize the script by editing `screenshot-annotate.sh`:

- **Line 12:** Change `TEMP_DIR` to save screenshots elsewhere
- **Line 14:** Set `NOTIFY_ENABLED=false` to disable notifications
- **Line 103:** Uncomment auto-cleanup to delete temp files after 5 minutes

## Comparison: Flameshot vs This Tool

| Feature | Flameshot 0.6.0 | Screenshot & Annotate |
|---------|-----------------|----------------------|
| HiDPI support | ❌ Broken | ✅ Perfect |
| Multi-monitor | ❌ Offset issues | ✅ Works correctly |
| 1080P→2K switching | ❌ Partial capture | ✅ Full capture |
| Wayland support | ⚠️ Limited | ✅ Native |
| Annotation tools | ✅ Built-in | ✅ Via Drawing |
| Clipboard copy | ✅ Yes | ✅ Yes |
| One-click workflow | ✅ Yes | ✅ Yes |
| Stability | ❌ Buggy | ✅ Rock solid |

## FAQ

**Q: Can I still use Flameshot for some tasks?**
A: Yes, but upgrade to Flameshot 12.0+ which has better HiDPI support. For critical work on multi-monitor setups, this tool is more reliable.

**Q: Will this work on KDE/XFCE?**
A: Yes, as long as you have GNOME Screenshot and Drawing installed. The tool is desktop-environment agnostic.

**Q: Can I save the screenshot instead of copying to clipboard?**
A: Yes! In Drawing, use `File → Save As` or press `Ctrl+S` before closing the window.

**Q: Does this slow down my workflow?**
A: No - the workflow is just as fast as Flameshot once you set up the keyboard shortcut.

**Q: Where are temporary screenshots stored?**
A: In `/tmp/screenshot_YYYYMMDD_HHMMSS.png`. They persist until you reboot (or manually delete them).

## License

This tool is part of the ubuntu_init repository and follows the same license.

## Contributing

Found a bug or have a suggestion? Please open an issue in the main repository.

## Credits

Created to solve the persistent Flameshot scaling issues on Ubuntu with modern multi-DPI monitor setups.

Based on the proven GNOME Screenshot + Drawing combination recommended by the Ubuntu community.
