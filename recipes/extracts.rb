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
    user        node[:osmpolygons][:user][:id]
    source      'config.json.erb'
    variables(
      outputdir: node[:osmpolygons][:setup][:outputdir],
      inputfile: "#{node[:osmpolygons][:setup][:datadir]}/#{filename}"
    )
  end

  execute "create extracts from config_#{cfg}.json" do
    action  :nothing
    cwd     "#{node[:osmpolygons][:setup][:basedir]}/openstreetmap-polygons"
    user    node[:osmpolygons][:user][:id]
    command "node app.js >#{node[:osmpolygons][:setup][:basedir]}/logs/#{cfg}.log 2>#{node[:osmpolygons][:setup][:basedir]}/logs/#{cfg}.err"
    timeout node[:osmpolygons][:extracts][:timeout]
    subscribes  :run, "template[#{node[:osmpolygons][:setup][:cfgdir]}/config_#{cfg}.json]", :immediately
    environment('PELIAS_CONFIG' => "#{node[:osmpolygons][:setup][:cfgdir]}/config_#{cfg}.json")
  end
end
