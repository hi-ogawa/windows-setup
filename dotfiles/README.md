# Dotfiles

Configuration files for Windows development environment.

## Contents

- `setup.sh` - Dotfiles manager script (diff/apply/save)
- `.bash_profile` - Bash login shell config (sources `.bashrc`)
- `.bashrc` - Bash configuration (yazi shell wrapper)
- `.gitconfig` - Git configuration (aliases, LF line endings, defaults)
- `.gitignore_global` - Global gitignore patterns (OS files, editor files, etc.)
- `.wezterm.lua` - WezTerm terminal configuration
- `vscode/` - VSCode config
- `claude/` - Claude Code config

## Setup

```bash
# Check what would change
./setup.sh diff

# Apply dotfiles to system
./setup.sh apply

# Reload shell
source ~/.bashrc
```

Verify:

```bash
git config --list --show-origin # Should show your aliases
type y # Should show yazi wrapper function
```

## Maintenance

Update repo after config changes:

```bash
./setup.sh save
```

## TODO

- try chezmoi? https://github.com/twpayne/chezmoi
- consolidate with linux machine config? https://github.com/hi-ogawa/config
