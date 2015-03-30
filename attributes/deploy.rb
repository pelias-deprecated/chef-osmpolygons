#
# Cookbook Name:: osmpolygons
# Attributes:: deploy
#

default[:osmpolygons][:deploy][:builder_repo]     = 'https://github.com/pelias/fences-builder.git'
default[:osmpolygons][:deploy][:builder_revision] = 'master'

default[:osmpolygons][:deploy][:slicer_repo]      = 'https://github.com/pelias/fences-slicer.git'
default[:osmpolygons][:deploy][:slicer_revision]  = 'master'
