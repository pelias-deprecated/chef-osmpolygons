#
# Cookbook Name:: osmpolygons
# Recipe:: _deploy
#

# TODO: convert this to install from npm when published
#
# nodejs_npm 'fences-cli' do
#   version node[:osmpolygons][:fences_cli][:version]
# end

deploy "#{node[:osmpolygons][:setup][:basedir]}/fences-cli" do
  user        node[:osmpolygons][:user][:id]
  repository  node[:osmpolygons][:fences_cli][:repository]
  revision    node[:osmpolygons][:fences_cli][:revision]
  migrate     false

  symlink_before_migrate.clear
  create_dirs_before_symlink %w(tmp public config deploy)

  notifies :run, 'execute[npm install fences-cli]', :immediately
end

execute 'npm install fences-cli' do
  action  :nothing
  user    node[:osmpolygons][:user][:id]
  command 'npm install'
  cwd     "#{node[:osmpolygons][:setup][:basedir]}/fences-cli/current"
  environment('HOME' => node[:osmpolygons][:user][:home])
end
