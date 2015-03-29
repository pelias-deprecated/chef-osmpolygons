#
# Cookbook Name:: osmpolygons
# Recipe:: _extract_slices
#

# generate configs for each extract in our hash
node[:osmpolygons][:extracts][:force][:slices] ? slice_action = :run : slice_action = :nothing
node[:osmpolygons][:extracts][:slices].map do |name, bbox|
  template "#{node[:osmpolygons][:setup][:cfgdir]}/#{name}_config.json" do
    user   node[:osmpolygons][:user][:id]
    source 'extracts_config.json.erb'
    variables(
      inputdir: node[:osmpolygons][:setup][:outputdir][:planet],
      outputdir: "#{node[:osmpolygons][:setup][:outputdir][:extracts]}/#{name}",
      name: name,
      box: bbox
    )
  end

  directory "#{node[:osmpolygons][:setup][:outputdir][:extracts]}/#{name}" do
    user  node[:osmpolygons][:user][:id]
    mode  0755
  end

  # runs if new planet extract data has been created, or is forced via
  # node[:osmpolygons][:extracts][:force][:slices]
  execute "create extracts for #{name}" do
    action      slice_action
    cwd         "#{node[:osmpolygons][:setup][:basedir]}/fences-slicer/current"
    user        node[:osmpolygons][:user][:id]
    timeout     node[:osmpolygons][:extracts][:slices][:timeout]
    subscribes  :run, 'execute[create planet extracts]', :immediately
    command <<-EOH
      node app.js \
        --max-old-space-size=10000 \
        >#{node[:osmpolygons][:setup][:logdir]}/#{name}_extract.log \
        2>#{node[:osmpolygons][:setup][:logdir]}/#{name}_extract.err
    EOH
    environment('PELIAS_CONFIG' => "#{node[:osmpolygons][:setup][:cfgdir]}/#{name}_config.json")
  end
end
