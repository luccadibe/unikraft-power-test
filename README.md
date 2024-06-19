# Unikraft unikernel generation

This script generates the unikraft unikernel and initrd with the TPCH database with a scale factor.

## Usage

First run `chmod +x gen-kernel.sh`

Then run `./gen-kernel.sh <Scale Factor> <Test: power, boot, throughput>`

As a result, a kernel image and a cpio file will be generated in the .unikraft folder.
