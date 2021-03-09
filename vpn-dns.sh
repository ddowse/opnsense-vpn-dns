#!/bin/sh
# 2021 (c) Daniel Dowse (dev@daemonbytes.net)
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# * Neither the name of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


# Add this script to your OpenVPN Client configuration like this
# up "/root/vpn-dns.sh add"
# down "root/vpn-dns.sh del"
# Adjust the path if you save the script somewhere else  

case $1 in
add) unbound-control -c /var/unbound/unbound.conf forward_add +i . `clog /var/log/openvpn.log | egrep -Eo 'dhcp-option DNS ([1-9]{1,3}\.){3}[0-9]{1,3}' | awk '{print $3}' | tail -n 2 | tr -s "\n" " "`
;;
del) unbound-control -c /var/unbound/unbound.conf forward_add +i . `tail -n 2 /etc/resolv.conf | cut -f 2 -d " " | tr -s "\n" " "` 
;;
show) unbound-control -c /var/unbound/unbound.conf lookup opnsense.org 
;;
*) echo "Help: add|del|show" 
;;
esac
