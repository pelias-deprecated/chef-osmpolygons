#
# Cookbook Name:: osmpolygons
# Recipe:: _extract_slices
#
# Region slices will only be created if node[:osmpolygons][:extract][:force][:slice] = true
#   This attribute defaults to false, so you'll need to override it appropriately.
#

require 'json'

# create geojson from admin2
execute 'create region geojson' do
  user    node[:osmpolygons][:user][:id]
  timeout node[:osmpolygons][:extract][:slices][:timeout]
  command <<-EOH
    fences regions \
      #{node[:osmpolygons][:setup][:outputdir][:planet]}/admin_level_2.geojson \
      #{node[:osmpolygons][:setup][:outputdir][:planet]}/regions.geojson
  EOH
  only_if { node[:osmpolygons][:extract][:force][:slice] == true }
end

# because the configuration of the geojson and the slice script are both driven off the existence
#   of a file that doesn't exist at the beginning of the chef run (or which is out of date when chef
#   goes to evaluate it), we'll create all the configs as part of a ruby block.
#
ruby_block 'build region configs' do
  block do
    require 'json'

    def sanitize(input)
      input.gsub(/[^0-9A-z.\-]/, '_').downcase
    end

    slice_script = "#{node[:osmpolygons][:setup][:bindir]}/slice.sh"

    # clean out the old script
    File.truncate(slice_script, 0) if File.exist?(slice_script)

    data = JSON.parse(File.read("#{node[:osmpolygons][:setup][:outputdir][:planet]}/regions.geojson"))
    data['features'].each do |feature|
      feature_json    = feature.to_json
      sanitized_name  = sanitize(feature['properties']['name'])

      File.open("#{node[:osmpolygons][:setup][:cfgdir]}/#{sanitized_name}.geojson", 'w') do |file|
        file.write("{\"type\":\"FeatureCollection\",\"features\":[#{feature_json}]}")
      end

      File.open("#{node[:osmpolygons][:setup][:bindir]}/slice.sh", 'a', 0755) do |file|
        file.write("
          fences slice #{node[:osmpolygons][:setup][:cfgdir]}/#{sanitized_name}.geojson \
            #{node[:osmpolygons][:setup][:outputdir][:planet]} \
            #{node[:osmpolygons][:setup][:outputdir][:slices]} >\
            #{node[:osmpolygons][:setup][:logdir]}/slice_#{sanitized_name}.log 2>&1;
        ")
      end
    end
  end

  only_if { node[:osmpolygons][:extract][:force][:slice] == true }
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
