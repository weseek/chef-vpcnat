name             'chef-vpcnat'
maintainer       'WESEEK, Inc.'
maintainer_email 'yuki@weseek.co.jp'
license          'All rights reserved'
description      'Setup NAT instances on Amazon EC2/VPC'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'awscli'
depends 'cron'
