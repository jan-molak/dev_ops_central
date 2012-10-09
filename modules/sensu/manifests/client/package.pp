class sensu::client::package {

        package{'sensu-plugin':
                ensure => 'present',
                provider => 'gem'
        }

}
