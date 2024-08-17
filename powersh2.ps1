# Move generated files to the config directory
$files = @("pki\ca.crt", "pki\issued\server.crt", "pki\private\server.key", "pki\dh.pem", "pki\crl.pem")
foreach ($file in $files) {
    $filePath = "$EasyRSAPath\$file"
    if (Test-Path -Path $filePath) {
        Move-Item -Path $filePath -Destination $ConfigPath
    } else {
        Write-Host "File not found: $filePath"
    }
}

# Create OpenVPN server configuration file
$serverConfig = @"
port 1194
proto udp
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh.pem
crl-verify crl.pem
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
keepalive 10 120
cipher AES-256-CBC
user nobody
group nogroup
persist-key
persist-tun
status openvpn-status.log
verb 3
"@
$serverConfigPath = "$ConfigPath\server.ovpn"
$serverConfig | Out-File -FilePath $serverConfigPath -Encoding ascii

# Enable IP forwarding
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "IPEnableRouter" -Value 1

# Instructions
Write-Host "OpenVPN server setup is complete."
Write-Host "You need to start the OpenVPN service and use the server.ovpn configuration file."
Write-Host "Ensure that your server's public IP address is accessible from the client."
