#!/bin/bash

BASE_URL="http://3.138.244.179/"
PREFIXES=("b1" "b2" "b3" "b4" "b5" "b6" "b7" "b8" "b9" "b10" "b11" "b12" "b13" "b14" "b15")
NUM_REQUESTS=1
INTERVAL_SECONDS=0

for ((i=1; i<=$NUM_REQUESTS; i++)); do
    for prefix in "${PREFIXES[@]}"; do
        url="${BASE_URL}${prefix}/"
        echo "Sending request to: $url (Attempt $i)"
        curl -s "$url" && echo $prefix & 
    done

    # Wait for all background processes to finish
    wait

    echo -e "\nWaiting for $INTERVAL_SECONDS seconds before the next set of requests..."
    sleep $INTERVAL_SECONDS
done

echo "All requests completed."
