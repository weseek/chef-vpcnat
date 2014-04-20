#
# Cookbook Name:: vpcnat
# Recipe:: setup-iptables-rules
#
# Copyright 2014, WESEEK, Inc.
#
# All rights reserved - Do Not Redistribute
#


Chef::Log.info("setting up IP Masquerading")

# setting net.ipv4.ip_forwart=1
include_recipe 'sysctl'

sysctl_param 'net.ipv4.ip_forward' do
  value 1
end


# setting iptables
include_recipe 'iptables'

iptables_rule "masquerade" do
  source "iptables/masquerade.erb"
  variables({
    :ipmasq_src => node["vpcnat"][:ipmasq_src]
  })
end

