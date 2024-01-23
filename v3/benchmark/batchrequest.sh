#!/bin/bash

BASE_URL="http://3.137.192.74/"
PREFIXES=("b1" "b2" "b3" "b4" "b5" "b6" "b7" "b8" "b9" "b10" "b11" "b12" "b13" "b14" "b15")
NUM_REQUESTS=50

for ((i=1; i<=$NUM_REQUESTS; i++)); do
    for prefix in "${PREFIXES[@]}"; do
        url="${BASE_URL}${prefix}/courses"
        echo "Sending request to: $url (Attempt $i)"
        curl -s "$url" && echo $prefix & 
    done

    # Wait for all background processes to finish
    wait
done



echo "All requests completed."
