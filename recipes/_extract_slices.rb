#
# Cookbook Name:: osmpolygons
# Recipe:: _extract_slices
#
# Region slices will only be created if node[:osmpolygons][:extract][:force][:slice] = true
#   This attribute defaults to false, so you'll need to override it appropriately.
#

require 'json'

def sanitize(input)
  input.gsub(/[^0-9A-z.\-]/, '_')
end

# if attribute hash is empty and the json override file exists, read it and use that data
if node[:osmpolygons][:extract][:slices][:hash].empty? && File.exist?(node[:osmpolygons][:extract][:slices][:file])
  data = JSON.parse(File.read(node[:osmpolygons][:extract][:slices][:file]))
  node.set[:osmpolygons][:extract][:slices][:hash] = data
end

# build extract templates and output directories
node[:osmpolygons][:extract][:slices][:hash].map do |name, bbox|
  sanitized_name = sanitize(name)

  template "#{node[:osmpolygons][:setup][:cfgdir]}/#{sanitized_name}_config.json" do
    user   node[:osmpolygons][:user][:id]
    source 'slice_config.json.erb'
    variables(
      name: sanitized_name,
      bbox: bbox
    )
    only_if { node[:osmpolygons][:extract][:force][:slice] == true }
  end

  directory "#{node[:osmpolygons][:setup][:outputdir][:slices]}/#{sanitized_name}" do
    user    node[:osmpolygons][:user][:id]
    mode    0755
    only_if { node[:osmpolygons][:extract][:force][:slice] == true }
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
  cwd     "#{node[:osmpolygons][:setup][:basedir]}/fences-cli/current"
  timeout node[:osmpolygons][:extract][:slices][:timeout]
  command <<-EOH
    parallel -j #{node[:osmpolygons][:extract][:slices][:jobs]} \
    -a #{node[:osmpolygons][:setup][:bindir]}/slice.sh \
    -d ';' --joblog #{node[:osmpolygons][:setup][:logdir]}/parallel_slice.log
  EOH
  only_if { node[:osmpolygons][:extract][:force][:slice] == true }
end
