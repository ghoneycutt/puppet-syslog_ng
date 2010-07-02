# Class: syslog_ng
#
# This module manages syslog-ng
# 
# There are two main pices:  client and server
#   client goes everywhere
#   server goes on the central logging hosts.
#
# syslog_ng is a generic class that is
# inherited by either client or server
#
class syslog_ng {

    package { "syslog-ng": 
        require => Exec["remove sysklogd"],
    } # package

    service { "syslog-ng":
        enable  => true,
        ensure  => running,
        require => Package["syslog-ng"],
    } # service

    File { require => Package["syslog-ng"] }

    file { "/etc/syslog-ng":
        ensure => directory,
        mode   => "755";
    } # file

    exec { "remove sysklogd":
        command => "rpm -e --nodeps sysklogd",
        onlyif  => "rpm -q sysklogd",
    } # exec
    
} # class syslog_ng
