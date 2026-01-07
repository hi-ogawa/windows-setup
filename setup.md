# Windows Setup

The same content is found in https://github.com/hi-ogawa/windows-setup

## Installation

- USB installer
  - Download Windows 11 ISO from Microsoft
  - Create bootable USB with Ventoy from Linux
- Boot and install
  - Boot from USB stick with Ventoy + Windows ISO
  - Launch installer via Ventoy (Normal mode)
- Disk setup
  - Delete all partitions on target disk, leave as unallocated space
  - Let Windows auto-create partitions
  - *Note: Laptops shipped with Windows have OEM license that activates automatically*
- Local account creation
  - At sign-in screen: `Shift + F10`
  - Run: `start ms-cxh:localonly`
  - Create local user in the dialog that appears
  - *Skip optional services and personalization prompts during setup*

## Post-install

- Verify activation
  - Settings → System → Activation (should show "Activated with a digital license")
- Desktop settings
  - Keyboard repeat
    - Settings → Accessibility → Keyboard
    - Adjust key repeat delay and rate
  - Mouse/Touchpad speed
    - Settings → Bluetooth & devices → Mouse → Mouse pointer speed
    - Settings → Bluetooth & devices → Touchpad → Touchpad speed, Taps
    - Settings → Bluetooth & devices → Touchpad → Three-finger gestures → Taps: Middle mouse button
  - File Explorer
    - File Explorer → View → Show → File name extensions
    - Disable folder tracking: File Explorer → ... (three dots) → Options → Privacy → Uncheck "Show frequently used folders"
  - Taskbar
    - Right-click taskbar → Taskbar settings
    - Hide unnecessary UI through Taskbar behaviors, items, etc
      - Show taskbar on all displays: OFF
  - PowerToys
    - Swap Ctrl/Cap: Keyboard Manager → Remap keys: Caps Lock ↔ Left Ctrl
    - Disable "find my mouse" (triggered by Ctrl double tap)
- Install Chrome
  - Install, sign in, sync bookmarks and extensions
- Setup basic development tools (see [notes/dev.md](./notes/dev.md) for background)
  - install git (with bash), vscode via winget
  - install scoop https://scoop.sh/
  - follow [dotfiles/README.md](./dotfiles/README.md)

Tool installtion via winget:

```powershell
winget install -e --id Microsoft.PowerToys
winget install -e --id Google.Chrome
winget install -e --id Git.Git
winget install -e --id Microsoft.VisualStudioCode
scoop install yazi gh
```

## Desktop tips

- Search and launch apps: Windows key, then type app name
- Shell
  - PowerShell (no need for Command Prompt)
  - Bash (from Git.Git)
- Window management
  - Alt + Tab: cycle through all windows
  - Alt + ` (backtick): cycle through windows of same app
  - Win + Shift + Left/Right Arrow: move window between monitors
- File Explorer
  - Ctrl + Shift + N: create new folder
