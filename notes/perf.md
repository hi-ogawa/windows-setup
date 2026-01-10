# Windows Performance Optimization

Coming from Arch Linux, Windows performance can feel sluggish. This document covers optimization strategies for development work.

## Windows Defender Impact

### Performance Issues
- **Real-time scanning**: 50-200ms overhead on file operations
- **Script scanning**: Significant PowerShell/Bash startup slowdown
- **Background processes**: Constant CPU/RAM usage
- **Network filtering**: Impact on development tools and network operations

### Measured Impact
- **Shell startup**: 2-3x slower with Defender enabled
- **File operations**: 100ms+ added latency
- **Build processes**: 10-30% slower due to scanning
- **Git operations**: Noticeable lag on large repositories

## Windows Defender Optimization

### Check Current Settings
```powershell
Get-MpPreference
```

### Recommended: Strategic Exclusions
Instead of complete disable, use targeted exclusions for development:

```powershell
# Development directories
Add-MpPreference -ExclusionPath "C:\Users\hiroshi\code"
Add-MpPreference -ExclusionPath "C:\Users\hiroshi\scoop"

# Shell and terminal tools
Add-MpPreference -ExclusionPath "C:\Program Files\Git"
Add-MpPreference -ExclusionPath "C:\Windows\System32\WindowsPowerShell"
Add-MpPreference -ExclusionPath "C:\Program Files\PowerShell"
Add-MpPreference -ExclusionPath "C:\Program Files\WindowsTerminal"
Add-MpPreference -ExclusionPath "C:\Program Files\WezTerm"

# Script file extensions
Add-MpPreference -ExclusionExtension ".ps1"
Add-MpPreference -ExclusionExtension ".sh"
Add-MpPreference -ExclusionExtension ".py"
Add-MpPreference -ExclusionExtension ".js"
Add-MpPreference -ExclusionExtension ".ts"
Add-MpPreference -ExclusionExtension ".json"
Add-MpPreference -ExclusionExtension ".yml"
Add-MpPreference -ExclusionExtension ".yaml"
```

### Alternative: Complete Disable
For maximum performance (requires admin):

```powershell
# Disable all real-time protection
Set-MpPreference -DisableRealtimeMonitoring $true
Set-MpPreference -DisableBehaviorMonitoring $true
Set-MpPreference -DisableBlockAtFirstSeen $true
Set-MpPreference -DisableIOAVProtection $true
Set-MpPreference -DisableScriptScanning $true
Set-MpPreference -DisableArchiveScanning $true
```

### Third-Party Alternative
Install lightweight antivirus and disable Defender:
- **Bitdefender Free**: Minimal performance impact
- **Malwarebytes Free**: On-demand scanning only
- **Windows Security Center**: Will show warnings but functional

## System-Level Optimizations

### Power Settings
```powershell
# Set to high performance mode
powercfg /setactive SCHEME_MIN

# Disable hibernation (saves SSD space)
powercfg /hibernate off
```

### Visual Effects
- Disable animations and transparency
- Set performance mode for visual effects
- Use classic theme elements where possible

### Services to Disable
```powershell
# Disable unnecessary services
sc config "Fax" start= disabled
sc config "PrintNotify" start= disabled
sc config "WSearch" start= disabled  # Windows Search (if not needed)
```

## Storage Optimization

### Dev Drive (Windows 11 24H2+)
```powershell
# Create Dev Drive for better performance
# Requires ReFS format and dedicated partition
```

### SSD Optimization
- Enable write caching
- Disable drive indexing for code directories
- Configure TRIM support

## Network Performance

### DNS Optimization
```powershell
# Set fast DNS servers
netsh interface ip set dns "Ethernet" static 1.1.1.1 primary
netsh interface ip add dns "Ethernet" 8.8.8.8 index=2
```

### Windows Firewall
Consider disabling for trusted networks or adding specific rules for development tools.

## Memory Management

### Virtual Memory
- Configure page file on separate drive if available
- Set custom size based on RAM + workload

### Process Priority
```powershell
# Set development tools to high priority
Get-Process "code" | ForEach-Object { $_.PriorityClass = "High" }
```

## Benchmarking

### Before/After Measurements
```powershell
# Measure shell startup time
Measure-Command { powershell -NoProfile -Command "exit" }

# Measure file operation
Measure-Command { Get-ChildItem -Recurse C:\Users\hiroshi\code }

# Measure git operations
cd C:\Users\hiroshi\code\repo
Measure-Command { git status }
```

### Expected Improvements
- **Shell startup**: 50-70% faster with exclusions
- **File operations**: 80% faster in excluded directories
- **Build times**: 20-30% improvement
- **Git operations**: 40% faster on large repos

## Monitoring

### Performance Counters
- CPU usage by MsMpEng.exe (Defender)
- Disk I/O latency
- Memory usage patterns
- Network latency

### Tools
- **Process Explorer**: Detailed process analysis
- **Resource Monitor**: Real-time performance monitoring
- **Windows Performance Analyzer**: Advanced profiling

## Security Considerations

### Risk Assessment
- **Full disable**: Zero protection, highest performance
- **Exclusions**: 90% performance, basic protection retained
- **Default**: Full protection, significant performance impact

### Best Practices
- Keep browser protection enabled
- Scan downloads manually if needed
- Use network-level protection (router/firewall)
- Regular system backups

## Recovery

### Reset Exclusions
```powershell
# Remove all exclusions
Remove-MpPreference -ExclusionPath *
Remove-MpPreference -ExclusionExtension *
```

### Restore Default Settings
```powershell
# Reset Defender to defaults
Set-MpPreference -DisableRealtimeMonitoring $false
Set-MpPreference -DisableBehaviorMonitoring $false
Set-MpPreference -DisableBlockAtFirstSeen $false
Set-MpPreference -DisableIOAVProtection $false
Set-MpPreference -DisableScriptScanning $false
```

## Recommendations

### For Development Machine
1. **Use strategic exclusions** (recommended)
2. **Disable Windows Search** if not needed
3. **Set high performance power plan**
4. **Use SSD for code directories**
5. **Consider third-party lightweight antivirus**

### For Maximum Performance
1. **Complete Defender disable**
2. **Install Bitdefender Free**
3. **Disable all unnecessary services**
4. **Use Dev Drive if available**
5. **Optimize network settings**

### Coming from Arch Linux
- Expect 2-3x slower shell startup even with optimizations
- File operations will always have some overhead
- Consider dual boot for critical performance workloads
- WSL2 provides closest experience to native Linux
