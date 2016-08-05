name "cluster_controller"
description "Installation of cluster controller."

run_list(                                                                          
  "recipe[net::hostname]",
  "recipe[slurm::munge]",
  "recipe[slurm::controller]"
)    
