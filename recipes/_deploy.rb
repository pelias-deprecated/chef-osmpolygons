#
# Cookbook Name:: osmpolygons
# Recipe:: _deploy
#

deploy "#{node[:osmpolygons][:setup][:basedir]}/fences-builder" do
  user      node[:osmpolygons][:user][:id]
  repo      node[:osmpolygons][:deploy][:builder_repo]
  revision  node[:osmpolygons][:deploy][:builder_revision]
  migrate   false
  notifies  :run, 'execute[npm install builder]', :immediately

  create_dirs_before_symlink %w(tmp public config deploy)
  symlink_before_migrate.clear
end
execute 'npm install builder' do
  action  :nothing
  user    node[:osmpolygons][:user][:id]
  command 'npm install'
  cwd     "#{node[:osmpolygons][:setup][:basedir]}/fences-builder/current"
  environment('HOME' => "#{node[:osmpolygons][:setup][:basedir]}/fences-builder/current")
end

deploy "#{node[:osmpolygons][:setup][:basedir]}/fences-slicer" do
  user      node[:osmpolygons][:user][:id]
  repo      node[:osmpolygons][:deploy][:slicer_repo]
  revision  node[:osmpolygons][:deploy][:slicer_revision]
  migrate   false
  notifies  :run, 'execute[npm install slicer]', :immediately

  create_dirs_before_symlink %w(tmp public config deploy)
  symlink_before_migrate.clear
end
execute 'npm install slicer' do
  action  :nothing
  user    node[:osmpolygons][:user][:id]
  command 'npm install'
  cwd     "#{node[:osmpolygons][:setup][:basedir]}/fences-slicer/current"
  environment('HOME' => "#{node[:osmpolygons][:setup][:basedir]}/fences-slicer/current")
end
