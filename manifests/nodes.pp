class monitoring_base {
	include firewall
	#include hiera
}

class role_monitoring_server inherits monitoring_base {
	$my_role = 'monitoring_server'
	
	include rabbitmq
	include redis
	
	class {'sensu::server':
		rabbitmq_server => '192.168.10.10'
	}
}

class role_monitoring_client inherits monitoring_base {
	$my_role = 'monitoring_client'
	
	include cron
	
	class {'sensu::client':
		rabbitmq_server => '192.168.10.10',
		sensu_client => '192.168.10.20',
	}
}

node monitoring_server {
 	include role_monitoring_server
}

node monitoring_client {
	include role_monitoring_client
}
