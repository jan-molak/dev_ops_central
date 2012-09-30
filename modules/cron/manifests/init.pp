class cron {

	info "Cron"

	package{'crontabs':
		ensure => 'present',
	}

	service{'crond':
		ensure => 'running',
	}

	Package['crontabs'] -> Service['crond']

}
