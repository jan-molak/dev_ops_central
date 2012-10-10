class graphite::package
{
	Package {
	  ensure => 'installed',
		provider => 'rpm'
	}

	package {'carbon':
		source => '/vagrant/modules/graphite/files/rpms/carbon-0.9.9-1.noarch.rpm'
	}

	package {'graphite-web':
		source => '/vagrant/modules/graphite/files/rpms/graphite-web-0.9.9-1.noarch.rpm'
	}

	package {'whisper':
		source => '/vagrant/modules/graphite/files/rpms/whisper-0.9.9-1.noarch.rpm'
	}

	Package['carbon'] -> Package['graphite-web'] -> Package['whisper']
}