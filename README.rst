Baruwa Puppet Tooster
=====================

This puppet tooster will install and configure a fully working
MailScanner/Baruwa system on Centos 5, Centos 6 may work with
minor twicks.

The following software gets installed and configured

+ MailScanner
+ Exim
+ Baruwa
+ Mysql
+ Apache
+ Mod_wsgi
+ Spamassassin
+ Clamav
+ RabbitMQ
+ DCC
+ Razor
+ KAM.cf

To install copy the manifests and modules to your puppet directory
edit the settings in manifests/toasters/baruwa/init.pp, then run
puppet::

	puppet -v /etc/puppet/manifests/toasters/baruwa/init.pp
	
Support
=======

Use the baruwa mailing lists at http://lists.baruwa.org

Contributing
============

Contributions to make add other distro's and MTA's are welcome,
Send me a pull request.
