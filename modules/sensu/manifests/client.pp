class sensu::client {

  include sensu::common

  include sensu::client::package, sensu::client::config, sensu::client::service	

  Class['sensu::common'] -> Class['sensu::client::package'] -> Class['sensu::client::config'] -> Class['sensu::client::service']

  Class['sensu::common::config'] ~> Class['sensu::client::service']
  Class['sensu::client::config'] ~> Class['sensu::client::service']

}
