
class nginx::oepms {

    include nginx::oep-base;

    file { "nginx.conf":
        name    => "/etc/nginx/nginx.conf",
        source  => "puppet:///nginx/rtmp/nginx.conf",
        owner   => root,
        group   => root,
        mode    => 400,
        notify  => Service[nginx],
        require => Package[nginx]
    }

    file { "stat.xsl":
        name    => "/tmp/stat.xsl",
        source  => "puppet:///nginx/rtmp/stat.xsl",
        owner   => root,
        group   => root,
        mode    => 444,
        notify  => Service[nginx],
        require => Package[nginx]
    }

    file { "crossdomain.xml":
        name    => "/tmp/crossdomain.xsl",
        source  => "puppet:///nginx/web/crossdomain-all.xml",
        owner   => root,
        group   => root,
        mode    => 444,
        notify  => Service[nginx],
        require => Package[nginx]
    }

    file { '/tmp/oep':
	ensure => "directory",
	owner  => "nobody",
	group  => "root",
	mode   => 1777,
    }

    file { '/tmp/rec':
	ensure => "directory",
	owner  => "nobody",
	group  => "root",
	mode   => 1777,
    }

}
