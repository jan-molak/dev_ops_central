class graphite::config
{
	File {
		owner => 'root',
		group => 'root',
		mode  => '0644'
	}

	file {'/etc/httpd/conf.d/graphite.conf':
  	source => '/vagrant/modules/graphite/files/etc/httpd/conf.d/graphite.conf'
	}

	file {'/etc/httpd/conf.d/wsgi.conf':
  	source => '/vagrant/modules/graphite/files/etc/httpd/conf.d/wsgi.conf'
	}

	file {'/etc/init.d/carbon-cache':
  	source => '/vagrant/modules/graphite/files/etc/init.d/carbon-cache'
	}

	file {'/opt/graphite/conf/carbon.conf':
  	source => '/vagrant/modules/graphite/files/opt/graphite/conf/carbon.conf'
	}

	file {'/opt/graphite/conf/graphite.wsgi':
  	source => '/vagrant/modules/graphite/files/opt/graphite/conf/graphite.wsgi'
	}

	file {'/opt/graphite/conf/storage-schemas.conf':
  	source => '/vagrant/modules/graphite/files/opt/graphite/conf/storage-schemas.conf'
	}

	file {'/opt/graphite/webapp/graphite/local_settings.py':
  	source => '/vagrant/modules/graphite/files/opt/graphite/webapp/graphite/local_settings.py'
	}

	# turn off selinux
	# techo 0 > /selinux/enforce
	# setenforce 0

}