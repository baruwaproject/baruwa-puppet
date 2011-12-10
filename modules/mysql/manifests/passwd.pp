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

# Class: mysql::passwd
#
#
class mysql::passwd {
    include mysql
    exec { "set-mysql-password":
        path    => ["/bin", "/usr/bin"],
        unless  => "mysqladmin -u${mysql_user} -p${mysql_password} status",
        command => "mysqladmin -u${mysql_user} password ${mysql_password}",
        require => Class["mysql"],
        notify  => Exec["secure-mysql-accounts"],
    }

    exec { "secure-mysql-accounts":
        command => "mysql -u${mysql_user} -p${mysql_password} mysql -e \"UPDATE user SET password=PASSWORD('${mysql_password}') WHERE password='';\"",
        path    => ["/bin", "/usr/bin"],
        onlyif  => "mysql -u${mysql_user} -p${mysql_password} mysql -e \"SELECT 1 FROM user WHERE password='';\"|grep '1' &>/dev/null",
        require => Exec["set-mysql-password"],
        notify  => Exec["flush-privilages"],
    }

    exec { "flush-privilages":
        command     => "mysql -u${mysql_user} -p${mysql_password} mysql -e \"FLUSH PRIVILEGES;\"",
        path        => ["/bin", "/usr/bin"],
        refreshonly => true,
    }
}
