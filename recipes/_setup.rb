#
# Cookbook Name:: osmpolygons
# Recipe:: setup
#

include_recipe 'apt::default'
include_recipe 'nodejs::default'

%w(
  git
  gdal-bin
  build-essential
).each do |p|
  package p
end

[
  node[:osmpolygons][:setup][:basedir],
  node[:osmpolygons][:setup][:logdir],
  node[:osmpolygons][:setup][:cfgdir],
  node[:osmpolygons][:setup][:datadir],
  node[:osmpolygons][:setup][:outputdir]
].each do |dir|
  directory dir do
    user      node[:osmpolygons][:user][:id]
    mode      0755
    recursive true
  end
end
