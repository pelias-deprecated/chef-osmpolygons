#
# Cookbook Name:: osmpolygons
# Attributes:: default
#

# nodejs
default[:nodejs][:version]                  = '0.10.36'
default[:nodejs][:install_method]           = 'binary'
default[:nodejs][:checksum_linux_x64]       = '2bc13477684a9fe534bdc9d8f4a8caf6257a11953b57c42cad9b919ee259a0d5'

# setup
default[:osmpolygons][:setup][:basedir]     = '/mnt/poly'
default[:osmpolygons][:setup][:logdir]      = "#{node[:osmpolygons][:setup][:basedir]}/logs"
default[:osmpolygons][:setup][:cfgdir]      = "#{node[:osmpolygons][:setup][:basedir]}/etc"
default[:osmpolygons][:setup][:datadir]     = "#{node[:osmpolygons][:setup][:basedir]}/data"
default[:osmpolygons][:setup][:outputdir]   = "#{node[:osmpolygons][:setup][:basedir]}/output"

# deploy
default[:osmpolygons][:deploy][:repo]       = 'https://github.com/pelias/fences-builder.git'
default[:osmpolygons][:deploy][:revision]   = 'master'

# user
default[:osmpolygons][:user][:id]           = 'poly'
default[:osmpolygons][:user][:uid]          = 2002
default[:osmpolygons][:user][:shell]        = '/bin/bash'
default[:osmpolygons][:user][:manage_home]  = false
default[:osmpolygons][:user][:create_group] = true
default[:osmpolygons][:user][:ssh_keygen]   = false

# extracts
default[:osmpolygons][:extracts][:force]    = false
default[:osmpolygons][:extracts][:timeout]  = 43_200 # 12 hours

# planet
#   NOTE: must support an accompanying .md5
#   at the same location, e.g. planet-latest.osm.pbf.md5
default[:osmpolygons][:planet][:url]        = 'http://planet.us-east-1.mapzen.com/planet-latest.osm.pbf'
