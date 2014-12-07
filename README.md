racattack-ansible-oracle
========================

This is a joint work between 2 projects.

https://github.com/racattack/vagrantfile

and

https://github.com/oravirt/ansible-oracle

The idea is provide a fully automated racattack build from vm to database, 100% hands free

Clone as:
`git clone --recursive https://github.com/kikitux/racattack-ansible-oracle`

`cd racattack-ansible-oracle`

edit Vagranfile and adjust number of nodes, ram and size of shared disk


```ruby
##### BEGIN CUSTOMIZATION #####
#############################
#define number of nodes
num_APPLICATION     = 0
num_LEAF_INSTANCES  = 0
num_DB_INSTANCES    = 1
#
#define number of cores for guest
num_CORE=1
#
#define memory for each type of node in MBytes
#
#for leaf nodes, the minimun can be  2300, otherwise pre-check will fail for
#automatic ulimit values calculated based on ram
#
#for database nodes, the minimum suggested is 3072
#
memory_APPLICATION    = 1500
memory_LEAF_INSTANCES = 2300
memory_DB_INSTANCES   = 3072
#        
#size of shared disk in GB
size_shared_disk	= 5
#location of shared disk
path_shared_disk = "."
#number of shared disks
count_shared_disk = 4
#
#############################
##### END CUSTOMIZATION #####
```

place oracle binaries at 12cR1/

    linuxamd64_12102_database_1of2.zip
    linuxamd64_12102_database_2of2.zip
    linuxamd64_12102_grid_1of2.zip
    linuxamd64_12102_grid_2of2.zip


`vagrant up` will create the machines

`setup=standard vagrant provision` will setup an standard oracle cluster
`setup=flex vagrant provision` will setup an flex oracle cluster

if any leaf node is defined, cluster will be defaulted to flex

`setup=clean vagrant provision` will delete `/u01` , bring shared disk to clean state and shutdown the vm.

`vagrant up` and will start a clean environment. This is useful to avoid recreating the shared disk since is time consuming task.

alvaro@kikitux.net

