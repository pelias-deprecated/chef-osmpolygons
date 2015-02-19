#
# Cookbook Name:: osmpolygons
# Recipe:: extracts
#

include_recipe 'osmpolygons::_download'

# generate configs
node[:osmpolygons][:extracts][:array].each do |extract|
  cfg      = extract.split('/').last.split('.').first
  filename = extract.split('/').last

  template "#{node[:osmpolygons][:setup][:cfgdir]}/config_#{cfg}.json" do
    action      :nothing
    user        node[:osmpolygons][:user][:id]
    source      'config.json.erb'
    subscribes  :create, "execute[download #{extract}]", :immediately
    variables(
      outputdir: node[:osmpolygons][:setup][:outputdir],
      inputfile: "#{node[:osmpolygons][:setup][:datadir]}/#{filename}"
    )
  end

  execute "create extracts from config_#{cfg}.json" do
    action      :nothing
    cwd         "#{node[:osmpolygons][:setup][:basedir]}/openstreetmap-polygons"
    user        node[:osmpolygons][:user][:id]
    command     "node app.js >#{node[:osmpolygons][:setup][:basedir]}/logs/#{cfg}.log 2>#{node[:osmpolygons][:setup][:basedir]}/logs/#{cfg}.err"
    timeout     node[:osmpolygons][:extracts][:timeout]
    subscribes  :run, "execute[download #{extract}]", :immediately
    environment('PELIAS_CONFIG' => "#{node[:osmpolygons][:setup][:cfgdir]}/config_#{cfg}.json")
  end

  # force extract creation
  execute "force create extracts from config_#{cfg}.json" do
    cwd     "#{node[:osmpolygons][:setup][:basedir]}/openstreetmap-polygons"
    user    node[:osmpolygons][:user][:id]
    command "node app.js >#{node[:osmpolygons][:setup][:basedir]}/logs/#{cfg}.log 2>#{node[:osmpolygons][:setup][:basedir]}/logs/#{cfg}.err"
    timeout node[:osmpolygons][:extracts][:timeout]
    only_if { node[:osmpolygons][:extracts][:force] == true }
    environment('PELIAS_CONFIG' => "#{node[:osmpolygons][:setup][:cfgdir]}/config_#{cfg}.json")
  end
end
