
class nodejs::nodejs_common {

    case $lsbdistid {

        'CentOS', 'RedHat', 'RedHatEnterpriseServer': {
            package {
                "nodejs":		ensure  => latest,
                			require => package["epel"]
            }
        }
    }
}
