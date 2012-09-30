class role_monitoring_server {
	$my_role = 'monitoring_server'
	include ruby-devel
	include rabbitmq
	include redis
	include hiera
	include sensu::server

	Class['ruby-devel'] -> Class['hiera'] -> Class['sensu::server']
}

class role_monitoring_client {
	$my_role = 'monitoring_client'
	include cron
	include ruby-devel
	include hiera
	include sensu::client
}

node monitoring_server {
 	include role_monitoring_server
}

node monitoring_client {
	include role_monitoring_client
}
