racattack-ansible-oracle
========================
Clone as:
git clone --recursive https://github.com/kikitux/racattack-ansible-oracle

cd racattack-ansible-oracle

edit Vagranfile and adjust number of nodes, ram and size of shared disk

place oracle binaries at 12cR1/

`vagrant up` will create the machines

`setup=standard vagrant provision` will setup an standard oracle cluster
`setup=flex vagrant provision` will setup an flex oracle cluster

if any leaf node is defined, cluster will be defaulted to flex

`setup=clean vagrant provision` will delete `/u01` , bring shared disk to clean state and shutdown the vm.

`vagrant up` and will start a clean environment. This is useful to avoid recreating the shared disk since is time consuming task.

alvaro@kikitux.net

