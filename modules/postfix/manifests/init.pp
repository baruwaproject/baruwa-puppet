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

# Class: postfix
#
#
class postfix {
    require postfix::params
    package { "postfix":
        name   => "${postfix::params::packagename}",
        ensure => present,
    }

    service { "postfix":
        name       => "${postfix::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${postfix::params::hasstatus}",
        pattern    => "${postfix::params::processname}",
        require    => Package["postfix"],
        subscribe  => File["main.cf"],
    }

    file { "main.cf":
        path    => "${postfix::params::configfile}",
        mode    => "${postfix::params::configfile_mode}",
        owner   => "${postfix::params::configfile_owner}",
        group   => "${postfix::params::configfile_group}",
        ensure  => present,
        require => Package["postfix"],
        notify  => Service["postfix"],
    }
}