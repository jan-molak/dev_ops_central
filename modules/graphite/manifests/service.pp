class graphite::service 
{
	service {'memcached':
		ensure => 'running'
	}

	service {'carbon-cache':
		ensure => 'running'
	}

	# restart httpd
}