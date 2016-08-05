def load_current_resource

  package 'ruby-mysql2'

  @new_username  = "#{new_resource.user}"                                        
  @new_host      = "#{new_resource.host}" 
  @new_database  = "#{new_resource.database}"                                    
  @new_table     = "#{new_resource.table}"
  ##@new_privilege = "#{new_resource.privilege}"
  @new_privilege = 'ALL'

  Mysql::Connection.init_class(node['mysql']['server']['host'], 
                               node['mysql']['user']['root'], 
                               node['mysql']['passwd']['root'])

  @db_conn = Mysql::Connection.instance()


end


use_inline_resources


action :grant do

  sql_grant = 
    "GRANT " + @new_privilege + " ON " + @new_database + "." + @new_table + 
    " TO " + "'" + @new_username + "'@'" + @new_host + "'"

  @db_conn.query(sql_grant)
  @db_conn.query('FLUSH PRIVILEGES')

  ##new_resource.updated_by_last_action(true)

end


action :revoke do

  # TODO Check if for user privileges are set first:
  ##if has_privileges(@new_host, @new_database, @new_username)
    
    sql_revoke = 
      "REVOKE " + @new_privilege + " ON " + @new_database + "." + @new_table + 
      " FROM " + "'" + @new_username + "'@'" + @new_host + "'"

    @db_conn.query(sql_revoke)                                                     
    @db_conn.query('FLUSH PRIVILEGES') 

    ##new_resource.updated_by_last_action(true)

  ##end

  
end


def has_privileges(host, database, user)

  # TODO Check db and/or tables_priv.
  ##sql_select = 
  ## "SELECT 1 FROM mysql.db WHERE host = '" + @new_host +"' AND db = '" + 
  ## @new_database + "' AND user = '" + @new_username + "'"
  
  return false

end
