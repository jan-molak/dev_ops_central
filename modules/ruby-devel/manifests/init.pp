class ruby-devel {

	info "Ruby-Devel"

	package{'ruby-devel':
		ensure => 'present',
		provider => 'yum',
	}

}