#!/bin/bash


if [ -z "$1" ]; then
  echo "Usage: $0 <dbgen_size>"
  exit 1
fi

DBGEN_SIZE=$1

cd ~

git clone https://github.com/lovasoa/TPCH-sqlite.git

cd TPCH-sqlite


rm -rf tpch-dbgen


git clone https://github.com/lovasoa/tpch-dbgen.git

cd tpch-dbgen

# Build the dbgen tool
make


./dbgen -s $DBGEN_SIZE

cd ~

cd unikraft-power-test/rootfs


cp ~/TPCH-sqlite/TPC-H.db .

cd ..


kraft build --target qemu/x86_64
