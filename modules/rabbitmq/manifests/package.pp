class rabbitmq::package
{
	$version = "2.8.7"
  $url     = "http://www.rabbitmq.com/releases/rabbitmq-server/v${version}/rabbitmq-server-${version}-1.noarch.rpm"

	package{"erlang":
    ensure => "present",
  }

  package{"rabbitmq-server":
    provider => "rpm",
    source   => $url
  }

  Package['erlang'] -> Package['rabbitmq-server']
}