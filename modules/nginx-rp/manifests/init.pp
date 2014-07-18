class nginx-rp {

    include nginx::nginx_common

    file { "nginx.conf":
        name    => "/etc/nginx/nginx.conf",
        source  => "puppet:///nginx-rp/nginx.conf",
        owner   => root,
        group   => root,
        mode    => 400,
        notify  => Service[nginx],
        require => Package[nginx]
    }

    file { "default.conf":
        name    => "/etc/nginx/conf.d/default.conf",
        source  => "puppet:///nginx-rp/sites/default.conf",
        owner   => root,
        group   => root,
        mode    => 400,
        notify  => Service[nginx],
        require => Package[nginx]
    }

    file { "ams01-dev.conf":
        name    => "/etc/nginx/conf.d/ams01-dev.conf",
        source  => "puppet:///nginx-rp/sites/ams01-dev.conf",
        owner   => root,
        group   => root,
        mode    => 400,
        notify  => Service[nginx],
        require => Package[nginx]
    }

    file { "ams01-qa.conf":
        name    => "/etc/nginx/conf.d/ams01-qa.conf",
        source  => "puppet:///nginx-rp/sites/ams01-qa.conf",
        owner   => root,
        group   => root,
        mode    => 400,
        notify  => Service[nginx],
        require => Package[nginx]
    }

    file { "ams01-stg.conf":
        name    => "/etc/nginx/conf.d/ams01-stg.conf",
        source  => "puppet:///nginx-rp/sites/ams01-stg.conf",
        owner   => root,
        group   => root,
        mode    => 400,
        notify  => Service[nginx],
        require => Package[nginx]
    }

    file { "ams01cache.conf":
        name    => "/etc/nginx/conf.d/ams01cache.conf",
        source  => "puppet:///nginx-rp/sites/ams01cache.conf",
        owner   => root,
        group   => root,
        mode    => 400,
        notify  => Service[nginx],
        require => Package[nginx]
    }

    file { "ams01-prod.conf":
        name    => "/etc/nginx/conf.d/ams01-prod.conf",
        source  => "puppet:///nginx-rp/sites/ams01-prod.conf",
        owner   => root,
        group   => root,
        mode    => 400,
        notify  => Service[nginx],
        require => Package[nginx]
    }

    file { "ams02cache.conf":
        name    => "/etc/nginx/conf.d/ams02cache.conf",
        source  => "puppet:///nginx-rp/sites/ams02cache.conf",
        owner   => root,
        group   => root,
        mode    => 400,
        notify  => Service[nginx],
        require => Package[nginx]
    }

    file { "ams02-prod.conf":
        name    => "/etc/nginx/conf.d/ams02-prod.conf",
        source  => "puppet:///nginx-rp/sites/ams02-prod.conf",
        owner   => root,
        group   => root,
        mode    => 400,
        notify  => Service[nginx],
        require => Package[nginx]
    }
}
