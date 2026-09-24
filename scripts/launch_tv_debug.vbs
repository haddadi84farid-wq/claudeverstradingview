' Double-click launcher: runs launch_tv_debug.ps1 (CDP on port 9222) with a visible console.
' Note: launching through shell:AppsFolder cannot pass --remote-debugging-port, so the
' PowerShell script starts the Microsoft Store package's exe directly.
Set oShell = CreateObject("WScript.Shell")
Set oFso = CreateObject("Scripting.FileSystemObject")
scriptDir = oFso.GetParentFolderName(WScript.ScriptFullName)
oShell.Run "powershell -NoProfile -ExecutionPolicy Bypass -NoExit -File """ & scriptDir & "\launch_tv_debug.ps1"" -Port 9222", 1, False
