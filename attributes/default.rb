default[:sickbeard][:user] = "sickbeard"
default[:sickbeard][:group] = "sickbeard"

default[:sickbeard][:prereq_packages] = value_for_platform_family(
                                          "default" => ["python-cheetah"]
                                        )

default[:sickbeard][:init_style] = "upstart"
default[:sickbeard][:install_method] = "git"

default[:sickbeard][:service_to_be_notified] = "service[sickbeard]"

default[:sickbeard][:home_dir] = "/srv/sickbeard/server"
default[:sickbeard][:data_dir] = "/srv/sickbeard/data"
default[:sickbeard][:config_dir] = "/etc/sickbeard"

default[:sickbeard][:http_port] = "8081"

default[:sickbeard][:git][:url] = "https://github.com/midgetspy/Sick-Beard.git"
default[:sickbeard][:git][:sha] = "master"

default[:sickbeard][:proxy][:flavor] = "none"
default[:sickbeard][:proxy][:enable_site] = true
default[:sickbeard][:proxy][:enable_ssl] = false
default[:sickbeard][:proxy][:ssl_source] = "databag"
default[:sickbeard][:proxy][:ssl_certificate_name] = "sickbeard"
default[:sickbeard][:proxy][:skip_webserver_installation] = false
default[:sickbeard][:proxy][:templates_cookbook] = "sickbeard"

default[:sickbeard][:proxy][:nginx][:server_name] = "_"
default[:sickbeard][:proxy][:nginx][:location] = "/"
