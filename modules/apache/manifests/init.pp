class apache {
	
	info "Apache"

	package{'httpd':
		ensure => 'present',
		provider => 'yum',
	}
	
	package{'mod_ssl':
		ensure => 'absent',
		provider => 'yum',
	}

	file{'/etc/httpd/conf/httpd.conf':
		source => '/vagrant/modules/apache/files/etc/httpd/conf/httpd.conf',
		owner => 'root',
		group => 'root',
		mode => '644',
	}

	file{'/var/www/html/htdocs':
		ensure => 'directory',
		owner => 'apache',
		group => 'apache',
		mode => '644',
	}

	service{'httpd':
		ensure => 'running',
	}

	Package['httpd'] -> File['/etc/httpd/conf/httpd.conf'] -> Package['mod_ssl'] -> Service['httpd']

}
