
class nginx::oep-base {

    service { "Nginx Httpd Server":
        name      => "nginx",
        enable    => true,
        hasstatus => true,
        ensure    => running,
        require   => Package["nginx"] 
    }

    case $lsbdistid {
        'Ubuntu': {
		file { "nginx.list":
		  name => "/etc/apt/sources.list.d/nginx.list", 
		  ensure  => file,
		  source  => "puppet:///nginx/nginx.list",
		  owner   => "root",
		  group   => "root",
		  notify => Exec['import_key_apt_keystore_for_nginx']
		}

		exec { 'import_key_apt_keystore_for_nginx':
		  path => '/bin:/usr/bin',
		  environment => 'HOME=/root',
		  command => "wget -O- http://nginx.org/keys/nginx_signing.key | apt-key add -",
		  user => 'root',
		  group => 'root',
		  unless => "apt-key list | grep nginx",
		  logoutput => on_failure,
		  notify => Exec['apt_get_update_for_nginx']
		}

		exec { 'apt_get_update_for_nginx':
		  command     => '/usr/bin/apt-get update',
		  timeout     => 240,
		  returns     => [ 0, 100 ],
		  refreshonly => true
		}
		package { "Nginx Httpd Server":
		  name   => "nginx",
		  ensure => '1.6.0-1~precise',
		  require => [ File['nginx.list'],Exec['import_key_apt_keystore_for_nginx'],Exec['apt_get_update_for_nginx'] ]
		}
        }
	'CentOS', 'RedHat', 'RedHatEnterpriseServer': {
		yumrepo { 'mp':
		  descr   => 'mp repo',
		  baseurl => 'http://yum.mediaplatform.com/el/$releasever/$basearch/',
		  enabled => 1,
		  gpgcheck => 0,
		  before   => Package["nginx"]
		}
                package { "Nginx Httpd Server":
                  name   => "nginx",
                  ensure => '1.6.1-2.el6.mp',
                  require => yumrepo['mp']
                }
	}
    }

}
