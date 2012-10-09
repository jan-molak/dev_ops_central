class sensu::server::config($rabbitmq_server=hiera('rabbitmq_server'))
{

	file{'/etc/sensu/conf.d/rabbitmq.json':
	    ensure => present,
	    content => template('/vagrant/modules/sensu/templates/etc/sensu/conf.d/rabbitmq.json.erb'),
	    owner  => 'root',
	    group  => 'root',
	    mode   => '0644',
  	}

  	file{'/etc/sensu/conf.d/redis.json':
	    ensure => present,
	    source => '/vagrant/modules/sensu/files/etc/sensu/conf.d/redis.json',
	    owner  => 'root',
	    group  => 'root',
	    mode   => '0644',
  	}

  	file{'/etc/sensu/conf.d/handlers.json':
	    ensure => present,
	    source => '/vagrant/modules/sensu/files/etc/sensu/conf.d/handlers.json',
	    owner  => 'root',
	    group  => 'root',
	    mode   => '0644',
  	}

	file{'/etc/sensu/conf.d/checks.json':
		ensure => absent,
		source => '/vagrant/modules/sensu/files/etc/sensu/conf.d/checks.json',
		owner  => 'root',
		group  => 'root',
		mode   => '0644',
	}

	file{'/etc/sensu/conf.d/dashboard.json':
	    ensure => present,
	    source => '/vagrant/modules/sensu/files/etc/sensu/conf.d/dashboard.json',
	    owner  => 'root',
	    group  => 'root',
	    mode   => '0644',
  	}

	file{'/etc/sensu/conf.d/api.json':
	    ensure => present,
	    source => '/vagrant/modules/sensu/files/etc/sensu/conf.d/api.json',
	    owner  => 'root',
	    group  => 'root',
	    mode   => '0644',
  	}

	file{'/etc/sensu/handlers':
		ensure  => directory,
		owner   => 'root',
		group   => 'root',
		mode    => '0755',
		recurse => true
	}

}
