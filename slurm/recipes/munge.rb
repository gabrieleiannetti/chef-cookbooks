package 'munge'


require "base64"

file '/etc/munge/munge.key' do
  ##content Base64.encode64(node['munge']['key'])
  content node['munge']['key']

  mode '0400'
  owner 'munge'
  group 'root'
  action :create
end


service "munge" do
  action [:enable, :restart]
end
