#!/bin/bash

echo "Starting Benchmark..."


#Usage:
#./run-boot-test.sh <iterations> <memory> <output_file>
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "Usage: $0 <iterations> <memory> <output_file>\n"
  echo "Example: $0 100 1Gi  results.csv"
  exit 1
fi



for i in $(seq 1 $ITERATIONS); do
  echo "Running with memory: $MEMORY" | tee -a temp.txt
  { kraft run --memory $MEMORY --rm; } 2>&1 | tee -a temp.txt
  echo -e "\n" | tee -a temp.txt
done

