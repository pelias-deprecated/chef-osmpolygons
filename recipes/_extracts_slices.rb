#
# Cookbook Name:: osmpolygons
# Recipe:: _extract_slices
#

require 'json'

def sanitize(input)
  input.gsub(/[^0-9A-z.\-]/, '_')
end

# if attribute hash is empty and the json override file exists, read it and use that data
if node[:osmpolygons][:extracts][:slices][:hash].emtpy? && File.exist?(node[:osmpolygons][:extracts][:slices][:file])
  data = JSON.parse(File.read(node[:osmpolygons][:extracts][:slices][:file]))
  node.set[:osmpolygons][:extracts][:slices][:hash] = data
end

# build extracts after doing some validation of the data. These would
#   fail when anyway when it came time to process them, but it seems like
#   a nice addition to be able to pinpoint where the failure would occur
#   ahead of time.
node[:osmpolygons][:extracts][:force][:slices] ? slice_action = :run : slice_action = :nothing
node[:osmpolygons][:extracts][:slices][:hash].map do |name, bbox|
  sanitized_name = sanitize(name)

  # is the bbox an array?
  if bbox.is_a? Array
    log "passed: bbox for #{sanitized_name} is type array"
    # if so, does it have 4 elements?
    if bbox.count == 4
      # if so, is it a valid bounding box?
      log "passed: bbox for #{sanitized_name} has four elements"

      left    = bbox[0].to_f
      bottom  = bbox[1].to_f
      right   = bbox[2].to_f
      top     = bbox[3].to_f

      if left >= right
        Chef::Application.fatal!("left coordinate (#{left}) is >= right coordinate (#{right}) for bbox #{sanitized_name}! Aborting...", 1)
      elsif bottom >= top
        Chef::Application.fatal!("bottom coordinate (#{bottom}) is >= top coordinate (#{top}) for bbox #{sanitized_name}! Aborting...", 1)
      else
        log "passed: bbox for #{sanitized_name} is valid"
      end
    else
      Chef::Application.fatal!("bbox for #{sanitized_name} does not have four elements! Aborting...", 1)
    end
  else
    Chef::Application.fatal!("bbox for #{sanitized_name} is not an array! Aborting...", 1)
  end

  template "#{node[:osmpolygons][:setup][:cfgdir]}/#{sanitized_name}_config.json" do
    user   node[:osmpolygons][:user][:id]
    source 'extracts_config.json.erb'
    variables(
      name: sanitized_name,
      bbox: bbox
    )
  end

  directory "#{node[:osmpolygons][:setup][:outputdir][:slices]}/#{sanitized_name}" do
    user  node[:osmpolygons][:user][:id]
    mode  0755
  end

  execute "slice regions for #{sanitized_name}" do
    action      slice_action
    user        node[:osmpolygons][:user][:id]
    cwd         "#{node[:osmpolygons][:setup][:basedir]}/fences-cli/current"
    timeout     node[:osmpolygons][:extracts][:slices][:timeout]
    subscribes  :run, 'execute[build planet]', :immediately
    command <<-EOH
      ./bin/fences slice #{node[:osmpolygons][:setup][:cfgdir]}/#{sanitized_name}_config.json \
        #{node[:osmpolygons][:setup][:outputdir][:planet]} \
        #{node[:osmpolygons][:setup][:outputdir][:slices]}/#{sanitized_name} >\
        #{node[:osmpolygons][:setup][:logdir]}/slice.log 2>&1
    EOH
  end
end
