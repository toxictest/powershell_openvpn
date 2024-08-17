# powershell_openvpn
Firstly download Easy-rsa key from the github and sent the desired path to the same location of script and the Easy rsa key

https://github.com/OpenVPN/easy-rsa.git

# powershell

first run 
```
win + R Powershell  ctrl+enter
```
```
mv /path/to/step.ps1 /openvpn/easy-rsa
```
now run 
```
./power.ps1
```
You got a shell and check pwd

```
./step.ps1
```
exit shell

```
./power2.ps1
```


Now run the script 
```
./powershell_ovpn.ps1
```
when the setup client.ovpn we require the some files where we get 

now run the file 
```
./powershell_vpnfile.ps1
```

after that we go on the host machine that is the linux machine

after install the openvpn setup on the linux 

run the file

```
sudo openvpn client.ovpn
```
now you are the connected on the network 

after the we connect the GUI of window we use RDP 

use tool remmina
```bash
remmina -c rdp://<windows-vpn-ip>
```
```bash
rdesktop <windows-vpn-ip>
```
