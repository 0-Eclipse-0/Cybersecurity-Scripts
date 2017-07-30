#!/bin/bash
pkill -9 -f nping
rm gateway.txt & rm arp_list.txt
echo "[SpoofDaARP] All ARP Spoof processes killed!"
