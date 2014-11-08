#!/bin/bash

time ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook /media/stagefiles/ansible-oracle/racattack-full-install.yml -i /media/stagefiles/ansible-oracle/inventory/racattack
