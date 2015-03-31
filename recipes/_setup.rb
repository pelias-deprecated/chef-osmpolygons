#
# Cookbook Name:: osmpolygons
# Recipe:: _setup
#

include_recipe 'apt::default'
include_recipe 'nodejs::default'

# nodejs_npm 'fences-cli' do
#  version node[:osmpolygons][:setup][:fences_cli][:version]
# end

%w(
  git
  zlib1g-dev
  build-essential
).each do |p|
  package p
end

[
  node[:osmpolygons][:setup][:basedir],
  node[:osmpolygons][:setup][:logdir],
  node[:osmpolygons][:setup][:datadir],
  node[:osmpolygons][:setup][:tempdir],
  node[:osmpolygons][:setup][:outputdir][:planet],
  node[:osmpolygons][:setup][:outputdir][:slices]
].each do |dir|
  directory dir do
    user      node[:osmpolygons][:user][:id]
    mode      0755
    recursive true
  end
end

include_recipe 'osmpolygons::_deploy'
