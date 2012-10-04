class sensu::common::package {

  yumrepo{'sensu':
    descr    => 'sensu-main',
    baseurl  => 'http://repos.sensuapp.org/yum/el/6/x86_64/',
    gpgcheck => '0',
    enabled  => '1',
  }

  package{"sensu":
    ensure  => present,
    provider => 'yum'
  }

  Yumrepo['sensu'] -> Package['sensu']

}
