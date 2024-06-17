#!/bin/bash

sudo apt update

sudo apt install sqlite3

sudo apt install qemu-kvm virt-manager virtinst libvirt-clients bridge-utils libvirt-daemon-system -y

sudo systemctl enable --now libvirtd

sudo systemctl start libvirtd

sudo systemctl status libvirtd


sudo usermod -aG kvm $USER

sudo usermod -aG libvirt $USER


curl --proto '=https' --tlsv1.2 -sSf https://get.kraftkit.sh | sh

git clone https://github.com/luccadibe/unikraft-power-test.git

cd unikraft-power-test

chmod +x gen-kernel.sh

