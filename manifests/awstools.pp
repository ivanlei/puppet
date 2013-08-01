require stdlib
require git
require python_tools
require awscli

require wireless_tools
require hg

class { 'apt-cacher-ng::client':
  server  => "${aptserver_ip}:3142",
  autodetect => false,
  stage => 'setup',
  before => [Class['apt']]
}

class { 'apt':
  always_apt_update => true,
  stage => 'setup',
}