
class el::epel {

    case $lsbdistid {
	'CentOS', 'RedHat', 'RedHatEnterpriseServer': {
                package { "epel":
		  name => "epel-release-6-8.noarch",
                  ensure => installed,
                  source => 'http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm',
                  provider => 'rpm',
                }
	}
    }

}
