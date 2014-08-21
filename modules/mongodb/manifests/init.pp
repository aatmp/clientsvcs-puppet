
class mongodb::mongodb_common {

    service { "MongoDB Server":
        name      => "mongod",
        enable    => true,
        hasstatus => true,
        ensure    => running,
        require   => Package["mongodb-org"] 
    }

    case $lsbdistid {
        'Ubuntu': {
		file { "mongodb.list":
		  name => "/etc/apt/sources.list.d/mongodb.list", 
		  ensure  => file,
		  source  => "puppet:///mongodb/mongodb.list",
		  owner   => "root",
		  group   => "root",
		  notify => Exec['import_key_apt_keystore_for_mongodb']
		}

		exec { 'import_key_apt_keystore_for_mongodb':
		  path => '/bin:/usr/bin',
		  environment => 'HOME=/root',
		  command => "wget -O- http://mongodb.org/keys/mongodb_signing.key | apt-key add -",
		  user => 'root',
		  group => 'root',
		  unless => "apt-key list | grep mongodb",
		  logoutput => on_failure,
		  notify => Exec['apt_get_update_for_mongodb']
		}

		exec { 'apt_get_update_for_mongodb':
		  command     => '/usr/bin/apt-get update',
		  timeout     => 240,
		  returns     => [ 0, 100 ],
		  refreshonly => true
		}
		package { "MongoDB Server":
		  name   => "mongod",
		  ensure => '2.6.3-1~precise',
		  require => [ File['mongodb.list'],Exec['import_key_apt_keystore_for_mongodb'],Exec['apt_get_update_for_mongodb'] ]
		}
        }
	'CentOS', 'RedHat', 'RedHatEnterpriseServer': {
		yumrepo { 'mongodb':
		  descr   => 'mongodb repo',
		  baseurl => 'http://downloads-distro.mongodb.org/repo/redhat/os/$basearch/',
		  enabled => 1,
		  gpgcheck => 0,
		  before   => Package["mongodb-org"]
		}
                package { "MongoDB Server":
                  name   => "mongodb-org",
                  ensure => '2.6.3-1',
                  require => yumrepo['mongodb']
                }
	}
    }

}
