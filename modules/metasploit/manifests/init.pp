# Class: metasploit
#
# This class installs metasploit and dependencies
#
# Actions:
#   - Installs rvm and ruby 1.9.3-p125
#   - Installs the apt modules metasploit depends on
#   - Installs metasploit from source and bundles it
#
# TODO:
#   - Manage postgres setup ala http://www.darkoperator.com/installing-metasploit-in-ubunt/
#   - cat > ~/.msf4/msfconsole.rc << EOF
#     db_connect -y /usr/local/metasploit/database.yml
#     workspace -a YourProject
#     EOF
#   - A few non ubuntu tips http://fedoraproject.org/wiki/Metasploit_Postgres_Setup#Configure_Metasploit
#
# Sample Usage:
#  class { 'metasploit': }
#
class metasploit {
  require stdlib

  $ruby_version = 'ruby-1.9.3-p125'
  $metasploit_path = '/usr/local/metasploit'

  # Install the prereqs
  class { 'metasploit::dependencies':
    before => Vcsrepo[$metasploit_path]
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