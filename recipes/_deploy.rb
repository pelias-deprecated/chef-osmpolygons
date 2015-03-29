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

deploy "#{node[:osmpolygons][:setup][:basedir]}/fences-slicer" do
  user      node[:osmpolygons][:user][:id]
  repo      node[:osmpolygons][:deploy][:slicer_repo]
  revision  node[:osmpolygons][:deploy][:slicer_revision]
  migrate   false
  notifies  :run, 'execute[npm install slicer]', :immediately

  create_dirs_before_symlink %w(tmp public config deploy)
  symlink_before_migrate.clear
end

%w(builder slicer).each do |fence|
  execute "npm install #{fence}" do
    action  :nothing
    user    node[:osmpolygons][:user][:id]
    command 'npm install'
    cwd     "#{node[:osmpolygons][:setup][:basedir]}/fences-#{fence}/current"
    environment('HOME' => "#{node[:osmpolygons][:setup][:basedir]}/fences-#{fence}/current")
  end
end
