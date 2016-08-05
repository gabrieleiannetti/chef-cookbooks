package 'slurmctld'


cookbook_file '/etc/slurm-llnl/slurm.conf' do
  source 'config/slurm.conf'
  owner 'slurm'
  group 'slurm'
  mode '0755'
  action :create
end


service 'slurmctld' do                                                           
  action [:enable, :start]                                                    
end


# TODO MAKE THIS IDEMPOTENT -> MAYBE CALLING "sacctmgr list cluster" in a custom LWRP?

# TODO: If Cluster already exists the return code 1 is returned. How to handle that otherwise? Wrap that call into a ressource?
execute('Adding Slurm Cluster') do                                             
    command "sacctmgr add cluster snowflake -i"                                
    returns [0,1]                                                              
end


# TODO: If nothing to do then the return code 1 is returned.                    
execute('Adding Slurm Account') do                                             
    command "sacctmgr -i add account slurm Cluster=snowflake Description='none' Organization='none'"
    returns [0,1]                                                              
end   
