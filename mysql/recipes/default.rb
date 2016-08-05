package 'mysql-server' do
    response_file 'mysql_server_response_file.erb'
end

execute ('Cleanup debconf root_password') do
    command "echo 'mysql-server mysql-server/root_password password ' | debconf-set-selections"
    action :nothing
    subscribes :run, 'package[mysql-server]', :delayed
end

execute ('Cleanup debconf root_password_again') do                                      
    command "echo 'mysql-server mysql-server/root_password_again password ' | debconf-set-selections"
    action :nothing
    subscribes :run, 'package[mysql-server]', :delayed
end

service "mysql" do                                                             
    action [:enable, :start]                                                   
end
