if [ -f /var/named/racattack ];then
  echo "named already configured in $HOSTNAME"
  exit 0
fi 

chkconfig named on
service named stop
rm -f /var/named/racattack /var/named/in-addr.arpa

touch /var/named/racattack
chmod 664 /var/named/racattack
chgrp named /var/named/racattack
chmod g+w /var/named
chmod g+w /var/named/racattack

cp /etc/named.conf /etc/named.conf.ori

grep '192.168.78.52' /etc/named.conf && echo "already configured " || sed -i -e 's/listen-on .*/listen-on port 53 { 192.168.78.52; 127.0.0.1; };/' \
-e 's/allow-query .*/allow-query     { 192.168.78.0\/24; localhost; };/' -e 's/type master;/type slave;\n masters  {192.168.78.51; };/' \
-e '$azone "racattack" {\n  type slave;\n  masters  { 192.168.78.51; };\n  file "racattack";\n};\n\n zone "in-addr.arpa" {\n  type slave;\n  masters  { 192.168.78.51; };\n  file "in-addr.arpa";\n};' \
/etc/named.conf

if [ ! -f /etc/rndc.key ] ; then
  rndc-confgen -a -r /dev/urandom
  chgrp named /etc/rndc.key
  chmod g+r /etc/rndc.key
  service named restart
else
  service named restart
fi

# final command must return success or vagrant thinks the script failed
echo "successfully completed named steps"
