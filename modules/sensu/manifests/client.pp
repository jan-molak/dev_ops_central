class sensu::client(
	#$rabbitmq_server=hiera('rabbitmq_server'),
	#$sensu_server=hiera('sensu_server'))
  $rabbitmq_server,
  $sensu_client)
{

  info "Provisioning Sensu Client"

  include sensu::common::package
  include sensu::common::config
  include sensu::client::package
  class { "sensu::client::config":
    rabbitmq_server => '192.168.10.10',
    sensu_client => '192.168.10.20'
  }
  include sensu::client::service	

  Class['sensu::common::package'] -> Class['sensu::common::config'] -> Class['sensu::client::package'] -> Class['sensu::client::config'] -> Class['sensu::client::service']

  Class['sensu::common::config'] ~> Class['sensu::client::service']
  Class['sensu::client::config'] ~> Class['sensu::client::service']

}
