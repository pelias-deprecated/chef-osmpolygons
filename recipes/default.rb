#
# Cookbook Name:: osmpolygons
# Recipe:: default
#

%w(
  osmpolygons::_user
  osmpolygons::_setup
  osmpolygons::_deploy
  osmpolygons::_extract_planet
  osmpolygons::_extract_slices
).each do |r|
  include_recipe r
end
