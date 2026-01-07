# Development Environment - WSL Alternative

## Why WSL?

Coming from Arch Linux, native Windows PowerShell development introduces friction:
- Different PATH behavior and environment variables
- CRLF vs LF line ending issues
- Windows-specific tooling (winget vs package managers like pacman/apt)
- Shell scripting differences (PowerShell vs bash/zsh)

**WSL (Windows Subsystem for Linux)** provides a real Linux environment on Windows:
- Full Linux kernel (WSL2)
- Native Linux tooling (apt/pacman, bash, ssh, git)
- Familiar workflow from Arch Linux
- Better compatibility with Linux-focused dev tools
- Can still access Windows filesystem (`/mnt/c/...`)

## Filesystem

WSL has **two separate filesystems** that can access each other:

### WSL → Windows
Windows drives are auto-mounted in WSL:
```bash
/mnt/c/Users/hiroshi/...  # C:\ drive
/mnt/d/...                 # D:\ drive (if exists)
```

From WSL, you can access any Windows file:
```bash
cd /mnt/c/Users/hiroshi/Documents
ls /mnt/c/Users/hiroshi/code/temporary
```

### Windows → WSL
WSL filesystem is accessible from Windows via network path:
```
\\wsl$\Ubuntu\home\username\...
\\wsl.localhost\Ubuntu\home\username\...
```

From File Explorer: type `\\wsl$` in address bar to see all installed distros.

From PowerShell:
```powershell
cd \\wsl$\Ubuntu\home\username\code
```

### Where is WSL filesystem stored?
WSL uses a virtual disk file (ext4 format) stored somewhere in Windows:
```
C:\Users\hiroshi\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu...\LocalState\ext4.vhdx
```

**Don't access this file directly** - always use `\\wsl$\` path or access from within WSL.

### Performance considerations
- **Fast**: Files in native filesystem (Windows files on C:\, Linux files in WSL ext4)
- **Slow**: Cross-boundary operations (Linux tools on /mnt/c/ files, or Windows tools on \\wsl$\ files)

**Best practice:**
- Store Linux projects in WSL filesystem: `~/code/myproject`
- Access via Windows: `\\wsl$\Ubuntu\home\username\code\myproject`
- Avoid storing projects on `/mnt/c/` if you're using Linux tools heavily

### Recommended workflow
```bash
# In WSL - create workspace in Linux filesystem
mkdir -p ~/code
cd ~/code

# Clone repos here (fast git operations)
git clone git@github.com:user/repo.git

# Open in VSCode from WSL
code .
```

VSCode with Remote-WSL extension handles the bridging automatically.

## Installation

```powershell
wsl --install
```

- Installs WSL2 with Ubuntu by default
- Requires reboot
- First launch creates Linux user account

**Alternative distros:**
```powershell
wsl --list --online          # List available distros
wsl --install -d Debian      # Example: install Debian instead
```

## VSCode + WSL Integration

VSCode Remote - WSL extension:
- Open WSCode in Windows
- Install "Remote - WSL" extension
- `Ctrl+Shift+P` → "WSL: New Window" opens VSCode connected to WSL
- VSCode terminal is now Linux bash (not PowerShell)
- File operations happen in Linux filesystem
- Extensions run in WSL context

## Workflow

1. Windows-side: VSCode, browser, GUI apps
2. WSL-side: Git, Python, Node.js, development tools, file system
3. VSCode bridges both seamlessly via Remote extension

## Trade-offs

**Pros:**
- Familiar Linux environment
- Better shell scripting, package management
- No CRLF/PATH/credential quirks
- Native Linux tools work as expected

**Cons:**
- Cross-boundary file I/O is slower (Linux tools reading `/mnt/c/` files)
- Additional layer of complexity
- Path handling: Need to use `\\wsl$\Ubuntu\...` for Windows apps to access WSL files
  - Example: Script generates file in WSL → upload via browser → must navigate to `\\wsl$\Ubuntu\home\username\output\file.pdf`
  - Most Windows apps handle `\\wsl$\` paths fine, but some may have issues with UNC network paths
  - Can't drag-drop directly from WSL terminal to Windows GUI apps

**Practical workaround for file sharing:**
- Pin WSL home in File Explorer: `\\wsl$\Ubuntu\home\username` → Quick Access
- Or: Generate files to `/mnt/c/Users/hiroshi/Downloads` for easy Windows access (slower, but trivial to find)

## Follow-up

- [ ] Install WSL2
- [ ] Choose distro (Ubuntu default, or Arch/Debian/etc.)
- [ ] Install VSCode Remote - WSL extension
- [ ] Set up dev tools in WSL (git, python, node, claude)
- [ ] Test Claude Code in WSL environment
- [ ] Decide: Pure WSL workflow vs hybrid Windows/WSL
- [ ] Document WSL-specific quirks and tips
