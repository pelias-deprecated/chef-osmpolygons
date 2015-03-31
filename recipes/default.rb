#
# Cookbook Name:: osmpolygons
# Recipe:: default
#

%w(
  osmpolygons::_user
  osmpolygons::_setup
  osmpolygons::_extracts_planet
  osmpolygons::_extracts_slices
).each do |r|
  include_recipe r
end
