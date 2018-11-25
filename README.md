# create-vm
BASH script to automate KVM provisioning of CentOS VMs via customising kickstart profiles and building from ISO
Designed for labs

Full credit: original script from https://computingforgeeks.com/rhel-centos-kickstart-automated-installation-kvm-virt-install/

Script kicks off sudo virt-install and passes options to the kickstart file so the VM has the characteristics desired (IP address, CPU, RAM etc.).
Kickstart actions include adding lab user/key + sudo permissions. 

NOTE: Kickstart file has been sanitised, replace XXXXX with your own values (passwords etc.)

Syntax Example: 
create-vm.sh -h mctest -n mctest -c 1 -m 512 -k 10 -i 172.16.1.12 -s 255.255.255.0 -g 172.16.1.1 -d 172.16.1.1 -b br111

Assumptions / variables:
- kickstart file "ks.cfg" and backup "ks.bak" located in /var/www/html (should really stop being lazy and turn the path into a var)
- ISO_FILE="/var/lib/libvirt/boot/CentOS-7-x86_64-Minimal-1708.iso"

Command Syntax:
- h HOST_NAME
- n VM_NAME (KVM domain)
- c VCPUS
- m MEM_SIZE (gb)
- k DISK_SIZE (gb)
- i IP_ADDRESS
- s MASK
- g DEFAULT_GW
- d DNS
- b BRIDGE or interface name

