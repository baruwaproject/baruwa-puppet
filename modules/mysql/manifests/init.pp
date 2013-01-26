#
#
# Topdog Puppet modules
# Copyright (C) 2011  Andrew Colin Kissa <andrew@topdog.za.net>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# vim: ai ts=4 sts=4 et sw=4
#

# Class: mysql
#
#
class mysql {
    require mysql::params
    package { mysql:
        name   => "${mysql::params::packagename}",
        ensure => present,
    }

    service { mysql:
        name       => "${mysql::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${mysql::params::hasstatus}",
        pattern    => "${mysql::params::processname}",
        require    => Package["mysql"],
        subscribe  => File["mysql.conf"],
    }

    file { "mysql.conf":
        path    => "${mysql::params::configfile}",
        mode    => "${mysql::params::configfile_mode}",
        owner   => "${mysql::params::configfile_owner}",
        group   => "${mysql::params::configfile_group}",
        ensure  => present,
        content => $baruwa_mysql_repl ? {
           /(?i:true)/ => template("mysql/my-replicated.cnf.erb"),
           default => template("mysql/my.cnf.erb"),
        },
        require => Package["mysql"],
        notify  => Service["mysql"],
    }
}