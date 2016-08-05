name "add_user"
description "Adds slurm user to database."


run_list(
  "recipe[mysql::add_user]"
)


default_attributes(
  'host'    => 'lxcc01.devops.test',
  'user'    => 'slurm',
  'passwd'  => '12345678',
  'db'      => 'slurm_acct_db'
)
