class sensu::service {

  service{"sensu-server":
    ensure => running,
    enable => true,
  }

  service{"sensu-api":
    ensure  => running,
    enable  => true,
    require => Service['sensu-server'],
  }

  service{"sensu-client":
    ensure  => running,
    enable  => true,
    require => Service['sensu-server'],
  }

  service{"sensu-dashboard":
    ensure  => running,
    enable  => true,
    require => Service['sensu-server'],
  }
}

