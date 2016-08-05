name "cluster_worker"
description "Installation of cluster worker."

run_list(                                                                          
  "recipe[net::hostname]",
  "recipe[slurm::munge]",
  "recipe[slurm::worker]"
)    

#default_attributes(
#  "sys" => {
#    "hosts" => {
#      "file" => {
#        "10.1.1.12" => "lxdev02.devops.test lxdev02",
#        "10.1.1.13" => "lxdev03.devops.test lxdev03"
#      },
#      "allow" => [
#        "sshd: 10.1.",
#        "snmpd: 10.1.1.14"
#      ],
#      "deny" => [
#        "ALL: ALL"
#      ]
#    }
#  }
#)
