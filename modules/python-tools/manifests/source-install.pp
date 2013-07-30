define python-tools::source-install( 
  $repo_url,
  $repo_name     = $name,
  $install_path  = '',
  $provider      = 'git',
  ) 
{
  $repo_path = "/tmp/${repo_name}"
  $exec_name = "install_${repo_name}"

  vcsrepo { $repo_path:
    ensure    => present,
    provider  => $provider,
    source    => $repo_url,
    require   => Class[$provider],
  }

  exec { $exec_name:
    command   => 'sudo python setup.py install',
    cwd       => "${repo_path}/${install_path}",
    path      => ['/usr/bin', '/usr/sbin'],
    require   => Vcsrepo[$repo_path],
  }

  file { $repo_path:
    ensure    => absent,
    force     => true,
    require   => Exec[$exec_name],
  }
}