#
# Cookbook Name:: sickbeard
# Recipe:: _proxy_nginx
#
# Copyright (C) 2012 Nils Landt
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx" unless node[:sickbeard][:proxy][:skip_webserver_installation]

ssl_dir = ::File.join(node[:nginx][:dir], "ssl")

if node[:sickbeard][:proxy][:enable_ssl]
  ssl_file_stem = ::File.join(ssl_dir, node[:sickbeard][:proxy][:ssl_certificate_name])

  directory ssl_dir do
    mode "0755"
    owner node[:nginx][:user]
    action :create
    recursive true
  end

  if Chef::Config[:solo] || node[:sickbeard][:proxy][:ssl_source] == "attribute"
    cert_key_pair = node[:sickbeard][:proxy][:cert_key_pair]
    cert_content = cert_key_pair["cert"]
    key_content = cert_key_pair["key"]
  else
    cert_key_pair = search(:nginx_ssl_certs, "id:#{ node[:sickbeard][:proxy][:ssl_certificate_name] }").first
    cert_content = cert_key_pair["cert"].join("\n")
    key_content = cert_key_pair["key"].join("\n")
  end

  file "#{ ssl_file_stem }.crt" do
    content cert_content
    owner node[:nginx][:user]
    group "root"
    mode "0600"
    backup false
  end

  file "#{ ssl_file_stem }.key" do
    content key_content
    owner node[:nginx][:user]
    group "root"
    mode "0600"
    backup false
  end
end

template ::File.join(node[:nginx][:dir], "sites-available", "sickbeard") do
  owner node[:nginx][:user]
  backup false
  mode "0644"
  variables(
    :ssl_file_stem => ssl_file_stem
  )
  source node[:sickbeard][:proxy][:enable_ssl] ? "nginx-site-available-ssl.erb" : "nginx-site-available.erb"
  cookbook node[:sickbeard][:proxy][:templates_cookbook]
end

nginx_site "sickbeard" do
  enable node[:sickbeard][:proxy][:enable]
end
