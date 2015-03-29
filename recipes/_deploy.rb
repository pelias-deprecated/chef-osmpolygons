#
# Cookbook Name:: osmpolygons
# Recipe:: _deploy
#

git "#{node[:osmpolygons][:setup][:basedir]}/fences-builder" do
  action      :sync
  repository  node[:osmpolygons][:deploy][:builder_repo]
  revision    node[:osmpolygons][:deploy][:builder_revision]
  user        node[:osmpolygons][:user][:id]
  notifies    :run, 'execute[npm install builder]', :immediately
end
execute 'npm install builder' do
  action  :nothing
  user    node[:osmpolygons][:user][:id]
  command 'npm install'
  cwd     "#{node[:osmpolygons][:setup][:basedir]}/fences-builder"
  environment('HOME' => "#{node[:osmpolygons][:setup][:basedir]}/fences-builder")
end

git "#{node[:osmpolygons][:setup][:basedir]}/fences-slicer" do
  action      :sync
  repository  node[:osmpolygons][:deploy][:slicer_repo]
  revision    node[:osmpolygons][:deploy][:slicer_revision]
  user        node[:osmpolygons][:user][:id]
  notifies    :run, 'execute[npm install slicer]', :immediately
end
execute 'npm install slicer' do
  action  :nothing
  user    node[:osmpolygons][:user][:id]
  command 'npm install'
  cwd     "#{node[:osmpolygons][:setup][:basedir]}/fences-slicer"
  environment('HOME' => "#{node[:osmpolygons][:setup][:basedir]}/fences-slicer")
end
