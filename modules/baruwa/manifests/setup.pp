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

# Class: baruwa::setup
#
#
class baruwa::setup inherits baruwa {
    include razor
    include rabbitmq
    include baruwa::apache
    include baruwa::dbgrant
    include baruwa::rabbitmq
    include baruwa::mailscanner
    include dcc::spamassassin
    include mailscanner::enable
    if $baruwa_mysql_repl == 'true' {
        include baruwa::mysqlrepl
    }

    file { "/etc/rabbitmq/rabbitmq.config":
          require   => Service[rabbitmq],
          before    => [File["/etc/baruwa/settings.py"], Class["baruwa::rabbitmq"]],
    }

    file { "/etc/baruwa/settings.py":
        ensure  => present,
        content => template("baruwa/settings.py.erb"),
        require => [Package["mod_wsgi"], Package["baruwa"], Class["baruwa::rabbitmq"], Class["baruwa::dbgrant"]],
        notify  => [Service[apache], Service[baruwa]],
    }

    exec { "baruwa-syncdb":
        command => "baruwa-admin syncdb --noinput",
        path    => "/usr/bin",
        require => [Service[mysql], Exec["grant-${baruwa_mysql_db}-db"], File["/etc/baruwa/settings.py"]],
        unless  => "mysql -uroot -p${mysql_password} ${baruwa_mysql_db} -e \"describe mailq;\"",
    }

    exec { "baruwa-createadmin":
         command    => "baruwa-admin createsuperuser --username=${baruwa_admin_user} --email=${baruwa_admin_email} --noinput",
         path       => "/usr/bin:/bin",
         require    => Exec["baruwa-syncdb"],
         unless     => "mysql -uroot -p${mysql_password} ${baruwa_mysql_db} -e \"select 1 from auth_user where username='${baruwa_admin_user}';\"|grep 1 >/dev/null"
    }
}