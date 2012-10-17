class hiera {

	info "Provisioning Hiera"

	file{'/etc/puppet/hiera.yaml':
		ensure => present,
		source => '/vagrant/modules/hiera/files/etc/puppet/hiera.yaml',
		owner  => 'root',
		group  => 'root',
		mode   => '0644',
	}

	file{'/etc/puppet/hieradb/default.json':
		ensure => present,
		source => '/vagrant/modules/hiera/files/etc/puppet/hieradb/default.json',
		owner  => 'root',
		group  => 'root',
		mode   => '0644',
	}
}