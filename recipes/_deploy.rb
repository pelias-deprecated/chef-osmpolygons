#
# Cookbook Name:: osmpolygons
# Recipe:: _deploy
#

deploy "#{node[:osmpolygons][:setup][:basedir]}/fences-cli" do
  user        node[:osmpolygons][:user][:name]
  repository  node[:osmpolygons][:fences_cli][:repository]
  revision    node[:osmpolygons][:fences_cli][:revision]
  migrate     false

  symlink_before_migrate.clear
  create_dirs_before_symlink %w(tmp public config deploy)

  notifies :run, 'execute[npm install fences-cli]', :immediately
end

execute 'npm install fences-cli' do
  action  :nothing
  user    node[:osmpolygons][:user][:name]
  command 'npm install'
  cwd     "#{node[:osmpolygons][:setup][:basedir]}/fences-cli/current"
  environment('HOME' => node[:osmpolygons][:user][:home])
end
