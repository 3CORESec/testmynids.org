#!/bin/bash

# Check if a file name is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <tcpdump_output_file>"
    exit 1
fi

file=$1

# Check if the file exists
if [ ! -f "$file" ]; then
    echo "File not found: $file"
    exit 2
fi

echo "Processing file: $file"

# Initialize counters and arrays
total_packets=0
declare -A ip_pairs
declare -A ip_pairs_count
declare -A protocol_count

# Regular expression to match valid IP addresses
ip_regex='^([0-9]{1,3}\.){3}[0-9]{1,3}$'

# Process the file
while read -r line; do
    # Extract protocol, source, and destination IPs
    protocol=$(echo "$line" | awk '{print $6}' | cut -d: -f1)
    src_ip=$(echo "$line" | awk '{print $3}' | cut -d. -f1-4)
    dst_ip=$(echo "$line" | awk '{print $5}' | cut -d. -f1-4 | sed 's/:$//')

    # Clean up the protocol name by removing trailing commas and non-alphanumeric characters
    protocol=$(echo "$protocol" | sed 's/[^a-zA-Z0-9]*$//')

    # Check if both source and destination IPs are valid
    if [[ $src_ip =~ $ip_regex ]] && [[ $dst_ip =~ $ip_regex ]]; then
        # Increment the total packet count for valid IP pairs
        ((total_packets++))

        # Construct a unique key for source-destination IP pair
        ip_pair="${src_ip}->${dst_ip}"

        # Count occurrences of each unique IP pair
        if ! [[ ${ip_pairs_count[$ip_pair]} ]]; then
            ip_pairs_count[$ip_pair]=1
        else
            ((ip_pairs_count[$ip_pair]++))
        fi

        # Mark this pair as seen
        ip_pairs["$ip_pair"]=1

        # Count the occurrences of each protocol
        if [[ -n "$protocol" ]]; then
            if ! [[ ${protocol_count[$protocol]} ]]; then
                protocol_count[$protocol]=1
            else
                ((protocol_count[$protocol]++))
            fi
        fi
    fi
done < "$file"

# Display unique IP pairs with packet counts
echo "Unique IP Pairs with Packet Counts:"
for pair in "${!ip_pairs[@]}"; do
    echo "$pair: ${ip_pairs_count[$pair]}"
done

# Display the statistics
echo "Total packets (with valid IP pairs): $total_packets"
echo "Protocol statistics:"
for proto in "${!protocol_count[@]}"; do
    echo "$proto: ${protocol_count[$proto]}"
done

