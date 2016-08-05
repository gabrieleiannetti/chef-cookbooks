name "account_database"
description "Installation of a MySQL database."


run_list(
  "recipe[net::hostname]",
  "recipe[mysql]"
)
