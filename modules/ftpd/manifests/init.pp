
class ftpd::ftpd_common {

    case $operatingsystem {

        'CentOS', 'RedHat', 'RedHatEnterpriseServer': {

            package {
                "vsftpd":         ensure => "latest";
            }

	    file { '/opt/ftp':
		ensure => "directory",
		owner  => "root",
		group  => "root",
		mode   => 755,
	    }

        }
    }
}
