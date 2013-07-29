# Class: metasploit
#
# This class installs metasploit and dependencies
#
# Actions:
#   - Installs rvm and ruby 1.9.3-p125
#   - Installs the apt modules metasploit depends on
#   - Installs metasploit from source and bundles it
#
# Sample Usage:
#  class { 'metasploit': }
#
class metasploit {
  require stdlib

  $ruby_version = 'ruby-1.9.3-p125'
  $metasploit_path = '/usr/local/metasploit'

  class { 'apt':
    always_apt_update => true,
    stage => 'setup',
    before => Stage['rvm-install']
  }

  # Install the prereqs
  class { 'metasploit::dependencies':
  }

  # Ensure the proper ruby
  class { 'rvm':
  }

  rvm_system_ruby { $ruby_version:
    ensure => present,
    default_use => true,
    require => Class['rvm']
  }

  rvm_gem { 'bundler':
    name => 'bundler',
    ruby_version => $ruby_version,
    ensure => latest,
    require => Rvm_system_ruby[$ruby_version];
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
    require => [Vcsrepo[$metasploit_path], Class['metasploit::dependencies']]
  }
}