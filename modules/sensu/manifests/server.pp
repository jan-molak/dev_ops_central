class sensu::server
{
	info "Provisioning Sensu Server"
	
	include rabbitmq
	include sensu::common::package, sensu::common::config
	include sensu::server::config, sensu::server::service	

	Class['sensu::common::package'] -> Class['sensu::common::config'] -> Class['sensu::server::config'] -> Class['sensu::server::service']

	Class['sensu::common::config'] ~> Class['sensu::server::service']
	Class['sensu::server::config'] ~> Class['sensu::server::service']

}
