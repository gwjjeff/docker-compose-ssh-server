#!/usr/bin/env bash
sudo su <<EOF
sed -i '/^###AUTOGENBEGIN/,/^###AUTOGENEND/d' /etc/hosts
echo '###AUTOGENBEGIN' >> /etc/hosts
sh gen-hosts.sh >> /etc/hosts
echo '###AUTOGENEND' >> /etc/hosts
EOF

sed -i '/^###AUTOGENBEGIN/,/^###AUTOGENEND/d' entryfiles/_etc/dnsmasq.conf
echo '###AUTOGENBEGIN' >> entryfiles/_etc/dnsmasq.conf
sh gen-dnsmasq.sh >> entryfiles/_etc/dnsmasq.conf
echo '###AUTOGENEND' >> entryfiles/_etc/dnsmasq.conf
sed -i -e '/^address=/d' entryfiles/_etc/dnsmasq.conf
sh gen-hosts.sh > entryfiles/_etc/dnsmasq.hosts

DNSMASQ=`grep dnsmasq /etc/hosts | awk '{print $1}'`
sudo su <<EOF
echo "nameserver $DNSMASQ" > entryfiles/_etc/resolv.conf
EOF

curl -ujeff:test -X PUT http://${DNSMASQ}:8080/restart
