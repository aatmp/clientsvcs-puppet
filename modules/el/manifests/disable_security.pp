class el::disable_security {

    exec { "disable selinux":
        command => "/bin/sed -i s/^SELINUX=enforcing$/SELINUX=disabled/ /etc/sysconfig/selinux",
        unless  => "/bin/grep SELINUX\\=disabled /etc/sysconfig/selinux",
        alias   => "disable_selinux",
    }

    service {"iptables":
        #just disable it, very particular about service
        #ensure => stopped,
        enable => false,
    }

}
