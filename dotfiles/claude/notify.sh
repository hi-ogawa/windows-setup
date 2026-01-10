#!/bin/bash
# Claude Code notification hook script
# Reads JSON from stdin and shows Windows toast notification

input=$(cat)

# Use PowerShell to parse JSON and show notification
powershell.exe -c "
  \$json = '$input' | ConvertFrom-Json
  \$message = \$json.message
  if (-not \$message) { \$message = 'Notification' }
  New-BurntToastNotification -Text 'Claude Code', \$message
"
