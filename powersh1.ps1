# we create directory
mkdir 'C:\Program Files\OpenVPN\
# Get the current working directory
cd 'C:\Program Files\OpenVPN\easy-rsa'
$currentDir = Get-Location

# Set EasyRSAPath to the current directory
$EasyRSAPath = $currentDir.Path

# Output the EasyRSAPath
Write-Host "EasyRSAPath: $EasyRSAPath"

# Start the EasyRSA Shell
Start-Process -NoNewWindow -Wait -FilePath "cmd.exe" -ArgumentList "/c `"$EasyRSAPath\EasyRSA-Start.bat`""

# Define the path where certificates will be moved
$ConfigPath = "$EasyRSAPath\config"
