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

define line($file, $line, $ensure = 'present') {
    case $ensure {
        default : { err ( "unknown ensure value ${ensure}" ) }
        present: {
            exec { "/bin/echo '${line}' >> '${file}'":
                unless => "/bin/grep -qFx '${line}' '${file}'"
            }
        }
        absent: {
            exec { "/bin/grep -vFx '${line}' '${file}' | /usr/bin/tee '${file}' > /dev/null 2>&1":
              onlyif => "/bin/grep -qFx '${line}' '${file}'"
            }
        }
        uncomment: {
            exec { "/bin/sed -i -e '/${line}/s/#\+//' '${file}'":
                onlyif => "/bin/grep '${line}' '${file}' | /bin/grep '^#' | /usr/bin/wc -l"
            }
        }
        comment: {
            exec { "/bin/sed -i -e '/${line}/s/\(.\+\)$/#\1/' '${file}'":
                onlyif => "/usr/bin/test `/bin/grep '${line}' '${file}' | /bin/grep -v '^#' | /usr/bin/wc -l` -ne 0"
            }
        }
    }
}

define prepend_if_no_such_line($file, $line, $refreshonly = 'false') {
    exec { "/usr/bin/perl -p0i -e 's/^/$line\n/;' '$file'":
        unless      => "/bin/grep -Fxqe '$line' '$file'",
        path        => "/bin",
        refreshonly => $refreshonly,
    }
}

define delete_lines($file, $pattern) {
    exec { "/bin/sed -i -r -e '/$pattern/d' $file":
        onlyif => "/bin/grep -E '$pattern' '$file'",
    }
}