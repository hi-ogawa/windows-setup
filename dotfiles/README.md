# Dotfiles

Configuration files for Windows development environment.

## Contents

- `setup.sh` - Dotfiles manager script (diff/apply/save)
- `.bash_profile` - Bash login shell config
- `.bashrc` - Bash configuration
- `.gitconfig` - [Git configuration](https://git-scm.com/docs/git-config) (aliases, LF line endings, defaults)
- `.gitignore_global` - [Global gitignore](https://git-scm.com/docs/gitignore) patterns (OS files, editor files, etc.)
- `.wezterm.lua` - [WezTerm](https://wezfurlong.org/wezterm/config/files.html) terminal configuration
- `vscode/` - [VSCode](https://code.visualstudio.com/docs/getstarted/settings) config
- `claude/` - [Claude Code](https://code.claude.com/docs/en/settings) config

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

## Note: Line endings after first apply

On fresh Windows setup, Git for Windows defaults to `autocrlf=true`. After `apply` sets `autocrlf=false`, git sees all repo files as modified (LF in storage vs CRLF in working dir). Fix with:

```bash
git checkout .        # Restore repo files to LF
./setup.sh apply      # Re-apply LF files to system
```

## Maintenance

Update repo after config changes:

```bash
./setup.sh save
```

## TODO

- try chezmoi? https://github.com/twpayne/chezmoi
- consolidate with linux machine config? https://github.com/hi-ogawa/config
