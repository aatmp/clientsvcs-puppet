
class ftpd::smartpath {

    include ftpd::ftpd_common

    @user { 'smartpath':
        password => '$6$aJVxKV.3$W/3sfaL1NUV2jJ7INqwP2ayv8E39GPk0H.pfAPicw05rfxoCI53B34F8TW1fKV8bDwokLN0xKsnJMJQw7Wb4D1',
        home => '/opt/./ftp/',
        shell => '/sbin/nologin',
    }
    realize( User[smartpath] )

    file { '/opt/ftp':
        ensure => "directory",
        owner  => "smartpath",
        group  => "root",
        mode   => 1755,
    }

}
