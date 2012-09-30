class hiera {

	info "Provisioning Hiera"

	package{'hiera':
		ensure => 'present',
		provider => 'gem',
	}

	package{'hiera-puppet':
		ensure => 'present',
		provider => 'gem',
	}

	package{'hiera-json':
		ensure => 'present',
		provider => 'gem',
	}

	file{'/etc/puppet/hiera.yaml':
		ensure => present,
		source => '/vagrant/modules/hiera/files/etc/puppet/hiera.yaml',
		owner  => 'root',
		group  => 'root',
		mode   => '0644',
	}

	file{'/etc/puppet/hieradb':
		ensure  => directory,
		owner   => 'root',
		group   => 'root',
		mode    => '0755',
		recurse => true
	}

	file{'/etc/puppet/hieradb/default.json':
		ensure => present,
		source => '/vagrant/modules/hiera/files/etc/puppet/hieradb/default.json',
		owner  => 'root',
		group  => 'root',
		mode   => '0644',
	}
	
	Package['hiera'] -> Package['hiera-json'] -> Package['hiera-puppet']

	Package['hiera-puppet'] -> File['/etc/puppet/hiera.yaml']

	File['/etc/puppet/hieradb'] -> File['/etc/puppet/hieradb/default.json']

}