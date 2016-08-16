package 'slurmctld'


cookbook_file '/etc/slurm-llnl/slurm.conf' do
  source 'config/slurm.conf'
  owner 'slurm'
  group 'slurm'
  mode '0755'
  action :create
end


directory '/var/lib/slurm-llnl/state_checkpoint' do
  owner 'slurm'
  group 'slurm'
  mode '0755'
  action :create
end


directory '/var/lib/slurm-llnl/job_checkpoint' do                                
  owner 'slurm'                                                                    
  group 'slurm'                                                                    
  mode '0755'                                                                      
  action :create                                                                   
end     


service 'slurmctld' do                                                           
  action [:enable, :start]                                                    
end


execute('Adding Slurm Cluster') do                                             
    command "sacctmgr add cluster snowflake -i"                                
    returns [0,1]                                                              
end


execute('Adding Slurm Account') do                                             
    command "sacctmgr -i add account slurm Cluster=snowflake Description='none' Organization='none'"
    returns [0,1]                                                              
end   
