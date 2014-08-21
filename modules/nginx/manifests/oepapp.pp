
class nginx::oepapp {

    include nginx::oep-base

    file { "nginx.conf":
        name    => "/etc/nginx/nginx.conf",
        content   => template("nginx/oepapp/nginx.conf.erb"),
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

}
