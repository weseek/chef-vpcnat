#
# Cookbook Name:: vpcnat
# Recipe:: instance-up
#
# Copyright 2014, WESEEK, Inc.
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'awscli'

instance_region = EC2Util.get_instance_region
instance_id = EC2Util.get_instance_id

execute 'disable Source/dest. check' do
  command <<-EOH
    aws ec2 \
      --region '#{instance_region}' \
      modify-instance-attribute \
        --instance-id '#{instance_id}' \
        --source-dest-check false
  EOH
end
