class cron {

	info "Provisioning Cron"

	package{'crontabs':
		ensure => 'present',
	}

	service{'crond':
		ensure => 'stopped',
	}

	Package['crontabs'] -> Service['crond']
}
