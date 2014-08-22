
class redis::redis_common {

    service { "redis server":
        name      => "redis",
        enable    => true,
        hasstatus => true,
        ensure    => running,
        require   => Package["redis"] 
    }

    case $operatingsystem {
        'Ubuntu': {
		package { "redis server":
		  name   => "redis",
		  ensure => '2.8.13-2~precise.mp',
		  require => [ File['redis.list'],Exec['import_key_apt_keystore_for_redis'],Exec['apt_get_update_for_redis'] ]
		}
        }
	'CentOS', 'RedHat', 'RedHatEnterpriseServer': {
                package { "redis server":
                  name   => "redis",
                  ensure => '2.8.13-2.el6.mp',
                  require => yumrepo['mp']
                }
	}
    }

}
