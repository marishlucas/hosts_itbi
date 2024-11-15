#!/bin/bash

verify_ip() {
	local host=$1
	local ip=$2
	local dns_server=$3

	ns_ip=$(nslookup "$host" "$dns_server" | awk '/^Address:/ {print $2}' | tail -1)
	if [[ $ip != "$ns_ip" ]]; then
		echo "Bogus IP for $host in /etc/hosts!"
	fi
}

while read -r line; do
	ip=$(echo "$line" | awk '{print $1}')
	host=$(echo "$line" | awk '{print $2}')
	if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] && [[ -n $host ]]; then
		verify_ip "$host" "$ip" "8.8.8.8" # Folosim serverul DNS Google
	fi
done
