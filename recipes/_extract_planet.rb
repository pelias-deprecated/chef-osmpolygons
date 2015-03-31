#
# Cookbook Name:: osmpolygons
# Recipe:: _extract_planet
#

include_recipe 'osmpolygons::_download'

filename = node[:osmpolygons][:planet][:url].split('/').last

# prep filtered planet data
node[:osmpolygons][:extract][:force][:prep] ? prep_action = :run : prep_action = :nothing
execute 'prep planet' do
  action  prep_action
  user    node[:osmpolygons][:user][:id]
  cwd     "#{node[:osmpolygons][:setup][:basedir]}/fences-cli/current"
  timeout node[:osmpolygons][:extract][:prep][:timeout]
  command <<-EOH
    ./bin/fences prep -t \
      #{node[:osmpolygons][:setup][:tempdir]} \
      #{node[:osmpolygons][:setup][:datadir]}/#{filename} \
      #{node[:osmpolygons][:setup][:datadir]}/planet-filtered.pbf >\
      #{node[:osmpolygons][:setup][:logdir]}/prep.log 2>&1
  EOH
end

# build planet boundary data
node[:osmpolygons][:extract][:force][:build] ? build_action = :run : build_action = :nothing
execute 'build planet' do
  action  build_action
  user    node[:osmpolygons][:user][:id]
  cwd     "#{node[:osmpolygons][:setup][:basedir]}/fences-cli/current"
  timeout node[:osmpolygons][:extract][:build][:timeout]
  command <<-EOH
    ./bin/fences build #{node[:osmpolygons][:setup][:datadir]}/planet-filtered.pbf \
      #{node[:osmpolygons][:setup][:outputdir][:planet]} >\
      #{node[:osmpolygons][:setup][:logdir]}/build.log 2>&1
  EOH
  environment('HOME' => node[:osmpolygons][:user][:home])
end
