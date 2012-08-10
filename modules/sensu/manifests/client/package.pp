class sensu::client::package {

        package{'ruby-devel':
                ensure => 'present',
                provider => 'yum',
        }

        package{'sensu-plugin':
                ensure => 'present',
                provider => 'gem',
                require => Package['ruby-devel'],
        }

        Package['ruby-devel'] -> Package['sensu-plugin']

}
