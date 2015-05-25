#
# Cookbook Name:: osmpolygons
# Recipe:: _extract_slices
#
# Region slices will only be created if node[:osmpolygons][:extract][:force][:slice] = true
#   This attribute defaults to false, so you'll need to override it appropriately.
#

require 'json'

def sanitize(input)
  input.gsub(/[^0-9A-z.\-]/, '_').downcase
end

# file exists?
if File.exist?(node[:osmpolygons][:extract][:slices][:file])
  data = JSON.parse(File.read(node[:osmpolygons][:extract][:slices][:file]))
else
  Chef::Application.fatal!("#{node[:osmpolygons][:extract][:slices][:file]} does not exist. Aborting!", 1)
end

# build extract templates and output directories
data['features'].each do |feature|
  feature_json    = feature.to_json
  sanitized_name  = sanitize(feature['properties']['name:en'])

  template "#{node[:osmpolygons][:setup][:cfgdir]}/#{sanitized_name}.geojson" do
    user    node[:osmpolygons][:user][:id]
    source  'extracts.geojson.erb'
    mode    0755
    variables(geojson: feature_json)
  end
end

template "#{node[:osmpolygons][:setup][:bindir]}/slice.sh" do
  user    node[:osmpolygons][:user][:id]
  source  'slice.sh.erb'
  mode    0755
end

# slice
execute 'slice regions' do
  user    node[:osmpolygons][:user][:id]
  timeout node[:osmpolygons][:extract][:slices][:timeout]
  command <<-EOH
    parallel -j #{node[:osmpolygons][:extract][:slices][:jobs]} \
    -a #{node[:osmpolygons][:setup][:bindir]}/slice.sh \
    -d ';' --joblog #{node[:osmpolygons][:setup][:logdir]}/parallel_slice.log
  EOH
  only_if { node[:osmpolygons][:extract][:force][:slice] == true }
end
