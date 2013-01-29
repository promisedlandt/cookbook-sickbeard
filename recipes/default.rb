#
# Cookbook Name:: sickbeard
# Recipe:: default
#
# Copyright (C) 2012 Nils Landt
#
# All rights reserved - Do Not Redistribute
#

include_recipe "python" unless node[:sickbeard][:skip_python_installation]

node[:sickbeard][:prereq_packages].each do |pkg|
  package pkg
end

# Create system user and group
group node[:sickbeard][:group]

user node[:sickbeard][:user] do
  group node[:sickbeard][:group]
  system true
  shell "/bin/bash"
end

[ node[:sickbeard][:home_dir],
  node[:sickbeard][:config_dir],
  node[:sickbeard][:data_dir] ].each do |dir|

  directory dir do
    mode 0755
    owner node[:sickbeard][:user]
    group node[:sickbeard][:group]
    recursive true
  end
end

# Install the application
if ["git"].include?(node[:sickbeard][:install_method])
  include_recipe "sickbeard::_install_#{ node[:sickbeard][:install_method] }"
else
  Chef::Log.error("sickbeard: installation method not recognized or set: #{ node[:sickbeard][:install_method] }")
end

# Which init style do we want to use?
if ["sysv", "upstart"].include?(node[:sickbeard][:init_style])
  include_recipe "sickbeard::_init_#{ node[:sickbeard][:init_style] }"
else
  Chef::Log.warn("sickbeard: init style not recognized or set: #{ node[:sickbeard][:init_style] }")
end

# HTTP proxy
if ["nginx"].include?(node[:sickbeard][:proxy][:flavor])
  include_recipe "sickbeard::_proxy_#{ node[:sickbeard][:proxy][:flavor] }"
end
