
class mp::mp_common {

    case $operatingsystem {
        'Ubuntu': {
		file { "mp.list":
		  name => "/etc/apt/sources.list.d/mp.list", 
		  ensure  => file,
		  source  => "puppet:///mp/mp.list",
		  owner   => "root",
		  group   => "root",
		  notify => Exec['import_key_apt_keystore_for_mp']
		}

		exec { 'import_key_apt_keystore_for_mp':
		  path => '/bin:/usr/bin',
		  environment => 'HOME=/root',
		  command => "wget -O- http://services001.mediaplatform.com/keys/mp_signing.key | apt-key add -",
		  user => 'root',
		  group => 'root',
		  unless => "apt-key list | grep redis",
		  logoutput => on_failure,
		  notify => Exec['apt_get_update_for_mp']
		}

		exec { 'apt_get_update_for_mp':
		  command     => '/usr/bin/apt-get update',
		  timeout     => 240,
		  returns     => [ 0, 100 ],
		  refreshonly => true
		}
		#package { "":
		#  name   => "",
		#  ensure => "",
		#  require => [ File['mp.list'],Exec['import_key_apt_keystore_for_mp'],Exec['apt_get_update_for_mp'] ]
		#}
        }
	'CentOS', 'RedHat', 'RedHatEnterpriseServer': {
		yumrepo { 'mp':
		  descr   => 'mp repo',
		  baseurl => 'http://yum.mediaplatform.com/el/$releasever/', #$basearch/',
		  enabled => 1,
		  gpgcheck => 0,
		}
                #package { "":
                #  name   => "",
                #  ensure => '',
                #  require => yumrepo['mp']
                #}
	}
    }

}
