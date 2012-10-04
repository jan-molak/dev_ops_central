class firewall {

	service{"iptables":
    ensure  => "stopped"
  }

}