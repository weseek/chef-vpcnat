#
# Cookbook Name:: vpcnat
# Recipe:: disable-source-dest-check
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
