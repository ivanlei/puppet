class metasploit::ruby {
  include apt::params

  $ruby_version = $metasploit::params::ruby_version

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
}