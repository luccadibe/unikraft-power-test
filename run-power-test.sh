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
  echo "Running with memory: $MEMORY" | tee -a temp.csv
  { kraft run --memory $MEMORY; } 2>&1 | tee -a temp.csv
  echo -e "\n" | tee -a temp.csv
done


grep -E '^(Run Time:|Running with memory|^$)' "temp.csv" > "$OUTPUT_FILE"