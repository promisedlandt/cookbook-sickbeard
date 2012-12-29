#
# Cookbook Name:: sickbeard
# Recipe:: _init_upstart
#
# Copyright (C) 2012 Nils Landt
#
# All rights reserved - Do Not Redistribute
#

template "/etc/init/sickbeard.conf" do
  source "sickbeard.upstart.erb"
  mode 0644
  notifies :restart, node[:sickbeard][:service_to_be_notified]
end

service "sickbeard" do
  provider Chef::Provider::Service::Upstart
  action [:enable, :start]
end
