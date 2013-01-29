#
# Cookbook Name:: sickbeard
# Recipe:: dns
#
# Copyright (C) 2012 Nils Landt
#
# All rights reserved - Do Not Redistribute
#

ip_address = if Chef::Config[:solo] || node[:sickbeard][:dns][:dns_source] == "attribute"
               node[:sickbeard][:dns][:ip_address]
             else
               search(:node, "roles:#{ node[:sickbeard][:dns][:sickbeard_role] }").first
             end

hostsfile_entry ip_address do
  hostname node[:sickbeard][:dns][:hostname]
  action :create
end
