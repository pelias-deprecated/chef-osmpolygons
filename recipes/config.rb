#
# Cookbook Name:: osmpolygons
# Recipe:: config
#

node[:osmpolygons][:extracts][:array].each do |a|
  cfg = a.split('/').last.split('.').first
  template "#{node[:osmpolygons][:extracts][:configdir]}/config_#{cfg}.json" do
    source 'config.json.erb'
    variables(
      outputdir: node[:osmpolygons][:setup][:outputdir],
      inputfile: a
    )
  end
end  
