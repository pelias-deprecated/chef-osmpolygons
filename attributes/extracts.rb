#
# Cookbook Name:: osmpolygons
# Attributes:: extracts
#

# force run regardless of whether planet data is new
default[:osmpolygons][:extract][:force][:prep]      = false
default[:osmpolygons][:extract][:force][:build]     = false
default[:osmpolygons][:extract][:force][:slices]    = false

default[:osmpolygons][:extract][:prep][:timeout]    = 7_200   # 2 hours
default[:osmpolygons][:extract][:build][:timeout]   = 21_600  # 6 hours

# see README
default[:osmpolygons][:extract][:slices][:hash]     = {}
default[:osmpolygons][:extract][:slices][:file]     = '/etc/osmpoly_slices.json'
default[:osmpolygons][:extract][:slices][:timeout]  = 3_600 # one hour per slice

# planet
#   NOTE: must support an accompanying .md5
#   at the same location, e.g. planet-latest.osm.pbf.md5
default[:osmpolygons][:planet][:download_timeout]   = 7_200 # two hours
default[:osmpolygons][:planet][:verify_checksum]    = true
default[:osmpolygons][:planet][:url]                = 'http://planet.us-east-1.mapzen.com/planet-latest.osm.pbf'
