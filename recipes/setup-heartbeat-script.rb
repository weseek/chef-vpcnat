#
# Cookbook Name:: ws-nat
# Recipe:: setup-heartbeat-script
#
# Copyright 2014, WESEEK, Inc.
#
# All rights reserved - Do Not Redistribute
#

scripts = node["ws-nat"][:scripts]

# getting some data using ws-util
az = get_instance_az
instance_id = get_instance_id
instance_region = get_instance_region
azsettings =  node["ws-nat"][:az][az]

# getting Amazon SNS settings from data bag
bag_item = get_data_bag_item_safely('sns', 'alert')

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
    :opposit_rtb => azsettings[:opposit_rtb],
    :opposit_primary_nat_id => azsettings[:opposit_primary_nat_id],
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
