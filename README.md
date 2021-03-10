# opnsense-vpn-dns

**Problem:** opnsense does not honor "dhcp-option DNS" and therefore does not change the System DNS Servers to the one of your VPN Provider by default. If this is wrong and you know how to do this with just the WebGUI please tell me 😄

**Solution:** 

## Basic usage

Adds the IP4 address of the DNS Servers that are pushed by the OpenVPN Server (VPN Provider) to the client (opnsense).  

This is part of the **PUSH** line found in /var/log/openvpn.log

```
dhcp-option DNS 95.211.146.77,dhcp-option DNS 37.48.94.55
```

The script will make the local DNS Resolver **unbound** use those servers as new forwarding servers for DNS lookups.  

To see what Nameserver a currently in use run this script with **show** argument 

```bash
root@opnsense:~ # ./vpn-dns.sh show
The following name servers are used for lookup of opnsense.org.
forwarding request:
Delegation with 0 names, of which 0 can be examined to query further addresses.
It provides 2 IP addresses.
37.48.94.55             rto 60 msec, ttl 304, ping 36 var 6 rtt 60, tA 0, tAAAA 0, tother 0, EDNS 0 probed.
95.211.146.77           rto 51 msec, ttl 304, ping 35 var 4 rtt 51, tA 0, tAAAA 0, tother 0, EDNS 0 probed.
```
or   

```bash
unbound-control -c /var/unbound/unbound.conf lookup opnsense.org
```

Restores the DNS Servers from **/etc/resolv.conf** with   

```bash
./vpn-dns.sh del
```

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

Just an example. 

```bash
./vpn-dns.sh put 88.198.92.222 1.1.1.1 9.9.9.9
```

This would just execute

```bash
unbound-control -c /var/unbound/unbound.conf forward_add +i . 88.198.92.222 1.1.1.1 9.9.9.9
```
