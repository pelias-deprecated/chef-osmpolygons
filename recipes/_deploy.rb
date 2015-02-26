#
# Cookbook Name:: osmpolygons
# Recipe:: deploy
#

git "#{node[:osmpolygons][:setup][:basedir]}/openstreetmap-polygons" do
  action      :sync
  repository  node[:osmpolygons][:deploy][:repo]
  revision    node[:osmpolygons][:deploy][:revision]
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
