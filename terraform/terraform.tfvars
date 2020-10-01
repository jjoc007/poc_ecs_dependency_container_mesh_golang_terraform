# Application Definition
app_name = "poc_ms_test_go" # Do NOT enter any spaces
app_environment = "test" # Dev, Test, Prod, etc

aws_region = "us-east-2"
# Application access
app_sources_cidr = ["0.0.0.0/0"] # Specify a list of IPv4 IPs/CIDRs which can access app load balancers
admin_sources_cidr = ["0.0.0.0/0"] # Specify a list of IPv4 IPs/CIDRs which can admin instances