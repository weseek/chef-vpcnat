default["vpcnat"] = {}

default["vpcnat"]["scripts"] = {}
default["vpcnat"]["scripts"]["user"] = "root"
default["vpcnat"]["scripts"]["group"] = "root"
default["vpcnat"]["scripts"]["install_dir"] = "/opt/heartbeat"
default["vpcnat"]["scripts"]["jq"] = "/usr/bin/jq"

if platform?("amazon")
  # pre-installed
  default["vpcnat"]["scripts"]["aws"] = "/usr/bin/aws"
else
  default["vpcnat"]["scripts"]["aws"] = "/usr/local/bin/aws"
end

# default settings
default["vpcnat"]["scripts"]["ipmasq_src"] = "10.0.0.0/16"
default["vpcnat"]["scripts"]["az"] = {}
