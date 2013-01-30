#
# Cookbook Name:: sickbeard
# Recipe:: _init_sysv
#
# Copyright (C) 2012 Nils Landt
#
# All rights reserved - Do Not Redistribute
#

link "/etc/init.d/sickbeard" do
  to ::File.join(node[:sickbeard][:home_dir], "init.ubuntu")
end

template "/etc/default/sickbeard" do
  source "etc.default.sickbeard.erb"
  mode 0644
  notifies :restart, node[:sickbeard][:service_to_be_notified]
end

service "sickbeard" do
  action [:enable, :start]
end
