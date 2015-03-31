#
# Cookbook Name:: osmpolygons
# Attributes:: user
#

default[:osmpolygons][:user][:id]           = 'poly'
default[:osmpolygons][:user][:uid]          = 2002
default[:osmpolygons][:user][:home]         = '/home/poly'
default[:osmpolygons][:user][:shell]        = '/bin/bash'
default[:osmpolygons][:user][:ssh_keygen]   = false
default[:osmpolygons][:user][:manage_home]  = false
default[:osmpolygons][:user][:create_group] = true
