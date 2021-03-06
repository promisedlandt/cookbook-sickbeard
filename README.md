# sickbeard

Installs [Sick Beard](http://sickbeard.com/) PVR.

# Platforms

Tested on Ubuntu 12.04. Should work on other distributions, if installing from git, setting an appropriate init style and fixing the required packages in the default recipe.

# Requirements

Chef 0.10.8 and Ohai 0.6.12

# Examples

# Recipes

## sickbeard::default

Installs Sick Beard, optionally with an init script and HTTP proxy.

## sickbeard::dns

Set up a dns entry to your Sick Beard server.

# Attributes

## default

Attribute | Description | Type | Default
--------- | ----------- | ---- | -------
user      | system user to create | String | sickbeard
group     | system user group to create | String | sickbeard
init_style | How to start the sickbeard service. See below | String | upstart
install_style | How to install sickbeard. See below | String | git
home_dir | Directory to install sickbeard to | String | /srv/sickbeard/server
config_dir | Directory where config will be saved | String | /etc/sickbeard
data_dir | Directory where sickbeard will store temporary data, including logs | String | /srv/sickbeard/data
http_port | Port sickbeard will listen on | String | 8081
skip_python_installation | Set to true if you want to skip the python installation | Boolean | false
prereq_packages | Prerequisites packages | Array | ["python-cheetah"]

## proxy

Attribute | Description | Type | Default
--------- | ----------- | ---- | -------
skip_webserver_installation | Set to true if you want to skip the webserver installation | Boolean | false
flavor | What kind of proxy to use. Currently, only nginx is supported | String | none
enable_site | Activate the proxy site | Boolean | true
enable_ssl | Use SSL in the proxy? | Boolean | false
ssl_source | Where to get SSL key / certificate (see section below) | String | databag
ssl_certificate_name | name of the SSL certificate (both on the filesystem and the databag item) | String | sickbeard
cert_key_pair | See "Proxy SSL" below | Hash | nil
templates_cookbook | Which cookbook to use proxy templates from | String | sickbeard

#### nginx

Attribute | Description | Type | Default
--------- | ----------- | ---- | -------
server_name | server_name nginx should listen on | String | "_"
location | nginx location directive | String | "/"

## git

Attribute | Description | Type | Default
--------- | ----------- | ---- | -------
url | URL of the git repo you want to install from (if installing from git) | String | https://github.com/midgetspy/Sick-Beard.git
sha | Use if you want to install a specific revision | String | master

## dns

Attribute | Description | Type | Default
--------- | ----------- | ---- | -------
dns_source | Where to find the ip address for the dns entry. "search" for chef search, or "attribute" | String | search
ip_address | Used if dns_source is set to attribute (or in chef-solo) | String | 127.0.0.1
sickbeard_role | If using search, name of the role to search for | String | role_sickbeard
hostname | Hostname for dns entry | String | sickbeard

### init_style

#### sysv

SysV style init script, installed under /etc/init.d/sickbeard

#### upstart

Upstart script, installed under /etc/init/sickbeard.conf

#### runit

Runit script, installed under /etc/sv/sickbeard/run

### install_style

#### git

Clone sickbeard from the [official repository](https://github.com/midgetspy/Sick-Beard.git).

If you want to install from your fork, change `node[:sickbeard][:git][:url]`.  
If you want to install a specific revision, change `node[:sickbeard][:git][:sha]`.  

# Resources / Providers

none

# Proxying

Sickbeard comes with a builtin web server, but you may want to reverse proxy it.  
Currently, this cookbook only supports Nginx - check the proxy and nginx attributes above.

If you need more than the basic nginx configuration provided here, simply add your own templates (nginx-site-available.erb and nginx-site-available-ssl.erb) to your wrapper cookbook and change `node[:sickbeard][:proxy][:templates_cookbook]` to the name of your wrapper cookbook.

## SSL

By default, if using chef-solo, set `node[:sickbeard][:proxy][:cert_key_pair]`, otherwise add an entry `sickbeard` to an `nginx_ssl_certs` databag.  
However, you can force reading from attributes when *not* using chef-solo by setting `node[:sickbeard][:proxy][:ssl_source] = "attribute"`.

Whichever you choose, the value needs to be a Hash with `"cert"` and `"key"` keys and a certificate and key as values.
