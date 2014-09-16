
class nginx::oep_rtmp {

    include nginx::oep-base

    file { "nginx.conf":
        name    => "/etc/nginx/nginx.conf",
        source  => "puppet:///nginx/rtmp/nginx.conf",
        owner   => root,
        group   => root,
        mode    => 400,
        notify  => Service[nginx],
        require => Package[nginx]
    }

    file { '/opt/www':
        ensure => "directory",
        owner  => "root",
        group  => "root",
        mode   => 755,
    }

    file { "crossdomain.xml":
        name    => "/opt/www/crossdomain.xml",
        source  => "puppet:///nginx/web/crossdomain-all.xml",
        owner   => root,
        group   => root,
        mode    => 444,
    }

    file { "stat.xsl":
        name    => "/opt/www/stat.xsl",
        source  => "puppet:///nginx/rtmp/stat.xsl",
        owner   => root,
        group   => root,
        mode    => 444,
    }

}
