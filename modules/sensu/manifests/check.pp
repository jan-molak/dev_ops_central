class sensu::check {

	file{'/etc/sensu/plugins':
		ensure => 'directory',
 		owner => 'root',
 		group => 'root',
 		mode => '644',
	}

	file{'/etc/sensu/plugins/check-procs.rb':
 		source => '/vagrant/modules/sensu/files/etc/sensu/plugins/check-procs.rb',
 		owner => 'root',
 		group => 'root',
 		mode => '644',
 		require => File['/etc/sensu/plugins'],
 	}

	package{'sensu-plugin':
		ensure => 'present',
		provider => 'gem',	
	}

}
