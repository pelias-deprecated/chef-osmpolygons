#
# Cookbook Name:: osmpolygons
# Recipe:: _deploy
#

%w(builder slicer).each do |fence|
  deploy "#{node[:osmpolygons][:setup][:basedir]}/fences-#{fence}" do
    user      node[:osmpolygons][:user][:id]
    repo      node[:osmpolygons][:deploy][:"#{fence}_repo"]
    revision  node[:osmpolygons][:deploy][:"#{fence}_revision"]
    migrate   false
    notifies  :run, "execute[npm install #{fence}]", :immediately

    create_dirs_before_symlink %w(tmp public config deploy)
    symlink_before_migrate.clear
  end

  execute "npm install #{fence}" do
    action  :nothing
    user    node[:osmpolygons][:user][:id]
    command 'npm install'
    cwd     "#{node[:osmpolygons][:setup][:basedir]}/fences-#{fence}/current"
    environment('HOME' => "#{node[:osmpolygons][:setup][:basedir]}/fences-#{fence}/current")
  end
end
