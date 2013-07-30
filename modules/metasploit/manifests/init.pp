# Class: metasploit
#
# This class installs metasploit and dependencies
#
# Actions:
#   - Installs rvm and ruby 1.9.3-p125
#   - Installs the apt modules metasploit depends on
#   - Installs metasploit from source and bundles it
#   - Configures postgres
#
# TODO:
#   - A few metasploit setup tips:
#       http://fedoraproject.org/wiki/Metasploit_Postgres_Setup#Configure_Metasploit
#       http://www.darkoperator.com/installing-metasploit-in-ubunt/
#
# Sample Usage:
#  class { 'metasploit': }
#
require stdlib

class metasploit {
  include metasploit::params

  $metasploit_path = $metasploit::params::metasploit_path
  $ruby_version = $metasploit::params::ruby_version

  # Install the prereqs
  class { 'metasploit::dependencies':
  }

  class { 'metasploit::ruby':
  }

  vcsrepo { $metasploit_path:
    ensure => present,
    provider => 'git',
    source => 'https://github.com/rapid7/metasploit-framework'
  }

  exec { 'bundle_metasploit':
    command => "sudo /usr/local/rvm/bin/rvm ${ruby_version} do bundle install",
    cwd => $metasploit_path,
    path => ["/usr/bin", "/usr/sbin"],
    require => [Class['metasploit::dependencies'], Vcsrepo[$metasploit_path], Class['metasploit::ruby']]
  }

  class { 'metasploit::postgres':
    require => Class['metasploit::dependencies']
  }

  anchor { 'metasploit::anchor':
    require => [Class['metasploit::postgres'], Class['metasploit::ruby']]
  }
}