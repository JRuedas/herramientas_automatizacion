#
# Cookbook:: blog
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

include_recipe '::apache'
include_recipe '::php'
include_recipe '::mysql'
include_recipe '::wordpress'