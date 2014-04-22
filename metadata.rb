name             'vpcnat'
maintainer       'WESEEK, Inc.'
maintainer_email 'yuki@weseek.co.jp'
license          'Apache 2.0'
description      'Setup NAT instances on Amazon EC2/VPC'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.2.3'

depends 'sysctl', '= 0.4.0'
depends 'iptables', '= 0.13.2'
depends 'cron', '= 1.3.6'
depends 'awscli'

depends 'databag-util'
depends 'ec2util'
