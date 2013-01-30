#
# Cookbook Name:: sickbeard
# Recipe:: _init_runit
#
# Copyright (C) 2012 Nils Landt
#
# All rights reserved - Do Not Redistribute
#

include_recipe "runit"

runit_service "sickbeard" do
  owner node[:sickbeard][:user]
  group node[:sickbeard][:group]
  default_logger true
  action [:enable, :start]
end
