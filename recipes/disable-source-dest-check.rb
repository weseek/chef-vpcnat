#
# Cookbook Name:: ws-nat
# Recipe:: instance-up
#
# Copyright 2014, WESEEK, Inc.
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'awscli'

execute 'disable Source/dest. check' do
  command <<-EOH
    aws ec2 \
      --region '#{node[:opsworks][:instance][:region]}' \
      modify-instance-attribute \
        --instance-id '#{node[:opsworks][:instance][:aws_instance_id]}' \
        --source-dest-check false
  EOH
end
