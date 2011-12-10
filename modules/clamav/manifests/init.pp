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

# Class: clamav
#
#
class clamav {
    require clamav::params

    package { clamav:
        name   => "${clamav::params::packagename}",
        ensure => installed,
    }

    package { clamav-db:
        name   => "${clamav::params::packagename_db}",
        ensure => installed,
    }

    package { clamav-daemon:
        name   => "${clamav::params::packagename_daemon}",
        ensure => installed,
    }

    package { "clamav-unofficial-sigs":
        name   => "${clamav::params::packagename_unofficial_sigs}",
        ensure => installed,
    }

    exec { "freshclam":
        command => "freshclam",
        path    => "/usr/bin:/bin",
        require => [Package[clamav-daemon]],
        timeout => 600,
        unless  => "ls /var/lib/clamav/main.cvd &>/dev/null",
    }
}