#!/bin/bash

cp /media/stagefiles/racattack-full-install.yml /media/stagefiles/ansible-oracle/racattack-full-install.yml 
cp /media/stagefiles/racattack.group_vars /media/stagefiles/ansible-oracle/group_vars/racattack

time ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook /media/stagefiles/ansible-oracle/racattack-full-install.yml -i /media/stagefiles/ansible-oracle/inventory/racattack
