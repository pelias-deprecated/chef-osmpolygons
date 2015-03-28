osmpolygons Chef Cookbook
===========
[![Build Status](https://circleci.com/gh/mapzen/chef-osmpolygons.svg?style=svg)](https://circleci.com/gh/mapzen/chef-osmpolygons)

What does it do?
----------------
Extracts admin boundaries from OSM data.

What hardware do I need?
------------------------
TODO

Contributing
------------
Please fork, update, write specs for your changes and submit a pull.

Usage
-----
    include_recipe 'osmpolygons::default'

Supported Platforms
-------------------
Tested and supported on the following platforms:

* Ubuntu 14.04LTS

Requirements
------------
* Chef >= 11.4

Attributes
----------
* see [attributes/default.rb](https://github.com/mapzen/chef-osmpolygons/blob/master/attributes/default.rb)

Dependencies
-----------
apt, user

Vagrant Environment
===================

Installation
------------
    vagrant plugin install vagrant-berkshelf 
    bundle install
    berks install
    vagrant up
    vagrant ssh

License and Authors
-------------------
License: GPL
Authors: grant@mapzen.com
