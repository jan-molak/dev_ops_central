class sensu::server::service {

  service{"sensu-server":
    ensure => running,
    enable => true,
  }

  service{"sensu-api":
    ensure  => running,
    enable  => true,
  }

  service{"sensu-dashboard":
    ensure  => running,
    enable  => true,
  }

  Service['sensu-server'] -> Service['sensu-api'] -> Service['sensu-dashboard']
}

