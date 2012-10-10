class selinux
{
	exec {'disable-selinux':
		command => "setenforce 0",
		path    => "/usr/bin:/usr/sbin:/bin"
	}

}