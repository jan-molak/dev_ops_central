stage { 'first': before => Stage['main'] }
stage { 'last': require => Stage['main'] }

class monitoring_base {
	include firewall
	include hiera
}

class role_monitoring_server inherits monitoring_base {
	$my_role = 'monitoring_server'
	

	class {
		'redis': stage => first;
		'rabbitmq': stage => main;
		'sensu::server':   stage => last;
	}
}

class role_monitoring_client inherits monitoring_base {
	$my_role = 'monitoring_client'
	
	include cron
	include sensu::client
}

node monitoring_server {
 	include role_monitoring_server
}

node monitoring_client {
	include role_monitoring_client
}
