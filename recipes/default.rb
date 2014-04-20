#
# Cookbook Name:: vpcnat
# Recipe:: default
#
# Copyright 2014, WESEEK, Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'vpcnat::disable-source-dest-check'
include_recipe 'vpcnat::setup-ip-masquerading'
include_recipe 'vpcnat::setup-heartbeat-script'
