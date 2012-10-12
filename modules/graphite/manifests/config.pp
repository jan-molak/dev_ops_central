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
  	source => '/vagrant/modules/graphite/files/etc/init.d/carbon-cache',
  	mode   => '0744'
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

	file {'/opt/graphite/storage':
		owner   => 'apache',
		group   => 'apache',
		recurse => true
	}

	exec { 'syncdb':
		command => '/usr/bin/python /opt/graphite/webapp/graphite/manage.py syncdb --noinput',
		unless  => '/usr/bin/python /opt/graphite/webapp/graphite/manage.py inspectdb | grep account_mygraph'
	}

}