#package 'ruby-mysql2'
#
#
#mysql_user node['slurmdb']['user'] do                                                           
#  password node['slurmdb']['passwd']                                                           
#  host 'localhost'                                                           
#end
#
#
#mysql_user node['slurmdb']['user'] do                                                           
#    password node['slurmdb']['passwd']                                                           
#    host node['hostname']                                                              
#end
#
#
#mysql_user node['slurmdb']['user'] do                                                           
#    password node['slurmdb']['passwd']                                                           
#    host node['fqdn']                                                              
#end
#
#
#mysql_user node['slurmdb']['user'] do                                               
#  password node['slurmdb']['passwd']                                              
#  host node['slurm']['controller']['fqdn']
#  not_if { node['fqdn'] == node['slurm']['controller']['fqdn'] }
#end
#
#
#mysql_privileges 'Granting privileges for host: localhost' do                        
#  user node['slurmdb']['user']                                                                  
#  host 'localhost'                                                             
#  database 'slurm_acct_db'                                                      
#  action 'grant'                                                                
#end    
#
#
#mysql_privileges 'Granting privileges for host: ' + node['hostname'] do   
#  user node['slurmdb']['user']                                                  
#  host node['hostname']                                                  
#  database 'slurm_acct_db'                                                      
#  action 'grant'                                                                
#end     
#
#
#mysql_privileges 'Granting privileges for host: ' + node['fqdn'] do   
#  user node['slurmdb']['user']                                                  
#  host node['fqdn']                                                         
#  database 'slurm_acct_db'                                                      
#  action 'grant'                                                                
#end
#
#
#mysql_privileges 'Granting privileges for slurm controller' do                       
#  user node['slurmdb']['user']                                                      
#  host node['slurm']['controller']['fqdn']                                                                 
#  database 'slurm_acct_db'                                                         
#  action 'grant'
#  not_if { node['fqdn'] == node['slurm']['controller']['fqdn'] }                                                                   
#end


package 'slurmdbd'
                                                                                
                                                                                
cookbook_file '/etc/slurm-llnl/slurmdbd.conf' do                                
    source 'config/slurmdbd.conf'                                               
    owner 'slurm'                                                                
    group 'slurm'                                                                
    mode '0755'                                                                 
    action :create                                                              
end       


service 'slurmdbd' do                                                           
  action [:enable, :start]                                                    
end
