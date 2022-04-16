# PowerShell-Move-Windows

This script moves all your visible application windows to another monitor

The main script is `Move-Windows.ps1` -- you can specify a monitor index (starting from 1) to move all windows to as the first argument. If empty, it will default to the right-most screen

## Example

```powershell
# Move all windows to right-most screen
PS> .\Move-Windows.ps1

# Move all windows to the first/left-most monitor
PS> .\Move-Windows.ps1 1

# Move all windows to the third monitor
PS> .\Move-Windows.ps1 3

```