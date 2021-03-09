# opnsense-vpn-dns
Add and Remove Pushed DNS Servers via dhcp-options

opnsense does not honor the dhcp-option field and does not change the System DNS Servers that your   
VPN Provider pushes.   

This script adds the DNS Server from your VPN Provider and restores the DNS Servers that are specified   
in System -> Settings -> General -> DNS servers.

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

Make sure that verbosity is at least at Level 3.

If you choose to save the file somewhere else then don't forget to modify the path to the script.   

## Deinstall/Disable

Deinstall: Delete the lines and delete the file from opnsense
Disable: Add # in beginning of the lines.  

## Change /Forwarding/ DNS Server 'on-the-fly'

Juat an example. 

```bash
./vpn-dns.sh put 88.198.92.222 1.1.1.1 9.9.9.9
```

This would just execute

```bash
unbound-control -c /var/unbound/unbound.conf forward_add +i . 88.198.92.222 1.1.1.1 9.9.9.9
```
