class sensu::client::service {

  service{"sensu-client":
    ensure  => running,
    enable  => true,
  }

}

