# CHANGELOG for vpcnat

This file is used to list changes made in each version of vpcnat.

## 1.2.4 (2014-04-30)

* follow the version of chef-awscli cookbook

## 1.2.3 (2014-04-23)

* abolish ["vpcnat"]["scripts"]["aws_fullpath"]

## 1.2.2 (2014-04-23)

* Support Amazon Linux (To be precise, the OS that do not been supported by cron_d.)

## 1.2.1 (2014-04-22)

* Fix spells and examples


## 1.2.0 (2014-04-21)

* Update README
* Apply Apache 2.0 License

## 1.1.0:

* Use opscode/sysctl cookbook and set ``net.ipv4.ip_forward``
* Use opscode/iptables cookbook and configure IP Masquerading
* Add default recipe

## 1.0.1:

* Bugfix of Berksfile


## 1.0.0:

* Initial release
