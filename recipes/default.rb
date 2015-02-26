#
# Cookbook Name:: osmpolygons
# Recipe:: default
#

%w(
  apt::default
  osmpolygons::user
  osmpolygons::setup
  osmpolygons::deploy
  osmpolygons::extracts
).each do |r|
  include_recipe r
end
