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

# Class: baruwa::bayesdb
#
#
class baruwa::bayesdb {
    exec { "baruwa-bayesdb-grant":
        path    => ["/usr/bin", "/bin"],
        unless  => "mysql -u${baruwa_bayes_mysql_user} -p${baruwa_bayes_mysql_pass} ${baruwa_bayes_mysql_dbase} -e 'show tables;'",
        command => "mysql -u${mysql_user} -p${mysql_password} -e \"GRANT ALL ON ${baruwa_bayes_mysql_dbase}.* TO ${baruwa_bayes_mysql_user}@localhost IDENTIFIED BY '${baruwa_bayes_mysql_pass}';FLUSH PRIVILEGES;\"",
        require => [Class["mysql::passwd"], Class["baruwa::createdb"]],
    }
}
