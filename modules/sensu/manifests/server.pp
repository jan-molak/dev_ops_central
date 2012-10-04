class sensu::server(
	#$rabbitmq_server=hiera('rabbitmq_server'))
  $rabbitmq_server)
{

	info "Provisioning Sensu Server"
	
	include sensu::common::package
	include sensu::common::config
	class {'sensu::server::config':
		rabbitmq_server => '192.168.10.10'
	}
	include sensu::server::service	

	Class['sensu::common::package'] -> Class['sensu::common::config'] -> Class['sensu::server::config'] -> Class['sensu::server::service']

	Class['sensu::common::config'] ~> Class['sensu::server::service']
	Class['sensu::server::config'] ~> Class['sensu::server::service']

}
