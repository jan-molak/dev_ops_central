class sensu::package {

  yumrepo{'sensu':
    descr    => 'sensu-main',
    baseurl  => 'http://repos.sensuapp.org/yum/el/6/i386/',
    gpgcheck => '0',
    enabled  => '1',
 }  

  package{"sensu":
    ensure  => "present",
    require => Yumrepo['sensu'],
  }
}

