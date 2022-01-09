#
# Cookbook:: blog
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

apt_update 'Update the Package manager cache daily' do
    frequency 86400
    action :periodic
end

include_recipe '::apache'
include_recipe '::php'
include_recipe '::mysql'
include_recipe '::wordpress'