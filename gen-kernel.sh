#!/bin/bash


if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <dbgen_size> <test: power,boot,throughput>"
  exit 1
fi

DBGEN_SIZE=$1
TEST=$2
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


if [ $TEST = "power" ]; then
  cp ../queries/* .
  cat <<EOF > Kraftile
  spec: v0.6

name: sqlite

rootfs: ./rootfs

cmd:
  [
    "/TPC-H.db",
    ".timer 'on'",
    ".read 'query1.sql'",
    ".read 'query2.sql'",
    ".read 'query3.sql'",
    ".read 'query4.sql'",
    ".read 'query5.sql'",
    ".read 'query6.sql'",
    ".read 'query7.sql'",
    ".read 'query8.sql'",
    ".read 'query9.sql'",
    ".read 'query10.sql'",
    ".read 'query11.sql'",
    ".read 'query12.sql'",
    ".read 'query13.sql'",
    ".read 'query14.sql'",
    ".read 'query15.sql'",
    ".read 'query16.sql'",
    ".read 'query17.sql'",
    ".read 'query18.sql'",
    ".read 'query19.sql'",
    ".read 'query20.sql'",
    ".read 'query21.sql'",
    ".read 'query22.sql'",
  ]

unikraft:
  version: staging
  kconfig:
    CONFIG_LIBRAMFS: "y"
    CONFIG_LIBUKBUS: "y"
    CONFIG_LIBUKCPIO: "y"
    CONFIG_LIBUKDEBUG_ANSI_COLOR: "y"
    CONFIG_LIBUKLIBPARAM: "y"
    CONFIG_LIBPOSIX_MMAP: "y"
    CONFIG_LIBPOSIX_SYSINFO: "y"
    CONFIG_LIBVFSCORE_AUTOMOUNT_CI_EINITRD: "y"
    CONFIG_LIBVFSCORE_AUTOMOUNT_CI: "y"
    CONFIG_LIBVFSCORE_AUTOMOUNT_FB: "y"
    CONFIG_LIBVFSCORE_AUTOMOUNT_FB0_DEV: "embedded"
    CONFIG_LIBVFSCORE_AUTOMOUNT_FB0_DRIVER: "extract"
    CONFIG_LIBVFSCORE_AUTOMOUNT_FB0_MP: "/"
    CONFIG_LIBVFSCORE_AUTOMOUNT_UP: "y"
    CONFIG_LIBVFSCORE_AUTOMOUNT: "y"

targets:
  - qemu/x86_64
  - qemu/arm64
  - fc/x86_64
  - fc/arm64

libraries:
  musl: stable
  sqlite:
    version: stable
    kconfig:
      CONFIG_LIBSQLITE_MAIN_FUNCTION: "y"
EOF


elif [ $TEST = "boot" ]; then
  cat <<EOF > Kraftile
spec: v0.6

name: sqlite

rootfs: ./rootfs

cmd:
  ["./timer on"]

unikraft:
  version: staging
  kconfig:
    CONFIG_LIBRAMFS: "y"
    CONFIG_LIBUKBUS: "y"
    CONFIG_LIBUKCPIO: "y"
    CONFIG_LIBUKDEBUG_ANSI_COLOR: "y"
    CONFIG_LIBUKLIBPARAM: "y"
    CONFIG_LIBPOSIX_MMAP: "y"
    CONFIG_LIBPOSIX_SYSINFO: "y"
    CONFIG_LIBVFSCORE_AUTOMOUNT_CI_EINITRD: "y"
    CONFIG_LIBVFSCORE_AUTOMOUNT_CI: "y"
    CONFIG_LIBVFSCORE_AUTOMOUNT_FB: "y"
    CONFIG_LIBVFSCORE_AUTOMOUNT_FB0_DEV: "embedded"
    CONFIG_LIBVFSCORE_AUTOMOUNT_FB0_DRIVER: "extract"
    CONFIG_LIBVFSCORE_AUTOMOUNT_FB0_MP: "/"
    CONFIG_LIBVFSCORE_AUTOMOUNT_UP: "y"
    CONFIG_LIBVFSCORE_AUTOMOUNT: "y"

targets:
  - qemu/x86_64
  - qemu/arm64
  - fc/x86_64
  - fc/arm64

libraries:
  musl: stable
  sqlite:
    version: stable
    kconfig:
      CONFIG_LIBSQLITE_MAIN_FUNCTION: "y"
EOF
fi
#TODO throughput

cd ..


kraft build --target qemu/x86_64
