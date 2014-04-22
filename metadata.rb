name             'vpcnat'
maintainer       'WESEEK, Inc.'
maintainer_email 'yuki@weseek.co.jp'
license          'Apache 2.0'
description      'Setup NAT instances on Amazon EC2/VPC'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.2.2'

depends 'sysctl'
depends 'iptables'
depends 'awscli'
depends 'cron'

depends 'databag-util'
depends 'ec2util'
