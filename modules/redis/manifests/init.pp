class redis {

	info "Provisioning Redis"

	package{'redis':
		ensure => 'present',
		provider => 'yum',
	}

	service{'redis':
		ensure => 'running',
		require => Package['redis'],
	}

}
