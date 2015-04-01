#
# Cookbook Name:: osmpolygons
# Recipe:: _setup
#

include_recipe 'apt::default'
include_recipe 'nodejs::default'

%w(
  git
  parallel
  osmctools
  build-essential
).each do |p|
  package p
end

[
  node[:osmpolygons][:setup][:basedir],
  node[:osmpolygons][:setup][:logdir],
  node[:osmpolygons][:setup][:cfgdir],
  node[:osmpolygons][:setup][:bindir],
  node[:osmpolygons][:setup][:datadir],
  node[:osmpolygons][:setup][:tempdir],
  node[:osmpolygons][:setup][:base_outputdir],
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
