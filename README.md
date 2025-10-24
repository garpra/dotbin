# dotbin

> A collection of personal shell utilities, each designed to do one thing well.

Scripts are standalone and intended to live in `~/.local/bin` -- no package manager, no installer, just drop and run.

## Installation

Install a single script:

```bash
curl -fsSL https://raw.githubusercontent.com/garpra/dotbin/main/<script-name> \
  -o ~/.local/bin/<script-name> && chmod +x ~/.local/bin/<script-name>
```

Or clone the repo and symlink what you need:

```bash
git clone https://github.com/garpra/dotbin.git
ln -s ~/dotbin/<script-name> ~/.local/bin/<script-name>
```
