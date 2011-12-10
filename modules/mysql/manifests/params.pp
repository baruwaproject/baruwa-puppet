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

# Class: mysql::params
#
#
class mysql::params {

    $packagename = $operatingsystem ? {
        default => "mysql-server",
    }

    $packagename_client = $operatingsystem ? {
        redhat  => "mysql",
        centos  => "mysql",
        default => "mysql-client",
    }

    $servicename = $operatingsystem ? {
        redhat  => "mysqld",
        centos  => "mysqld",
        default => "mysql",
    }

    $processname = $operatingsystem ? {
        default => "mysqld",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        debian  => "/etc/mysql/my.cnf",
        ubuntu  => "/etc/mysql/my.cnf",
        default => "/etc/my.cnf",
    }

    $configfile_mode = $operatingsystem ? {
        default => "644",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        default => "root",
    }

    $configdir = $operatingsystem ? {
        default => "/etc/mysql/conf.d",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/mysql",
        ubuntu  => "/etc/default/mysql",
        default => "/etc/sysconfig/mysqld",
    }
}