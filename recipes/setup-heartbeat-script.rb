#
# Cookbook Name:: vpcnat
# Recipe:: setup-heartbeat-script
#
#
# Copyright 2014, WESEEK, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

scripts = node["vpcnat"][:scripts]

# getting some data using ws-util
az = EC2Util.get_instance_az
instance_id = EC2Util.get_instance_id
instance_region = EC2Util.get_instance_region
azsettings =  node["vpcnat"][:az][az]

# getting Amazon SNS settings from data bag
bag_item = data_bag_item_safely('sns', 'alert')

# create directories
directory scripts[:install_dir] do
  owner scripts[:user]
  group scripts[:group]
  mode '755'
  action :create
end

# install scripts
template "#{scripts[:install_dir]}/check.sh" do
  source "check.sh.erb"
  owner scripts[:user]
  group scripts[:group]
  mode '755'
  variables({
    :enabled => azsettings[:enabled],
    :aws_fullpath => scripts[:aws_fullpath],
    :region => instance_region,
    :instance_id => instance_id,
    :opposite_rtb => azsettings[:opposite_rtb],
    :opposite_primary_nat_id => azsettings[:opposite_primary_nat_id],
    :target_via_inetgw => azsettings[:target_via_inetgw],
    :target_via_checking_nat => azsettings[:target_via_checking_nat],
    :sns_arn => bag_item['dest_arn'],
    :sns_region => bag_item['region']
  })
end

### register to cron.d
cron_d "nat_heartbeat" do
  user scripts[:user]
  # run every 30s
  command "(#{scripts[:install_dir]}/check.sh & sleep 30; #{scripts[:install_dir]}/check.sh) >/dev/null 2>&1"
end
