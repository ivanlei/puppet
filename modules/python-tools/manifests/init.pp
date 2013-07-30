# Class: python-tools
#
# This class installs python-tools
#
# Actions:
#   - Install the python-pip package
#   - Install the virtualenv package using pip
#   - Install the python3 package
#   - Install the pudb package
#   - Install the ipython package
#
# Sample Usage:
#  class { 'python-tools': }
#
class python-tools {
  require python-pip

  $pip_packages = ['pudb, virtualenv','simplejson','xmltodict', 'keyring']

  package { $pip_packages:
    ensure => present,
    provider => 'pip'
  }  

  package { 'python3':
  	ensure => present
  }

  package { 'ipython':
  	ensure => present
  }

  python-tools::source-install { 'keyczar':
    repo_url => 'https://code.google.com/p/keyczar',
    repo_name => 'keyczar',
    install_path => 'python',    
  }
}