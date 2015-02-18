#
# Cookbook Name:: osmpolygons
# Attributes:: default
#

# setup
default[:osmpolygons][:setup][:basedir]     = '/mnt/poly'
default[:osmpolygons][:setup][:outputdir]   = "#{node[:osmpolygons][:setup][:basedir]}/output"
default[:osmpolygons][:setup][:cfgdir]      = "#{node[:osmpolygons][:setup][:basedir]}/etc"
default[:osmpolygons][:setup][:repo]        = 'https://github.com/pelias/openstreetmap-polygons.git'
default[:osmpolygons][:setup][:revision]    = 'master'

# user
default[:osmpolygons][:user][:id]           = 'poly'
default[:osmpolygons][:user][:shell]        = '/bin/bash'
default[:osmpolygons][:user][:manage_home]  = false
default[:osmpolygons][:user][:create_group] = true
default[:osmpolygons][:user][:ssh_keygen]   = false

# extracts
default[:osmpolygons][:extracts][:array]     = %w(
  https://s3.amazonaws.com/metro-extracts.mapzen.com/naples_italy.osm.pbf
  https://s3.amazonaws.com/metro-extracts.mapzen.com/philadelphia_pennsylvania.osm.pbf
)
default[:osmpolygons][:extracts][:timeout]   = 7_200 # 2 hours
