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

# Class: baruwa::mailscanner
#
#
class baruwa::mailscanner inherits mailscanner::exim {
    include baruwa
    include spamassassin
    include baruwa::bayessql
    require baruwa::params

    file { "sa-local.cf":
        path    => "/etc/mail/spamassassin/local.cf",
        content => template("baruwa/sa.local.cf.erb"),
        ensure  => present,
        require => [Class["spamassassin"], Class["baruwa::bayessql"]],
    }

    file { "/etc/mail/spamassassin/spam.assassin.prefs.cf":
        target  => "/etc/MailScanner/spam.assassin.prefs.conf",
        require => [Package["spamassassin"], File["/etc/MailScanner/spam.assassin.prefs.conf"]],
        ensure  => link,
    }

    file { "/etc/MailScanner/conf.d/baruwa.conf":
        ensure  => present,
        require => [Package["mailscanner"], Package["baruwa"]],
        notify  => Service["mailscanner"],
        content => template("baruwa/baruwa-mailscanner.conf.erb"),
    }

    file { "/etc/MailScanner/spam.assassin.prefs.conf":
        ensure  => present,
        mode    => "0644",
        owner   => root,
        group   => root,
        require => Package["mailscanner"],
        content => template("baruwa/spam.assassin.prefs.conf.erb"),
    }

    file { "filename.rules":
        mode    => "0644",
        owner   => root,
        group   => root,
        require => Package["mailscanner"],
        content => template("baruwa/filename.rules"),
        notify  => Service["mailscanner"],
        path    => "/etc/MailScanner/rules/filename.rules",
    }

    file { "filetype.rules":
        mode    => "0644",
        owner   => root,
        group   => root,
        require => Package["mailscanner"],
        content => template("baruwa/filetype.rules"),
        notify  => Service["mailscanner"],
        path    => "/etc/MailScanner/rules/filetype.rules",
    }

    file { "filetype.rules.allowall.conf":
        mode    => "0644",
        owner   => root,
        group   => root,
        require => Package["mailscanner"],
        content => template("baruwa/filetype.rules.allowall.conf"),
        notify  => Service["mailscanner"],
        path    => "/etc/MailScanner/filetype.rules.allowall.conf",
    }

    file { "filename.rules.allowall.conf":
        mode    => "0644",
        owner   => root,
        group   => root,
        require => Package["mailscanner"],
        content => template("baruwa/filename.rules.allowall.conf"),
        notify  => Service["mailscanner"],
        path    => "/etc/MailScanner/filename.rules.allowall.conf",
    }

    file { "content.scanning.rules":
        mode    => "0644",
        owner   => root,
        group   => root,
        require => Package["mailscanner"],
        content => template("baruwa/content.scanning.rules"),
        notify  => Service["mailscanner"],
        path    => "/etc/MailScanner/rules/content.scanning.rules",
    }

    File["/var/spool/MailScanner/quarantine"]{
        group => "${baruwa::params::group}",
    }
}
