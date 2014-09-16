
class ftpd::ftpd_common {

    case $operatingsystem {

        'CentOS', 'RedHat', 'RedHatEnterpriseServer': {

            package {
                "vsftpd":         ensure => "latest";
            }

        }
    }
}
