class redis {

	package{'redis':
		ensure => 'present',
		provider => 'yum',
	}

	service{'redis':
		ensure => 'running',
		require => Package['redis'],
	}

}
