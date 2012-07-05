class sensu {
  info "Provisioning Sensu"

  include sensu::package, sensu::config, sensu::service, sensu::check

  Class['sensu::package'] -> Class['sensu::config'] -> Class['sensu::service']
  Class['sensu::config'] ~> Class['sensu::service']
}

