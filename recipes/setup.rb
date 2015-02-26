#
# Cookbook Name:: osmpolygons
# Recipe:: setup
#

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

directory "#{node[:osmpolygons][:setup][:basedir]}/logs" do
  user      node[:osmpolygons][:user][:id]
  mode      0755
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
