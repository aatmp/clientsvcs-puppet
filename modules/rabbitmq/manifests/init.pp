
class rabbitmq::rabbitmq_common {

    service { "rabbitmq server":
        name      => "rabbitmq-server",
        enable    => true,
        hasstatus => true,
        ensure    => running,
        require   => Package["rabbitmq-server"] 
    }

    case $operatingsystem {
        'Ubuntu': {
		package { "rabbitmq server":
		  name   => "rabbitmq-server",
		  ensure => '2.8.13-2~precise.mp',
		  require => [ File['rabbitmq.list'],Exec['import_key_apt_keystore_for_rabbitmq'],Exec['apt_get_update_for_rabbitmq'] ]
		}
        }
	'CentOS', 'RedHat', 'RedHatEnterpriseServer': {
	    package { "erlang":
		ensure => "latest", 
		require => package["epel"]
	    }

                package { "rabbitmq server":
                  name   => "rabbitmq-server",
                  ensure => '3.3.5-2.el6.mp',
                  require => [ yumrepo['mp'],Package["erlang"] ]
                }
	}
    }

}
