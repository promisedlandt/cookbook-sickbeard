# sickbeard

Installs [Sick Beard](http://sickbeard.com/) PVR.

# Platforms

Tested on Ubuntu 12.04. Should work on other distributions, if installing from git, setting an appropriate init style and fixing the required packages in the default recipe.

# Requirements

Chef 0.10.8 and Ohai 0.6.12

# Examples

# Recipes

## sickbeard::default

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

## proxy

Attribute | Description | Type | Default
--------- | ----------- | ---- | -------
skip_webserver_installation | Set to true if you want to skip the webserver installation | Boolean | false
flavor | What kind of proxy to use. Currently, only nginx is supported | String | none
enable_ssl | Use SSL only in the proxy? | Boolean | false
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

### init_style

#### sysv

SysV style init script, installed under /etc/init.d/sickbeard

#### upstart

Upstart script, installed under /etc/init/sickbeard.conf

### install_style

#### git

Clone sickbeard from the [official repository](https://github.com/midgetspy/Sick-Beard.git).

If you want to install from your fork, change `node[:sickbeard][:git][:url]`.  
If you want to install a specific revision, change `node[:sickbeard][:git][:sha]`.  

# Resources / Providers

none

# Proxy SSL

By default, if using chef-solo, set `node[:sickbeard][:proxy][:cert_key_pair]`, otherwise add an entry `sickbeard` to an `nginx_ssl_certs` databag.  
However, you can force reading from attributes when *not* using chef-solo by setting `node[:sickbeard][:proxy][:ssl_source] = "attribute"`.

Whichever you choose, the value needs to be a Hash with `"cert"` and `"key"` keys and a certificate and key as values.
