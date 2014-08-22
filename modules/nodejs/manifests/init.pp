
class nodejs::nodejs_common {

    case $operatingsystem {

        'CentOS', 'RedHat', 'RedHatEnterpriseServer': {
	    include "el::epel"
            package {
                "nodejs":		ensure  => latest,
                			require => package["epel"]
            }
        }
    }
}
