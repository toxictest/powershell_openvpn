# PowerShell Script to Set Up OpenVPN Server on Windows

# Variables
$openvpnConfigPath = "C:\Program Files\OpenVPN\config"
$easyRsaPath = "C:\OpenVPN\easy-rsa"
$openvpnInstallPath = "C:\Program Files\OpenVPN"
$tempPath = "C:\OpenVPN\temp"
$scriptPath = $MyInvocation.MyCommand.Path

# Function to Install OpenVPN
function Install-OpenVPN {
    Write-Output "Please download and install OpenVPN manually before running this script."
}

# Function to Set Up Easy-RSA
function Set-UpEasyRSA {
    Write-Output "Setting up Easy-RSA..."

    # Create Easy-RSA directory if not exists
    if (-not (Test-Path -Path $easyRsaPath)) {
        New-Item -Path $easyRsaPath -ItemType Directory | Out-Null
    }

    # Copy Easy-RSA files (Assuming Easy-RSA files are already downloaded and placed in the script directory)
    Copy-Item -Path ".\easy-rsa\*" -Destination $easyRsaPath -Recurse -Force

    # Initialize PKI and generate certificates
    cd $easyRsaPath
    .\easyrsa init-pki
    .\easyrsa build-ca
    .\easyrsa build-server-full server nopass
    .\easyrsa build-client-full client1 nopass
    .\easyrsa gen-dh
    openvpn --genkey --secret ta.key

    Write-Output "Easy-RSA setup complete."
}

# Function to Configure OpenVPN Server
function Configure-OpenVPNServer {
    Write-Output "Configuring OpenVPN server..."

    # Create server configuration directory if not exists
    if (-not (Test-Path -Path $openvpnConfigPath)) {
        New-Item -Path $openvpnConfigPath -ItemType Directory | Out-Null
    }

    # Server configuration
    $serverConfig = @"
port 1194
proto udp
dev tun

ca ca.crt
cert server.crt
key server.key
dh dh.pem
tls-auth ta.key 0

server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt

keepalive 10 120
cipher AES-256-CBC
auth SHA256
compress lz4

verb 3
"@

    # Save the configuration
    $serverConfigPath = "$openvpnConfigPath\server.ovpn"
    $serverConfig | Out-File -FilePath $serverConfigPath -Encoding ASCII

    Write-Output "OpenVPN server configuration complete."
}

# Function to Configure Firewall Rules
function Configure-FirewallRules {
    Write-Output "Configuring firewall rules..."

    # Allow OpenVPN traffic through Windows Firewall
    New-NetFirewallRule -DisplayName "OpenVPN UDP 1194" -Direction Inbound -Protocol UDP -LocalPort 1194 -Action Allow
    New-NetFirewallRule -DisplayName "OpenVPN TAP Adapter" -Direction Inbound -InterfaceAlias "OpenVPN TAP Adapter" -Action Allow

    Write-Output "Firewall rules configured."
}

# Function to Start OpenVPN Service
function Start-OpenVPNService {
    Write-Output "Starting OpenVPN service..."

    # Start the OpenVPN service
    Start-Service -Name "OpenVPNService"
    Write-Output "OpenVPN service started."
}

# Function to Clean Up
function Clean-Up {
    Write-Output "Cleaning up temporary files and script..."

    # Remove Easy-RSA directory if exists
    if (Test-Path -Path $easyRsaPath) {
        Remove-Item -Path $easyRsaPath -Recurse -Force
    }

    # Remove temporary files if exists
    if (Test-Path -Path $tempPath) {
        Remove-Item -Path $tempPath -Recurse -Force
    }

    # Optionally remove the script itself
    if (Test-Path -Path $scriptPath) {
        Remove-Item -Path $scriptPath -Force
    }

    Write-Output "Cleanup complete."
}

# Main Script Execution
Install-OpenVPN
Set-UpEasyRSA
Configure-OpenVPNServer
Configure-FirewallRules
Start-OpenVPNService

# Perform Cleanup
Clean-Up

Write-Output "OpenVPN server setup is complete. All traces of the setup have been removed."
