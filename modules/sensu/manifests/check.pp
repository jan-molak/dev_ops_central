class sensu::check {

	file{'/etc/sensu':
		ensure => 'directory',
		owner => 'root',
		group => 'root',
		mode => '644',
	}

	package{'ruby-devel':
                ensure => 'present',
                provider => 'yum',
        }
	
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
 		mode => '777',
 		require => File['/etc/sensu/plugins'],
 	}

	file{'/etc/sensu/plugins/http-metrics.rb':
                source => '/vagrant/modules/sensu/files/etc/sensu/plugins/http-metrics.rb',
                owner => 'root',
                group => 'root',
                mode => '777',
                require => File['/etc/sensu/plugins'],
        }

	package{'sensu-plugin':
		ensure => 'present',
		provider => 'gem',	
		require => Package['ruby-devel'],
	}

}
