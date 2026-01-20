# Ubuntu Tools Collection

This directory contains various utility tools and scripts to enhance your Ubuntu experience.

## Available Tools

### 📸 [Screenshot & Annotate](./screenshot/)

A reliable screenshot and annotation solution that solves Flameshot's HiDPI/multi-monitor scaling issues.

**Perfect for:**
- 2K/4K monitors
- Multi-monitor setups
- Mixed DPI configurations
- Quick screenshot → annotate → paste workflows

**Quick Start:**
```bash
cd screenshot
./install.sh
```

[Read full documentation →](./screenshot/README.md)

## Tool Organization

Each tool has its own subdirectory containing:
- `README.md` - Detailed documentation
- `install.sh` - Automated installation script
- Main executable script(s)
- Any configuration files

## Adding New Tools

To add a new tool to this collection:

1. Create a new subdirectory: `tools/your-tool-name/`
2. Add your scripts and files
3. Create a `README.md` with:
   - Problem description
   - Installation instructions
   - Usage examples
   - Troubleshooting guide
4. Create an `install.sh` if applicable
5. Update this main `tools/README.md` to list your tool

## Contributing

If you create a useful tool for Ubuntu setup/productivity:
1. Follow the structure above
2. Test thoroughly on Ubuntu 18.04+
3. Document all dependencies
4. Submit a pull request

## License

All tools in this directory follow the ubuntu_init repository license unless otherwise specified.
