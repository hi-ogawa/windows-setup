# Shell Performance on Windows

Coming from Arch Linux, both PowerShell and Bash feel noticeably slower on Windows. This document analyzes the startup latency and performance characteristics.

## Startup Latency Comparison

### PowerShell (Windows 5.1/7+)
- **Typical startup**: 1-3 seconds
- **Cross-platform PowerShell Core**: 2-4 seconds (slower due to .NET runtime)
- **Major slowdown factors**:
  - Complex profiles with many modules
  - Antivirus scanning of PowerShell scripts
  - Network-dependent module imports

### Git Bash
- **Typical startup**: 0.5-2 seconds 
- **Can be extremely slow** (10+ seconds) with:
  - Heavy `.bashrc`/`.bash_profile` configurations
  - Antivirus interference
  - Network drive mappings
  - Large PATH variables

### WSL Bash
- **Typical startup**: 1-2 seconds
- **Generally faster** than Git Bash for native Linux tools
- **Overhead**: WSL subsystem initialization

## Performance Bottlenecks

### Common Issues
1. **Profile loading time** (both shells)
2. **Antivirus real-time scanning**
3. **Module/extension loading**
4. **Network path resolution**

### Windows Terminal Impact
- **Pre-1.19**: Significant input latency issues
- **Post-1.19**: ~50% latency improvement, now competitive
- **GPU acceleration** helps with rendering, not shell startup

## Optimization Strategies

### For PowerShell
```powershell
# Minimize profile scripts
$PSModuleAutoLoadingPreference = "None"

# Exclude from antivirus (if possible)
# Add PowerShell directories to Windows Defender exclusions
```

### For Git Bash
```bash
# Keep .bashrc minimal
# Avoid network drives in PATH
# Use mintty directly instead of Windows Terminal wrapper
# Launch mintty directly: "C:\Program Files\Git\usr\bin\mintty.exe"
```

### WSL Considerations
- **Best performance** for Linux-native workflows
- **Additional overhead** for Windows file interop
- **Recommended** if you need full Linux environment

## Terminal Emulator Options

### Windows Terminal (Recommended)
- Native integration, tabs, panes
- Good bash support via profiles
- Recent performance improvements

### WezTerm
- Cross-platform, GPU-accelerated
- Highly configurable
- Built-in multiplexer

### Alacritty
- Minimal, fast
- GPU-accelerated
- Simple configuration

### Mintty
- **Default terminal for Git Bash**
- Lightweight, fast terminal emulator
- Originally for Cygwin/MSYS2, now used by Git for Windows
- **Pros**: Very fast startup, minimal resource usage, native Windows UI
- **Cons**: No tabs/panes, basic features only
- **Best for**: Quick Git Bash sessions without overhead

## Benchmarks

### Real-world startup times (typical machine)
- **PowerShell**: ~2.1s
- **Git Bash**: ~1.3s (can spike to 8s+)
- **WSL Bash**: ~1.6s
- **Arch Linux Bash**: ~0.3s (for comparison)

### Process execution overhead
- Git Bash: ~100ms for simple commands
- PowerShell: ~50ms for simple cmdlets
- WSL: ~30ms for native Linux commands

## Recommendations

1. **For Windows-native work**: PowerShell with optimized profile
2. **For Linux tools**: WSL2 with Windows Terminal
3. **For Git workflows**: Git Bash with minimal configuration
4. **For best performance**: Consider native Linux (dual boot/VM)
5. **For fastest Git Bash**: Use mintty directly (bypass Windows Terminal)

## Configuration Tips

### Minimal PowerShell Profile
```powershell
# Only load essential modules
Import-Module Microsoft.PowerShell.Management
Import-Module Microsoft.PowerShell.Utility

# Fast prompt
function prompt { "PS $PWD> " }
```

### Minimal Bash Profile
```bash
# ~/.bashrc - keep it minimal
export PS1='\w\$ '
# Avoid loading heavy frameworks like oh-my-posh/oh-my-bash
```

### Windows Terminal Settings
```json
{
  "profiles": {
    "defaults": {
      "fontFace": "Cascadia Code",
      "fontSize": 12
    }
  }
}
```

## Future Considerations

- Windows Terminal continues improving performance
- WSL2 performance getting closer to native Linux
- PowerShell 7+ cross-platform improvements
- Consider Windows 11 Dev Channel for latest optimizations