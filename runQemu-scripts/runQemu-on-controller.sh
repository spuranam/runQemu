#!/bin/bash
numsmp="4"
memsize="8G"
imgloc=${HOME}/"runQemu"/"runQemu-imgs"
imgfile="Controller-raw.img"
exeloc="/usr/local/bin"
CPU_LIST="0-7"
TASKSET="taskset -c ${CPU_LIST}"
#
sudo ${TASKSET} ${exeloc}/qemu-system-x86_64 -enable-kvm -cpu host -smp ${numsmp} \
     -m ${memsize} -L pc-bios -drive file=${imgloc}/${imgfile},format=raw \
     -boot c -vnc :96 \
     -netdev type=tap,script=${HOME}/runQemu/runQemu-etc/ovs-manage-ifup,downscript=${HOME}/runQemu/runQemu-etc/ovs-manage-ifdown,id=hostnet10 \
     -device virtio-net-pci,romfile=,netdev=hostnet10,mac=00:55:99:25:20:17 \
     -qmp tcp:localhost:9444,server,nowait \
     -monitor tcp::9666,server,nowait \
     -localtime 
