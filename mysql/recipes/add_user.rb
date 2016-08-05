package 'ruby-mysql2'


mysql_user node['user'] do
    password node['passwd']
    host node['host']
end


mysql_privileges 'Granting privileges for a user.' do
  user node['user']
  host node['host']
  database node['db']
  action 'grant'
end
