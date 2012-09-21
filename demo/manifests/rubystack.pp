class rubystack {
  exec{ 'apt-update':
    command => '/usr/bin/apt-get update'
  }

  package{"nginx":
    ensure => installed,
    require => Exec['apt-update']
  }

  package{"mysql-server":
    ensure => installed,
    require => Exec['apt-update']
  }

  service{"nginx":
    ensure => running,
    require => Package['nginx']
  }

  service{"mysql":
    ensure => running,
    require => Package['mysql-server']
  }

}
