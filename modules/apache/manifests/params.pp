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

# Class: apache::params
#
#
class apache::params {
    $packagename = $operatingsystem ? {
        debian  => "apache2",
        ubuntu  => "apache2",
        default => "httpd",
    }

    $servicename = $operatingsystem ? {
        debian  => "apache2",
        ubuntu  => "apache2",
        default => "httpd",
    }

    $servicepattern = $operatingsystem ? {
        debian  => "/usr/sbin/apache2",
        ubuntu  => "/usr/sbin/apache2",
        default => "/usr/sbin/httpd",
    }

    $processname = $operatingsystem ? {
        debian  => "apache2",
        ubuntu  => "apache2",
        default => "httpd",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $username = $operatingsystem ? {
        debian  => "www-data",
        ubuntu  => "www-data",
        default => "apache",
    }

    $configfile = $operatingsystem ? {
        ubuntu  => "/etc/apache2/apache2.conf",
        debian  => "/etc/apache2/apache2.conf",
        default => "/etc/httpd/conf/httpd.conf",
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
        ubuntu  => "/etc/apache2",
        debian  => "/etc/apache2",
        default => "/etc/httpd/conf",
    }

    $documentroot = $operatingsystem ? {
        debian  => "/var/www",
        ubuntu  => "/var/www",
        default => "/var/www/html",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/apache2",
        ubuntu  => "/etc/default/apache2",
        default => "/etc/sysconfig/httpd",
    }

    $modwsgipackage = $operatingsystem ? {
        ubuntu  => "libapache2-mod-wsg",
        debian  => "libapache2-mod-wsgi",
        default => "mod_wsgi",
    }
}