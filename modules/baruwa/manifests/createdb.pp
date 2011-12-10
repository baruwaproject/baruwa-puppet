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

# Class: baruwa::createdb
#
#
class baruwa::createdb {
    exec { "create-bayesdb":
        path    => ["/usr/bin", "/bin"],
        unless  => "mysql -u${mysql_user} -p${mysql_password} -e \"show databases like '${baruwa_bayes_mysql_dbase}';\"|grep ${baruwa_bayes_mysql_dbase} &>/dev/null",
        command => "mysql -u${mysql_user} -p${mysql_password} -e \"CREATE DATABASE IF NOT EXISTS ${baruwa_bayes_mysql_dbase} CHARACTER SET utf8 COLLATE utf8_unicode_ci;\"",
        require => Class["mysql::passwd"],
    }
}