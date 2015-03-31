#
# Cookbook Name:: osmpolygons
# Recipe:: _extract_planet
#

include_recipe 'osmpolygons::_download'

filename = node[:osmpolygons][:planet][:url].split('/').last

# prep filtered planet data
node[:osmpolygons][:extracts][:force][:prep] ? prep_action = :run : prep_action = :nothing
execute 'prep planet' do
  action  prep_action
  user    node[:osmpolygons][:user][:id]
  # cwd     node[:osmpolygons][:setup][:tempdir]
  cwd     '/tmp/fences-cli'
  timeout node[:osmpolygons][:extracts][:prep][:timeout]
  command <<-EOH
    ./bin/fences prep -t \
      #{node[:osmpolygons][:setup][:tempdir]} \
      #{node[:osmpolygons][:setup][:datadir]}/#{filename} \
      #{node[:osmpolygons][:setup][:datadir]}/planet-filtered.pbf >\
      #{node[:osmpolygons][:setup][:logdir]}/prep.log 2>&1
  EOH
end

# build planet boundary data
node[:osmpolygons][:extracts][:force][:build] ? build_action = :run : build_action = :nothing
execute 'build planet' do
  action  build_action
  user    node[:osmpolygons][:user][:id]
  # cwd     node[:osmpolygons][:setup][:tempdir]
  cwd     '/tmp/fences-cli'
  timeout node[:osmpolygons][:extracts][:build][:timeout]
  command <<-EOH
    ./bin/fences build #{node[:osmpolygons][:setup][:datadir]}/planet-filtered.pbf \
      #{node[:osmpolygons][:setup][:outputdir][:planet]} >\
      #{node[:osmpolygons][:setup][:logdir]}/build.log 2>&1
  EOH
  environment('HOME' => node[:osmpolygons][:user][:home])
end

# cut region slices if the file exists
node[:osmpolygons][:extracts][:force][:slices] ? slice_action = :run : slice_action = :nothing
execute 'slice regions' do
  action  slice_action
  user    node[:osmpolygons][:user][:id]
  # cwd     node[:osmpolygons][:setup][:tempdir]
  cwd     '/tmp/fences-cli'
  timeout node[:osmpolygons][:extracts][:slices][:timeout]
  command <<-EOH
    ./bin/fences slice #{node[:osmpolygons][:extracts][:slices][:file]} \
      #{node[:osmpolygons][:setup][:outputdir][:planet]} \
      #{node[:osmpolygons][:setup][:outputdir][:slices]} >\
      #{node[:osmpolygons][:setup][:logdir]}/slice.log 2>&1
  EOH
  only_if { ::File.exist?(node[:osmpolygons][:extracts][:slices][:file]) }
end
