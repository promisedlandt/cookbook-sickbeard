#
# Cookbook Name:: sickbeard
# Recipe:: _install_git
#
# Copyright (C) 2012 Nils Landt
#
# All rights reserved - Do Not Redistribute
#

include_recipe "git"

log "cloning to #{ node[:sickbeard][:home_dir] }: #{ node[:sickbeard][:git][:url] }"

git node[:sickbeard][:home_dir] do
  repository node[:sickbeard][:git][:url]
  reference node[:sickbeard][:git][:sha] if node[:sickbeard][:git][:sha]
  action :sync
  user node[:sickbeard][:user]
  group node[:sickbeard][:group]
  notifies :restart, node[:sickbeard][:service_to_be_notified] if node[:sickbeard][:service_to_be_notified]
end
