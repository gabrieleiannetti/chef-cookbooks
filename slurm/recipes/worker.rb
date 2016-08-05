package 'slurmd'


cookbook_file '/etc/slurm-llnl/slurm.conf' do
  source 'config/slurm.conf'
  owner 'slurm'
  group 'slurm'
  mode '0755'
  action :create
end


service 'slurmd' do                                                          
  action [:enable, :start]                                                      
end
