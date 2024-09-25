Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# start creating UI
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Keep Screen Active'
$form.Size = New-Object System.Drawing.Size(300, 150)
$form.StartPosition = 'CenterScreen'

# add OK button
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(112.5, 70)
$okButton.Size = New-Object System.Drawing.Size(75, 23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

# add description label
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10, 20)
$label.Size = New-Object System.Drawing.Size(280, 40)
$label.Text = 'This will Keep Screen Active by pressing `F13` every 1 min until you click the OK below .'
$form.Controls.Add($label)

# initialize the formClosed flag
$formClosed = $false
# handle the form closed event
$form.Add_FormClosed({
    $script:formClosed = $true
})

# stay on top
$form.Topmost = $true
# show
$result = $form.ShowDialog()


# creating object to press keyboard
$WShell = New-Object -ComObject WScript.Shell
# start looping
while ($result -ne [System.Windows.Forms.DialogResult]::OK -and -not $formClosed) {
    $WShell.SendKeys("{F13}")
    Start-Sleep -Seconds 60
}
Write-Output 'Keep Screen Active ended!'
