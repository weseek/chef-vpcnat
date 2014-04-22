vpcnat Cookbook
=============

This cookbook configures your AWS instances to enable NAT and installs heartbeat script to monitor NAT instances each other.




Requirements
------------

* Chef (11.10 or higher)
* Berkshelf
* jq - JSON processor


AWS Credentials
===============

In order to manage AWS components, authentication credentials need to
be available to the node. There are 2 way to handle this:

1. explicitly pass credentials parameter to the resource
1. or let the resource pick up credentials from the IAM role assigned to the instance


(see : http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-installing-credentials)


Recipes
========

vpcnat::default
---------------

- execute all of recipes below.

### Attributes

needs all of recipe's attributes.


vpcnat::disable-source-dest-check
----------------------------------

- disable Source/dest. check.


### Attributes

nothing.

vpcnat::setup-ip-masquerading
-----------------------------

- set '1' to ``net.ipv4.ip_forward`` using sysctl
- configure iptables and enable IP Masquerading


### Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Example</th>
  </tr>
  <tr>
    <td><tt>["vpcnat"]["ipmasq_src"]</tt></td>
    <td>String</td>
    <td>IP Masquerading Source which will be allowed by iptables</td>
    <td><tt>10.0.0.0/16</tt></td>
  </tr>
</table>

vpcnat::setup-heartbeat-script
------------------------------

- install heartbeat script

### Attributes

- '*subject instance*' means the instance that set up by this cookbook.
- '*opposite instance*' means the NAT instance to monitor heartbeat by *subject instance*.
- '*azname*' means name of availability zone like 'us-east-1a'.
  These attributes are applied only when *subject instance* is belongs to this AZ.

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Example</th>
  </tr>
  <tr>
    <td><tt>['vpcnat']['az'][<i>azname</i>]['enabled']</tt></td>
    <td>Boolean (0/1)</td>
    <td>whether to enable running heartbeat script</td>
    <td><tt>1</tt></td>
  </tr>
  <tr>
    <td><tt>['vpcnat']['az'][<i>azname</i>]['opposite_primary_nat_id']</tt></td>
    <td>String</td>
    <td>the ID of <i>opposite instance</i></td>
    <td>i-1234abcd</td>
  </tr>
  <tr>
    <td><tt>['vpcnat']['az'][<i>azname</i>]['opposite_rtb']</tt></td>
    <td>String</td>
    <td>the ID of the route table handled by <i>opposite instance</i></td>
    <td>rtb-1234abcd</td>
  </tr>
  <tr>
    <td><tt>['vpcnat']['az'][<i>azname</i>]['target_via_checking_nat']</tt></td>
    <td>String</td>
    <td>target ip which is used for monitoring heartbeat.</td>
    <td><tt>8.8.8.8</tt></td>
  </tr>
  <tr>
    <td><tt>['vpcnat']['az'][<i>azname</i>]['target_via_inetgw']</tt></td>
    <td>String</td>
    <td>target address which is used for testing the internet connection.</td>
    <td><tt>google.co.jp</tt></td>
  </tr>
</table>



Usage
-----

Just include `vpcnat` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[vpcnat]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
1. Write your change (and fix my poor English!)
1. Submit a Pull Request using Github


License and Authors
-------------------
- Author:: Yuki Takei (<yuki@weseek.co.jp>)

Copyright 2014 WESEEK, Inc.

Licensed under the Apache License, Version 2.0 (the "License");  
you may not use this file except in compliance with the License.  
You may obtain a copy of the License at  

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software  
distributed under the License is distributed on an "AS IS" BASIS,  
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  
See the License for the specific language governing permissions and  
limitations under the License.  

