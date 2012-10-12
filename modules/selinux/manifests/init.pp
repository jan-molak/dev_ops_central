class selinux
{
	file{'/etc/selinux/config':
		source => '/vagrant/modules/selinux/files/etc/selinux/config',
		owner => 'root',
		group => 'root',
		mode => '644',
	}
}