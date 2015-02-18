#
# Cookbook Name:: osmpolygons
# Recipe:: setup
#

# packages for 12.04 and 14.04
#
%w(
  git
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

# clone
#
git "#{node[:osmpolygons][:setup][:basedir]}/openstreetmap-polygons" do
  action      :sync
  repository  node[:osmpolygons][:setup][:repo]
  revision    node[:osmpolygons][:setup][:revision]
  user        node[:osmpolygons][:user][:id]
  notifies    :run, 'execute[npm install]', :immediately
end

execute 'npm install' do
  action  :nothing
  user    node[:osmpolygons][:user][:id]
  command 'npm install'
  cwd     "#{node[:osmpolygons][:setup][:basedir]}/openstreetmap-polygons"
  environment('HOME' => "#{node[:osmpolygons][:setup][:basedir]}/openstreetmap-polygons")
end
