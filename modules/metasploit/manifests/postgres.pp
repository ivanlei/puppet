class metasploit::postgres {
  include apt::params

  $postgres_user = $metasploit::params::postgres_user
  $postgres_password = $metasploit::params::postgres_password
  $postgres_db_name = $metasploit::params::postgres_db_name
  $metasploit_path = $metasploit::params::metasploit_path

  $yaml_path = "${metasploit_path}/database.yml"

	class { 'postgresql':
  	charset => 'sql_ascii',
  	require => Class['metasploit::dependencies'],
	}

	class { 'postgresql::server':
		require => Class['postgresql'],
	}

	postgresql::db { $postgres_db_name:
		user     => $postgres_user,
		password => $postgres_password,
		require => Class['postgresql::server'],
	}

	file { $metasploit_path:
		ensure => directory,
	} ->

	file { $yaml_path:
		ensure => present,
		owner => root,
		group => root,
		mode => '0400',
		content => template("metasploit/database.yaml.erb"),
	}
}