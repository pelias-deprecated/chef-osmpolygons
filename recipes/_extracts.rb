#
# Cookbook Name:: osmpolygons
# Recipe:: extracts
#

include_recipe 'osmpolygons::_download'

# generate configs
filename = node[:osmpolygons][:planet][:url].split('/').last

template "#{node[:osmpolygons][:setup][:cfgdir]}/config.json" do
  user        node[:osmpolygons][:user][:id]
  source      'config.json.erb'
  variables(
    outputdir: node[:osmpolygons][:setup][:outputdir],
    inputfile: "#{node[:osmpolygons][:setup][:datadir]}/#{filename}"
  )
end

# create extracts if the planet is new, or
# force extract creation regardless of whether the planet is new,
# if that option is set.
node[:osmpolygons][:extracts][:force] ? run_action = :run : run_action = :nothing
execute 'create extracts' do
  action      run_action
  cwd         "#{node[:osmpolygons][:setup][:basedir]}/openstreetmap-polygons"
  user        node[:osmpolygons][:user][:id]
  command     "node app.js >#{node[:osmpolygons][:setup][:logdir]}/extract.log 2>#{node[:osmpolygons][:setup][:logdir]}/extract.err"
  timeout     node[:osmpolygons][:extracts][:timeout]
  subscribes  :run, 'execute[download planet]', :immediately
  environment('PELIAS_CONFIG' => "#{node[:osmpolygons][:setup][:cfgdir]}/config.json")
end
