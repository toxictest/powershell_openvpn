# PowerShell Script to Copy VPN Files to User's Desktop

# Define the source directory where the files are located
$sourceDirectory = "C:\OpenVPN\easy-rsa\pki"

# Define the destination directory (User's Desktop)
$desktopPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), "VPN_Files")

# Create the destination directory if it does not exist
if (-not (Test-Path -Path $desktopPath)) {
    New-Item -Path $desktopPath -ItemType Directory | Out-Null
}

# Define the list of files to copy
$filesToCopy = @(
    "ca.crt",
    "issued\client1.crt",
    "private\client1.key",
    "ta.key"
)

# Copy each file from source to destination
foreach ($file in $filesToCopy) {
    $sourceFile = [System.IO.Path]::Combine($sourceDirectory, $file)
    $destinationFile = [System.IO.Path]::Combine($desktopPath, [System.IO.Path]::GetFileName($file))
    
    if (Test-Path -Path $sourceFile) {
        Copy-Item -Path $sourceFile -Destination $destinationFile -Force
        Write-Output "Copied: $sourceFile to $destinationFile"
    } else {
        Write-Output "File not found: $sourceFile"
    }
}

Write-Output "All specified files have been copied to $desktopPath."
