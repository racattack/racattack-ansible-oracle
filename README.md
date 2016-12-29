racattack-ansible-oracle
========================

This is a joint work between 2 projects.

[https://github.com/racattack/vagrantfile](https://github.com/racattack/vagrantfile)

and

[https://github.com/oravirt/ansible-oracle](https://github.com/oravirt/ansible-oracle)

The idea is provide a fully automated racattack build from vm to database, 100% hands free

### Before start

If you are new to vagrant, the suggestion would be test the standalone vagrant project, which is documented here:
[http://en.wikibooks.org/wiki/RAC_Attack_-_Oracle_Cluster_Database_at_Home/RAC_Attack_Automation](http://en.wikibooks.org/wiki/RAC_Attack_-_Oracle_Cluster_Database_at_Home/RAC_Attack_Automation)

### This project

Clone as:
`git clone --recursive https://github.com/racattack/racattack-ansible-oracle`

`cd racattack-ansible-oracle`

edit Vagranfile and adjust number of nodes, ram and size of shared disk


```ruby
#############################
#### BEGIN CUSTOMIZATION ####
#############################

#versions can be set by variables
#or here
ENV['giver']||="12.1.0.2"
ENV['dbver']||="12.1.0.2"

#domain to be used in all nodes
domain = "domain"

# array of dc names
#dca = ["prd"]
dca = ["prd","dev"]
#dca = ["prd","stb","dev"]

# define number of nodes
num_APPLICATION       = 1
num_LEAF_INSTANCES    = 1
num_DB_INSTANCES      = 2

#define number of cores for guest
num_CORE              = 2
 
#define memory for each type of node in MBytes
#
#for leaf nodes, the minimun can be  2300, otherwise pre-check will fail for
#automatic ulimit values calculated based on ram
#
#for database nodes, the minimum suggested is 3072 for standard cluster
#for flex cluster, consider 4500 or more
memory_APPLICATION    = 2500
memory_LEAF_INSTANCES = 3300
memory_DB_INSTANCES   = 5500
         
#size of shared disk in GB
#disk are data x2 , fra x1
size_shared_disk      = 50

#############################
##### END CUSTOMIZATION #####
#############################
```

place oracle binaries at swrepo/

For 12.1.0.2:
    linuxamd64_12102_database_1of2.zip
    linuxamd64_12102_database_2of2.zip
    linuxamd64_12102_grid_1of2.zip
    linuxamd64_12102_grid_2of2.zip

For 12.1.0.1:
    linuxamd64_12c_database_1of2.zip
    linuxamd64_12c_database_2of2.zip
    linuxamd64_12c_grid_1of2.zip
    linuxamd64_12c_grid_2of2.zip

For 11.2.0.4:
    p13390677_112040_Linux-x86-64_1of7.zip
    p13390677_112040_Linux-x86-64_2of7.zip
    p13390677_112040_Linux-x86-64_3of7.zip
  
 For 11.2.0.3: 
    p10404530_112030_Linux-x86-64_1of7.zip
    p10404530_112030_Linux-x86-64_2of7.zip
    p10404530_112030_Linux-x86-64_3of7.zip

### First boot
`vagrant up` will create the machines
This process can take time as here is where the shared disk will be created.

If you wish to reinstall, and avoid waiting on this step, you can use `setup=clean vagrant provision`

### Installation
`setup=standard vagrant provision` will setup an standard 12.1.0.2 oracle cluster

`setup=flex vagrant provision` will setup an flex oracle cluster

if any leaf node is defined, cluster will be defaulted to flex

At this moment, defaults are giver and dbver 12.1.0.2

It is also possible to have different combinations of GI/DB installations. 
The supported versions are (at the moment): 12.1.0.2, 12.1.0.1 and 11.2.0.4, 11.2.0.3

It works like this:

```bash
setup=<standard|flex> [giver=<12.1.0.2|12.1.0.1|11.2.0.4|11.2.0.3>] [dbver=<12.1.0.2|12.1.0.1|11.2.0.4|11.2.0.3>] vagrant provision
```

so if you want a 12.1.0.2 GI installation and a 11.2.0.4 database, it should look like this:

```bash
setup=standard dbver=11.2.0.4 vagrant provision
```

### Clean up for reinstall
`setup=clean vagrant provision` will delete `/u01` , clean up previous installation, bring shared disk to clean state, then just stop the machines. `vagrant halt`.

then a `vagrant up` will start a clean environment. This is useful to avoid recreating the shared disk since is time consuming task.

### Delete
`vagrant destroy -f` will delete all the VMs and the shared disk



alvaro @ kikitux.net

oravirt @ gmail.com
