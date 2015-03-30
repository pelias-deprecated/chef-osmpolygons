#
# Cookbook Name:: osmpolygons
# Recipe:: _extract_slices
#

require 'json'

# if the json override file exists, read it and use that data
if File.exist?(node[:osmpolygons][:extracts][:hash_from_file])
  data = JSON.parse(File.read(node[:osmpolygons][:extracts][:hash_from_file]))
  node.set[:osmpolygons][:extracts][:hash] = data
end

def sanitize(input)
  input.gsub(/[^0-9A-z.\-]/, '_')
end

# generate configs for each extract in our hash
node[:osmpolygons][:extracts][:force][:slices] ? slice_action = :run : slice_action = :nothing
node[:osmpolygons][:extracts][:hash].map do |name, bbox|
  sanitized_name = sanitize(name)

  if bbox.is_a? Array
    log "bbox for #{sanitized_name} is type array, continue"
  else
    Chef::Application.fatal!("bbox for #{sanitized_name} is not an array! Aborting...", 1)
  end

  template "#{node[:osmpolygons][:setup][:cfgdir]}/#{sanitized_name}_config.json" do
    user   node[:osmpolygons][:user][:id]
    source 'extracts_config.json.erb'
    variables(
      inputdir: node[:osmpolygons][:setup][:outputdir][:planet],
      outputdir: "#{node[:osmpolygons][:setup][:outputdir][:extracts]}/#{sanitized_name}",
      name: sanitized_name,
      bbox: bbox
    )
  end

  directory "#{node[:osmpolygons][:setup][:outputdir][:extracts]}/#{sanitized_name}" do
    user  node[:osmpolygons][:user][:id]
    mode  0755
  end

  # runs if new planet extract data has been created, or is forced via
  # node[:osmpolygons][:extracts][:force][:slices]
  execute "create extracts for #{sanitized_name}" do
    action      slice_action
    cwd         "#{node[:osmpolygons][:setup][:basedir]}/fences-slicer/current"
    user        node[:osmpolygons][:user][:id]
    timeout     node[:osmpolygons][:extracts][:slices][:timeout]
    subscribes  :run, 'execute[create planet extracts]', :immediately
    command <<-EOH
      node app.js \
        --max-old-space-size=#{node[:osmpolygons][:extracts][:slices][:kb_heap]} \
        >#{node[:osmpolygons][:setup][:logdir]}/#{sanitized_name}_extract.log \
        2>#{node[:osmpolygons][:setup][:logdir]}/#{sanitized_name}_extract.err
    EOH
    environment('PELIAS_CONFIG' => "#{node[:osmpolygons][:setup][:cfgdir]}/#{sanitized_name}_config.json")
  end
end
