hostname = node['hostnames'][node['ipaddress']]


if hostname.nil? or hostname.empty?
   raise "No hostname could be found!"
end


package 'dbus'


execute 'set hostname' do
  command 'hostnamectl set-hostname ' + hostname
  not_if { hostname == node['hostname'] }
end
