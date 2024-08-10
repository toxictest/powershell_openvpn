# powershell_openvpn
Firstly download Easy-rsa key from the github and sent the desired path to the same location of script and the Easy rsa key

https://github.com/OpenVPN/easy-rsa.git

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
