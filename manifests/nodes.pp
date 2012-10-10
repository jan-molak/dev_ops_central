stage { 'first': before => Stage['main'] }
stage { 'last': require => Stage['main'] }

class monitoring_base {
	include firewall
	include hiera
	include selinux
}

class role_monitoring_server inherits monitoring_base {
	$my_role = 'monitoring_server'
	

	class {
		'apache':				 stage => first;
		'redis':         stage => first;
		'rabbitmq':      stage => first;
		'sensu::server': stage => main;
		'graphite':      stage => main;
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
