name             "sickbeard"
maintainer       "Nils Landt"
maintainer_email "cookbooks@promisedlandt.de"
license          "All rights reserved"
description      "Installs/Configures Sick Beard PVR"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.1"

depends "python"
depends "git"

supports "ubuntu"
