#!/bin/bash

echo "Starting Benchmark..."

#Usage:
#./run-power-test.sh <iterations> <refresh_func> <output_file>
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
  echo "Usage: $0 <iterations> <memory> <refresh_func> <output_file>\n"
  echo "Example: $0 10 2Gi false results.csv"
  exit 1
fi


ITERATIONS=$1
MEMORY=$2
REFRESH_FUNC=$3
OUTPUT_FILE=$4
#Clear the temp output file
> temp.csv
# Clear the output file
> $OUTPUT_FILE

# Run kraft run --memory $MEMORY $ITERATIONS times

for i in $(seq 1 $ITERATIONS); do
  echo "Running with memory: $MEMORY" | tee -a temp.txt
  { kraft run --memory $MEMORY; } 2>&1 | tee -a temp.txt
  echo -e "\n" | tee -a temp.txt
done


grep -E '^(Run Time:|Running with memory|^$)' "temp.txt" > "temp2.txt"

rm "temp.txt"

iteration=0
query_count=24

echo "iteration,query,time" > "$OUTPUT_FILE"

while IFS= read -r line; do
    # Check for a new iteration start
    if [[ $line == "Running with memory:"* ]]; then
        iteration=$((iteration + 1))
        query=1
    elif [[ $line == "Run Time: real"* ]]; then
        # Extract the time value
        time_value=$(echo "$line" | awk '{print $4}')
        
        # Check if we are at the 15th, 16th, or 17th query
        if [[ $query -eq 15 ]]; then
            time_15=$time_value
        elif [[ $query -eq 16 ]]; then
            time_16=$time_value
        elif [[ $query -eq 17 ]]; then
            # Sum the times for the 15th, 16th, and 17th queries
            time_17=$time_value
            total_time=$(echo "$time_15 + $time_16 + $time_17" | bc)
            # Write the combined result to the output file
            echo "$iteration,15,$total_time" >> "$OUTPUT_FILE"
        else
            # Write the result to the output file
            echo "$iteration,$query,$time_value" >> "$OUTPUT_FILE"
        fi
        query=$((query + 1))
    fi
done < "temp2.txt"

rm "temp2.txt"

echo "Benchmark complete. Results written to $OUTPUT_FILE"

