ETHNAME=$(awk -F'=' '/DEVICE/{print $2}' /etc/sysconfig/network-scripts/ifcfg-*|grep -v lo)
#ip addr show "$ETHNAME"|awk 'NR==3{print $2}'|sed -r 's/\/[0-9]{1,}//'
ip addr show "$ETHNAME"|awk 'NR==3{print $2}'|cut -d/ -f1


# b
a=$(awk -F'=' '/DEVICE/{print $2}' /etc/sysconfig/network-scripts/ifcfg-*|grep -v lo|sed 's/"//g'|uniq)
ip addr show $(echo  $a| awk '{print $1}')|awk 'NR==3{print $2}'|cut -d/ -f1

#d
hostname -i|awk '{print $1}'

#e
ip addr show docker0|awk 'NR==3{split($2,a,"/"); print a[1]}'



ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1

hostname -i


ip -o -4 a | awk '$2 == "eth0" { gsub(/\/.*/, "", $4); print $4 }'

ip addr show dev eth0 scope global | grep "inet\b" | cut -d/ -f 1 | egrep -o "([[:digit:]]{1,3}[.]{1}){3}[[:digit:]]{1,3}"


ip addr show eth0 | grep -oP 'inet \K\S[0-9.]+'


ip -f inet a|grep -oP "(?<=inet ).+(?=\/)"

ip -f inet a show eth0|grep -oP "(?<=inet ).+(?=\/)"

ip -6 -o a|grep -oP "(?<=inet6 ).+(?=\/)"

ip -4 -o addr show eth0 | awk '{print $4}' | cut -d "/" -f 1 


ip route get 8.8.8.8 | awk '{ print $NF; exit }'
 
 
hostname --all-ip-addresses | awk '{print $1}'  
  
  
ip addr show eth0 | grep "inet " | cut -d '/' -f1 | cut -d ' ' -f6


ip -f inet addr show $1 | grep -Po 'inet \K[\d.]+'

ip -f inet addr show eth0 | grep -Po 'inet \K[\d.]+'

ip a s|grep -A8 -m1 MULTICAST|grep -m1 inet|cut -d' ' -f6|cut -d'/' -f1