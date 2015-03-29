#
# Cookbook Name:: osmpolygons
# Attributes:: default
#

# nodejs
default[:nodejs][:version]                               = '0.12.1'
default[:nodejs][:install_method]                        = 'binary'
default[:nodejs][:checksum_linux_x64]                    = '270d478d0ffb06063f01eab932f672b788f6ecf3c117075ac8b87c0c17e0c9de'

# setup
default[:osmpolygons][:setup][:basedir]                  = '/mnt/poly'
default[:osmpolygons][:setup][:logdir]                   = "#{node[:osmpolygons][:setup][:basedir]}/logs"
default[:osmpolygons][:setup][:cfgdir]                   = "#{node[:osmpolygons][:setup][:basedir]}/etc"
default[:osmpolygons][:setup][:datadir]                  = "#{node[:osmpolygons][:setup][:basedir]}/data"
default[:osmpolygons][:setup][:outputdir][:planet]       = "#{node[:osmpolygons][:setup][:basedir]}/output/planet"
default[:osmpolygons][:setup][:outputdir][:extracts]     = "#{node[:osmpolygons][:setup][:basedir]}/output/extracts"

# deploy
default[:osmpolygons][:deploy][:builder_repo]            = 'https://github.com/pelias/fences-builder.git'
default[:osmpolygons][:deploy][:builder_revision]        = 'master'
default[:osmpolygons][:deploy][:slicer_repo]             = 'https://github.com/pelias/fences-slicer.git'
default[:osmpolygons][:deploy][:slicer_revision]         = 'master'

# user
default[:osmpolygons][:user][:id]                        = 'poly'
default[:osmpolygons][:user][:uid]                       = 2002
default[:osmpolygons][:user][:shell]                     = '/bin/bash'
default[:osmpolygons][:user][:manage_home]               = false
default[:osmpolygons][:user][:create_group]              = true
default[:osmpolygons][:user][:ssh_keygen]                = false

# extracts
default[:osmpolygons][:extracts][:force][:planet]        = false
default[:osmpolygons][:extracts][:force][:slices]        = false
default[:osmpolygons][:extracts][:planet][:timeout]      = 43_200 # 12 hours
default[:osmpolygons][:extracts][:slices][:timeout]      = 7_200  # 2 hours
default[:osmpolygons][:extracts][:slices]                = {}

# planet
#   NOTE: must support an accompanying .md5
#   at the same location, e.g. planet-latest.osm.pbf.md5
default[:osmpolygons][:planet][:download_timeout]        = 7_200 # two hours
default[:osmpolygons][:planet][:url]                     = 'http://planet.us-east-1.mapzen.com/planet-latest.osm.pbf'
