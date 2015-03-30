#
# Cookbook Name:: osmpolygons
# Attributes:: extracts
#

default[:osmpolygons][:extracts][:force][:planet]   = false
default[:osmpolygons][:extracts][:force][:slices]   = false

default[:osmpolygons][:extracts][:planet][:timeout] = 43_200 # 12 hours
default[:osmpolygons][:extracts][:planet][:kb_heap] = '28672'

# You can specify a path to a file containing json of all the extracts you want
#   to process. If it exists we'll read the contents into the attribute.
#   Alternatively, specify the hash directly in the attribute.
#   Defaults to empty.
#
default[:osmpolygons][:extracts][:hash]             = {}
default[:osmpolygons][:extracts][:hash_from_file]   = '/etc/extracts.json'
default[:osmpolygons][:extracts][:slices][:timeout] = 7_200  # 2 hours
default[:osmpolygons][:extracts][:slices][:kb_heap] = '8192'

# planet
#   NOTE: must support an accompanying .md5
#   at the same location, e.g. planet-latest.osm.pbf.md5
default[:osmpolygons][:planet][:download_timeout]   = 7_200 # two hours
default[:osmpolygons][:planet][:url]                = 'http://planet.us-east-1.mapzen.com/planet-latest.osm.pbf'
