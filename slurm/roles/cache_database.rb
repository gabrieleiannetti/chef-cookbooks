name "cache_database"
description "Installation of slurm database daemon."


run_list(
  "recipe[net::hostname]",
  "recipe[slurm::munge]",
  "recipe[slurm::database]"
)
