#!/usr/bin/env bash
# Update kickstart file

while getopts h:n:c:m:k:i:s:g:d:b: option
do
 case "${option}"
 in
 h) HOST_NAME=${OPTARG};;
 n) VM_NAME=${OPTARG};;
 c) VCPUS=${OPTARG};;
 m) MEM_SIZE=${OPTARG};;
 k) DISK_SIZE=${OPTARG};;
 i) IP_ADDRESS=${OPTARG};;
 s) MASK=${OPTARG};;
 g) DEFAULT_GW=${OPTARG};;
 d) DNS=${OPTARG};;
 b) BRIDGE=${OPTARG};;
 esac
done

echo "Hostname= "${HOST_NAME}
echo "KVM Domain name= "${VM_NAME}
echo "vCPUs= "${VCPUS}
echo "Memory= "${MEM_SIZE}
echo "Disk= "${DISK_SIZE}
echo "IP Address= "${IP_ADDRESS}
echo "Subnet Mask= "${MASK}
echo "Default GW= "${DEFAULT_GW}
echo "DNS= "${DNS}
echo "Network Bridge= "${BRIDGE}

sudo sed -i 's/server1/'$HOST_NAME'/g' /var/www/html/ks.cfg
sudo sed -i 's/ip_address/'$IP_ADDRESS'/g' /var/www/html/ks.cfg
sudo sed -i 's/net_mask/'$MASK'/g' /var/www/html/ks.cfg
sudo sed -i 's/default_gw/'$DEFAULT_GW'/g' /var/www/html/ks.cfg
sudo sed -i 's/dns_server/'$DNS'/g' /var/www/html/ks.cfg
 
## Pre-defined variables
OS_VARIANT="rhel7"
ISO_FILE="/var/lib/libvirt/boot/CentOS-7-x86_64-Minimal-1708.iso"
OS_TYPE="linux"

sudo virt-install \
--virt-type=kvm \
--name ${VM_NAME} \
--ram ${MEM_SIZE} \
--vcpus=${VCPUS} \
--os-variant=${OS_VARIANT}  \
--virt-type=kvm \
--hvm \
--location=${ISO_FILE} \
--network=bridge=${BRIDGE},model=virtio \
--graphics vnc \
--disk pool=images-1,size=${DISK_SIZE},bus=virtio,format=qcow2 \
--initrd-inject /var/www/html/ks.cfg \
--extra-args "inst.ks=file:/ks.cfg"

## Restore starting kickstarter cfg
#sudo sed -i 's/'$HOST_NAME'/server1/g' /var/www/html/ks.cfg
#sudo sed -i 's/'$IP_ADDRESS'/ip_address/g' /var/www/html/ks.cfg
#sudo sed -i 's/'$MASK'/net_mask/g' /var/www/html/ks.cfg
#sudo sed -i 's/'$DEFAULT_GW'/default_gw/g' /var/www/html/ks.cfg
#sudo sed -i 's/'$DNS'/dns_server/g' /var/www/html/ks.cfg
sudo cp -rf /var/www/html/ks.bak /var/www/html/ks.cfg


