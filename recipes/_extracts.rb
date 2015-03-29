#
# Cookbook Name:: osmpolygons
# Recipe:: extracts
#

# generate configs for planet and any extracts
filename = node[:osmpolygons][:planet][:url].split('/').last
template "#{node[:osmpolygons][:setup][:cfgdir]}/planet_config.json" do
  user   node[:osmpolygons][:user][:id]
  source 'planet_config.json.erb'
  variables(
    outputdir: node[:osmpolygons][:setup][:outputdir][:planet],
    inputfile: "#{node[:osmpolygons][:setup][:datadir]}/#{filename}"
  )
end

node[:osmpolygons][:extracts][:hash].map do |name, bbox|
  template "#{node[:osmpolygons][:setup][:cfgdir]}/#{name}_config.json" do
    user   node[:osmpolygons][:user][:id]
    source 'extracts_config.json.erb'
    variables(
      inputdir: node[:osmpolygons][:setup][:outputdir][:planet],
      outputdir: node[:osmpolygons][:setup][:outputdir][:extracts],
      name: name,
      box: bbox
    )
  end
end

include_recipe 'osmpolygons::_download'

# create extracts if the planet is new, or
# force extract creation regardless of whether the planet is new,
# if that option is set.
node[:osmpolygons][:extracts][:force][:planet] ? planet_action = :run : planet_action = :nothing
execute 'create planet extracts' do
  action      planet_action
  cwd         "#{node[:osmpolygons][:setup][:basedir]}/fences-builder"
  user        node[:osmpolygons][:user][:id]
  timeout     node[:osmpolygons][:extracts][:timeout]
  subscribes  :run, 'execute[download planet]', :immediately
  command <<-EOH
    node app.js \
      --max-old-space-size=10000 \
      >#{node[:osmpolygons][:setup][:logdir]}/planet_extract.log \
      2>#{node[:osmpolygons][:setup][:logdir]}/planet_extract.err
  EOH
  environment('PELIAS_CONFIG' => "#{node[:osmpolygons][:setup][:cfgdir]}/planet_config.json")
end

# generate configs for each extract in our hash
node[:osmpolygons][:extracts][:force][:slices] ? slice_action = :run : slice_action = :nothing
node[:osmpolygons][:extracts][:hash].map do |name, bbox|
  execute "create extracts for #{name}" do
    action      slice_action
    cwd         "#{node[:osmpolygons][:setup][:basedir]}/fences-slicer"
    user        node[:osmpolygons][:user][:id]
    timeout     node[:osmpolygons][:extracts][:timeout]
    subscribes  :run, 'execute[download planet]', :immediately
    command <<-EOH
      node app.js \
        --max-old-space-size=10000 \
        >#{node[:osmpolygons][:setup][:logdir]}/#{name}_extract.log \
        2>#{node[:osmpolygons][:setup][:logdir]}/#{name}_extract.err
    EOH
    environment('PELIAS_CONFIG' => "#{node[:osmpolygons][:setup][:cfgdir]}/#{name}_config.json")
  end
end
