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

$mysql_user                     = 'root'
$mysql_password                 = 'ygRBZiyiauh83Zry'
$mailscanner_org_name           = 'BARUWA'
$mailscanner_org_long_name      = 'BARUWA MAILFW'
$mailscanner_inqueue_dir        = '/var/spool/exim.in/input'
$mailscanner_outqueue_dir       = '/var/spool/exim/input'
$mailscanner_quarantine_user    = 'exim'
$mailscanner_quarantine_group   = 'celeryd'
$mailscanner_spam_action        = 'store'
$mailscanner_high_spam_action   = 'store'
$baruwa_admin_user              = 'andrew'
$baruwa_admin_email             = 'user@example.org'
$baruwa_mysql_db                = 'baruwa'
$baruwa_mysql_host              = '127.0.0.1'
$baruwa_mysql_port              = '3306'
$baruwa_mysql_user              = 'baruwa'
$baruwa_mysql_passwd            = '4ejzsBe6RtvXwfDj'
$baruwa_timezone                = 'Africa/Johannesburg'
$baruwa_secret_key              = '1sVes9zfjX"ih_(6o-JmV?y*+k@tYn80vAQ+O%]14[c65w||}/_KiR2V|[vz'
$baruwa_rabbitmq_host           = '127.0.0.1'
$baruwa_rabbitmq_port           = '5672'
$baruwa_rabbitmq_user           = 'baruwa'
$baruwa_rabbitmq_passwd         = 'z3dxyomJ1WTzXvfa'
$baruwa_rabbitmq_vhost          = 'baruwa'
$baruwa_quarantine_host_url     = 'http://mailscanner.topdog-software.com'
$baruwa_apache_vhost            = 'mailscanner.topdog-software.com'
$baruwa_apache_serveraliases    = []
$baruwa_python_ver              = 'python2.4'
$baruwa_bayes_mysql_user        = 'bayes'
$baruwa_bayes_mysql_pass        = 'KxTfELzH1fyxMicak7'
$baruwa_bayes_mysql_dbase       = 'bayes'

Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

include mysql::passwd
include rabbitmq::deleteguest
include clamav::server
include exim
include apache::modwsgi
include mailscanner::exim
include baruwa::setup
include postfix::absent
include sendmail::absent
# include common::installkey
