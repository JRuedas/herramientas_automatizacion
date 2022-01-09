# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile/

# A name that describes what the system you're building with Chef does.
name 'Chef Wordpress test'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'blog::default'

# Specify a custom source for a single cookbook:
# cookbook 'example_cookbook', path: '../cookbooks/example_cookbook'
cookbook 'blog', path: '.'
cookbook 'apache2', '~> 8.14.1', :supermarket
cookbook 'php', '~> 9.1.0', :supermarket
cookbook 'mysql', '~> 11.0.1', :supermarket
cookbook 'yum-mysql-community', '~> 5.2.0', :supermarket