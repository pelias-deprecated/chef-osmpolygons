#
# Cookbook Name:: osmpolygons
# Recipe:: extracts
#

# generate configs
node[:osmpolygons][:extracts][:array].each do |extract|
  cfg = extract.split('/').last.split('.').first
  template "#{node[:osmpolygons][:setup][:cfgdir]}/config_#{cfg}.json" do
    user      node[:osmpolygons][:user][:id]
    source    'config.json.erb'
    notifies  :run, "execute[create extracts from config_#{cfg}.json]", :delayed
    variables(
      outputdir: node[:osmpolygons][:setup][:outputdir],
      inputfile: extract
    )
  end

  execute "create extracts from config_#{cfg}.json" do
    action  :nothing
    cwd     "#{node[:osmpolygons][:setup][:basedir]}/openstreetmap-polygons"
    user    node[:osmpolygons][:user][:id]
    command 'node app.js'
    environment('PELIAS_CONFIG' => "#{node[:osmpolygons][:setup][:cfgdir]}/config_#{cfg}.json")
  end
end
