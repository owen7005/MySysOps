ETHNAME=$(awk -F'=' '/DEVICE/{print $2}' /etc/sysconfig/network-scripts/ifcfg-*|grep -v lo)
#ip addr show "$ETHNAME"|awk 'NR==3{print $2}'|sed -r 's/\/[0-9]{1,}//'
ip addr show "$ETHNAME"|awk 'NR==3{print $2}'|cut -d/ -f1


# b
a=$(awk -F'=' '/DEVICE/{print $2}' /etc/sysconfig/network-scripts/ifcfg-*|grep -v lo|sed 's/"//g'|uniq)
ip addr show $(echo  $a| awk '{print $1}')|awk 'NR==3{print $2}'|cut -d/ -f1

#d
hostname -i|awk '{print $1}'
