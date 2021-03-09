# opnsense-vpn-dns
Add and Remove Pushed DNS Servers via dhcp-options

opnsense does not honor the dhcp-option field and does not change the System DNS Servers that your   
VPN Provider pushes.   

This script adds the DNS Server from your VPN Provider and restores the DNS Servers that are specified   
in System -> Settings -> General -> DNS servers

## Installation

SSH Login to your opnsense and fetch this script

```bash
fetch https://raw.githubusercontent.com/ddowse/opnsense-vpn-dns/main/vpn-dns.sh 
chmod u+x vpn-dns.sh
```

Open the VPN Settings in opnsense WebGUI and go to the client. Scroll down to the advanced configuration   
field and add the lines

```
up "/root/vpn-dns.sh add"
down "/root/vpn-dns.sh del"
```

If you choose to save the file somewhere else then don't forget to modify the path to the script.   

## Deletion/Deinstall/Disable

Disable: Add # in beginning of the lines   
Deinstall: Delete the lines and delete the file from opnsense
