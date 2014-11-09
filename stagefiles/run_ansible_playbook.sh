#!/bin/bash

cp /media/stagefiles/racattack-full-install.yml /media/stagefiles/ansible-oracle/racattack-full-install.yml 
cp /media/stagefiles/all.group_vars /media/stagefiles/ansible-oracle/group_vars/all
cp /media/stagefiles/grid-install.rsp.12.1.0.2.j2.standard /media/stagefiles/ansible-oracle/oraswgi-install/templates/grid-install.rsp.12.1.0.2.j2 

for x in {a,l,n}{1..9}; do
  echo "master_node: false" > /media/stagefiles/ansible-oracle/host_vars/collab$x
done
echo "master_node: true" > /media/stagefiles/ansible-oracle/host_vars/collabn1

time ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook /media/stagefiles/ansible-oracle/racattack-full-install.yml -i /media/stagefiles/ansible-oracle/inventory/racattack
