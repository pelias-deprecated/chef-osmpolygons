#
# Cookbook Name:: osmpolygons
# Attributes:: extracts
#

default[:osmpolygons][:extracts][:force][:prep]     = false
default[:osmpolygons][:extracts][:force][:build]    = false
default[:osmpolygons][:extracts][:force][:slices]   = false

default[:osmpolygons][:extracts][:prep][:timeout]   = 43_200 # 12 hours
default[:osmpolygons][:extracts][:build][:timeout]  = 43_200 # 12 hours

# if this file exists we'll process regional slices
default[:osmpolygons][:extracts][:slices][:hash]    = {}
default[:osmpolygons][:extracts][:slices][:file]    = '/etc/extracts.json'
default[:osmpolygons][:extracts][:slices][:timeout] = 43_200  # 12 hours

# planet
#   NOTE: must support an accompanying .md5
#   at the same location, e.g. planet-latest.osm.pbf.md5
default[:osmpolygons][:planet][:download_timeout]   = 7_200 # two hours
default[:osmpolygons][:planet][:url]                = 'http://planet.us-east-1.mapzen.com/planet-latest.osm.pbf'
