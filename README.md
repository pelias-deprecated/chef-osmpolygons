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

After completing a run, you can rebuild data for a given extract by removing its config file.

Supported Platforms
-------------------
Tested and supported on the following platforms:

* Ubuntu 12.04LTS
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

#### I don't like Vagrant
* well then sir, provision an Ubuntu14.04 LTS system with the provider of your choice, and then bootstrap with chef-solo:
    `knife solo bootstrap root@${host} -r 'recipe[osmpolygons]'`
* and re-cook with the following:
    `knife solo cook root@${host} -r 'recipe[osmpolygons]'`
* alternatively, you can add the osmpolygons cookbook to your chef server and wrap it as you see fit

License and Authors
-------------------
License: GPL
Authors: grant@mapzen.com
