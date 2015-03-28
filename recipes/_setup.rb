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

directory node[:osmpolygons][:setup][:basedir] do
  user      node[:osmpolygons][:user][:id]
  mode      0755
  recursive true
end

directory node[:osmpolygons][:setup][:logdir] do
  user      node[:osmpolygons][:user][:id]
  mode      0755
  recursive true
end

directory node[:osmpolygons][:setup][:datadir] do
  user      node[:osmpolygons][:user][:id]
  mode      0755
  recursive true
end

directory node[:osmpolygons][:setup][:outputdir] do
  user      node[:osmpolygons][:user][:id]
  mode      0755
  recursive true
end

directory node[:osmpolygons][:setup][:cfgdir] do
  user      node[:osmpolygons][:user][:id]
  mode      0755
  recursive true
end
