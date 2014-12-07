#!/bin/bash

[ -f /media/stagefiles/ansible-oracle/group_vars/racattack ] && chmod ugo+rw /media/stagefiles/ansible-oracle/group_vars/racattack
cat /media/stagefiles/racattack.group_vars > /media/stagefiles/ansible-oracle/group_vars/racattack

for x in {a,l,n}{1..9}; do
  echo "master_node: false" > /media/stagefiles/ansible-oracle/host_vars/collab$x
done
echo "master_node: true" > /media/stagefiles/ansible-oracle/host_vars/collabn1

if [ $1 == "standard" ] ; then
  cluster_type="standard"
else
  cluster_type="flex"
fi

time ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook /media/stagefiles/ansible-oracle/racattack-full-install.yml -i /media/stagefiles/ansible-oracle/inventory/racattack -e oracle_gi_cluster_type=$cluster_type
