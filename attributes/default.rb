#
# Cookbook Name:: osmpolygons
# Attributes:: setup
#

default[:osmpolygons][:setup][:fences][:version]   = '0.1.0'

default[:osmpolygons][:setup][:basedir]            = '/mnt/poly'
default[:osmpolygons][:setup][:logdir]             = "#{node[:osmpolygons][:setup][:basedir]}/logs"
default[:osmpolygons][:setup][:datadir]            = "#{node[:osmpolygons][:setup][:basedir]}/data"
default[:osmpolygons][:setup][:cfgdir]             = "#{node[:osmpolygons][:setup][:basedir]}/etc"
default[:osmpolygons][:setup][:bindir]             = "#{node[:osmpolygons][:setup][:basedir]}/bin"
default[:osmpolygons][:setup][:tempdir]            = "#{node[:osmpolygons][:setup][:basedir]}/temp"
default[:osmpolygons][:setup][:base_outputdir]     = "#{node[:osmpolygons][:setup][:basedir]}/output"
default[:osmpolygons][:setup][:outputdir][:planet] = "#{node[:osmpolygons][:setup][:base_outputdir]}/planet"
default[:osmpolygons][:setup][:outputdir][:slices] = "#{node[:osmpolygons][:setup][:base_outputdir]}/slices"
