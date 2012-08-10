class sensu::server {

  include sensu::common

  include sensu::server::config, sensu::server::service	

  Class['sensu::common'] -> Class['sensu::server::config'] -> Class['sensu::server::service']

  Class['sensu::common::config'] ~> Class['sensu::server::service']
  Class['sensu::server::config'] ~> Class['sensu::server::service']

}
