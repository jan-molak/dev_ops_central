class sensu::client
{

  info "Provisioning Sensu Client"

  include sensu::common::package
  include sensu::common::config
  include sensu::client::package
  include sensu::client::config
  include sensu::client::service	

  Class['sensu::common::package'] -> Class['sensu::common::config'] -> Class['sensu::client::package'] -> Class['sensu::client::config'] -> Class['sensu::client::service']

  Class['sensu::common::config'] ~> Class['sensu::client::service']
  Class['sensu::client::config'] ~> Class['sensu::client::service']

}
