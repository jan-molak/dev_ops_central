class sensu::server(
	$rabbitmq_server=hiera('rabbitmq_server'))
{

	info "Provisioning Sensu Server"
	
	include sensu::common::package
	include sensu::common::config
	include sensu::server::config 
	include sensu::server::service	

	Class['sensu::common::package'] -> Class['sensu::common::config'] -> Class['sensu::server::config'] -> Class['sensu::server::service']

	Class['sensu::common::config'] ~> Class['sensu::server::service']
	Class['sensu::server::config'] ~> Class['sensu::server::service']

}
