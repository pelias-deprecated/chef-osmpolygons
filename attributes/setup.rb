#
# Cookbook Name:: osmpolygons
# Attributes:: setup
#

default[:osmpolygons][:setup][:basedir]               = '/mnt/poly'
default[:osmpolygons][:setup][:logdir]                = "#{node[:osmpolygons][:setup][:basedir]}/logs"
default[:osmpolygons][:setup][:cfgdir]                = "#{node[:osmpolygons][:setup][:basedir]}/etc"
default[:osmpolygons][:setup][:datadir]               = "#{node[:osmpolygons][:setup][:basedir]}/data"
default[:osmpolygons][:setup][:outputdir][:planet]    = "#{node[:osmpolygons][:setup][:basedir]}/output/planet"
default[:osmpolygons][:setup][:outputdir][:extracts]  = "#{node[:osmpolygons][:setup][:basedir]}/output/extracts"
