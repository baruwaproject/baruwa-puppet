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

# Class: mailscanner::exim inherits mailscanner
#
#
class mailscanner::exim {
    require clamav::params
    #require baruwa::params
    include exim::mailscanner
    include mailscanner
    include exim::disableboot
    include clamav::exim

    file { "/etc/exim/exim.conf":
        path    => "${exim::params::configfile}",
        mode    => "${exim::params::configfile_mode}",
        owner   => "${exim::params::configfile_owner}",
        group   => "${exim::params::configfile_group}",
        require => Package["exim"],
        ensure  => present,
        content => template("mailscanner/exim.conf.erb"),
    }

    file { "/etc/exim/exim_out.conf":
        mode    => 644,
        owner   => root,
        group   => mail,
        require => Package["exim"],
        ensure  => present,
        content => template("mailscanner/exim_out.conf.erb"),
    }

    file { "/etc/exim/trusted-configs":
        mode    => 644,
        owner   => root,
        group   => root,
        require => Package["exim"],
        ensure  => present,
        content => template("mailscanner/trusted-configs.erb"),
    }

    file { "/var/spool/exim.in":
        mode    => 750,
        owner   => exim,
        group   => exim,
        require => Package["exim"],
        ensure  => directory,
    }

    file { "/var/spool/exim.in/input":
        mode    => 750,
        owner   => exim,
        group   => exim,
        require => Package["exim"],
        ensure  => directory,
    }

    file { "/var/spool/exim.in/msglog":
        mode    => 750,
        owner   => exim,
        group   => exim,
        require => Package["exim"],
        ensure  => directory,
    }

    file { "/var/spool/exim.in/db":
        mode    => 750,
        owner   => exim,
        group   => exim,
        require => Package["exim"],
        ensure  => directory,
    }

    file { "/var/spool/MailScanner/quarantine":
        mode    => 775,
        owner   => exim,
        #group  => "${baruwa::params::group}",
        require => [Package["exim"], Class["mailscanner"]],
        ensure  => directory,
    }

    file { "/var/spool/MailScanner/incoming":
        mode    => 775,
        owner   => exim,
        group   => "${clamav::params::username}",
        require => [Package["exim"] , Class["clamav"], Class["mailscanner"]],
        ensure  => directory,
    }
}