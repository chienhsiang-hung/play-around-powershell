$WShell = New-Object -ComObject WScript.Shell

while ($true) {
    $WShell.SendKeys("{F13}")
    Start-Sleep -Seconds 60
}
