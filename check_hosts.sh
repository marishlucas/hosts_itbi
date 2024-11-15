#!/bin/bash

while read -r line; do
	ip=$(echo "$line" | awk '{print $1}')
	host=$(echo "$line" | awk '{print $2}')
	if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] && [[ -n $host ]]; then
		ns_ip=$(nslookup "$host" | awk '/^Address:/ {print $2}' | tail -1)
		if [[ $ip != "$ns_ip" ]]; then
			echo "Bogus IP for $host in /etc/hosts!"
		fi
	fi
done 

