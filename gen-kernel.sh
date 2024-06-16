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



# Build the dbgen tool
SCALE_FACTOR=$DBGEN_SIZE make


cd ~

cd unikraft-power-test/rootfs


mv ~/TPCH-sqlite/TPC-H.db .

rm -r ~/TPCH-sqlite

cd ..


kraft build --target qemu/x86_64
