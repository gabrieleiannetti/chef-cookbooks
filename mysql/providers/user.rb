def load_current_resource
  
  package 'ruby-mysql2'
  
  ##@current_resource = Chef::Resource::MysqlUser.new(new_resource.name)
  @new_username = "#{new_resource.user}"
  @new_password = "#{new_resource.password}"
  @new_host     = "#{new_resource.host}"

  @password_uptodate = true


  Mysql::Connection.init_class(node['mysql']['server']['host'],                 
                               node['mysql']['user']['root'],                  
                               node['mysql']['passwd']['root'])                 
                                                                                  
  @db_conn = Mysql::Connection.instance()

  sql_select = 
    "SELECT user, password FROM mysql.user WHERE user = '" + 
    @new_username + "' AND host = '" + @new_host + "'"
  
  result = @db_conn.query(sql_select)

  if result.nil? == false and result.first.nil? == false
    
    @db_user     = result.first['user']
    @db_pw_hash  = result.first['password']

    unless create_hash(@new_password) == @db_pw_hash
      @password_uptodate = false
    end
  end

end

# Without this option, any resources declared inside the Provider are added to 
# the resource collection after the current position at the time the action is 
# executed. 
use_inline_resources


action :create do
  
  unless @new_username == @db_user

    create_new_user(@new_username, @new_password, @new_host) 
    
    log "Created new user: " + @new_username + "'@'" + @new_host

    # Whether or not this resource was updated during the most recent action.
    new_resource.updated_by_last_action(true)
  
  end

  unless @password_uptodate
    
    update_password(@new_username, @new_password, @new_host)
     
    log "Updated password for user: " + @new_username + "'@'" + @new_host

    new_resource.updated_by_last_action(true)
    
  end
end


action :update do
  
  unless @password_uptodate
    
    update_password(@new_username, @new_password, @new_host)
     
    log "Updated password for user: " + @new_username + "'@'" + @new_host

    new_resource.updated_by_last_action(true)
    
  end
end


def create_new_user(username, password, host)

  sql_create = "CREATE USER '" + username + "'@'" + host + 
               "' IDENTIFIED BY '" + password + "';"
  
  @db_conn.query(sql_create)

  @db_conn.query('FLUSH PRIVILEGES')

end


def create_hash(password)

  ret_val = ''

  if password.nil? == false and password.empty? == false

    result = @db_conn.query("SELECT PASSWORD('" + password + "')")

    unless @db_conn.affected_rows()
      raise "Failed to create a hash value for password!" 
    end
    
    ret_val = result.first.values[0]
  
  end

  return ret_val

end


def update_password(username, password, host)

  sql_update_pw = 
    "UPDATE mysql.user SET password=PASSWORD('" + password + 
    "') WHERE user = '" + username + "' AND host = '" + host + "'"
    
  @db_conn.query(sql_update_pw)

  unless @db_conn.affected_rows()
    raise ("Failed to update password of user: " + username + "'@'" + host) 
  end

  @db_conn.query('FLUSH PRIVILEGES')

end
