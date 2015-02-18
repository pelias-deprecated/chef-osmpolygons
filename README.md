Metroextractor Chef Cookbook
===================
![Build Status](https://circleci.com/gh/mapzen/chef-metroextractor.png?circle-token=143ea95327e7591cf64082ca9a790c5014529c3b)

Attribution
-----------
Heavily influenced by Mike Migurski's [Extractotron](https://github.com/migurski/Extractotron/)

What does it do?
----------------
Downloads the latest planet in pbf format.
Produces, via osmosis, a number of metro extracts in both pbf and bz2 formats.
Produces shape files in both imposm and osm2pgsql formats.

Projections
-----------
GeoJSON is generated via ogr2ogr and output in CRS:84 (e.g. EPSG:4326) projection.

Imposm shapfiles are generated using default projections. As the code allows for the use of either imposm2 or imposm3, that currently means:
  * EPSG:3857 for imposm3
  * EPSG:90013 for imposm2

Mapzen is using imposm3 to generate these shapefiles, so the imposm shapefiles found at our [metro extracts](https://mapzen.com/metro-extracts/) page
are using EPSG:3857.

What hardware do I need?
------------------------
On AWS, a c3.8xl (60GB RAM and at least 75GB of fast disk), will result in the entire process taking ~15 hours.

If you'd rather not go that route, you're in luck. We'll be producing extracts weekly, and you can find
them here: [Mapzen Metro Extracts](https://mapzen.com/metro-extracts/)

Contributing
------------
Extract creation is driven off the cities.json file found here: [metroextractor-cities](https://github.com/mapzen/metroextractor-cities).
If you'd like to add an extract, you can either update the file directly if you feel comfortable doing so and submit a pull request,
or open a GitHub issue and we'll look into doing it for you.

If you'd like to update any other code, please fork, update, write specs for your changes and submit a pull.

Usage
-----
    include_recipe 'metroextractor'

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
* see [attributes/default.rb](https://github.com/mapzen/chef-metroextractor/blob/master/attributes/default.rb)

Dependencies
-----------
apt, ark, osm2pgsql, osmosis postgresql, python, user

Vagrant Environment
===================

Installation
------------
    vagrant plugin install vagrant-berkshelf 
    bundle install
    berks install
    vagrant up
    vagrant ssh

#### Note
* running a planet download and then processing extracts on your local machine might be hit or miss (likely miss)

#### I don't like Vagrant
* well then sir, provision an Ubuntu12.04 LTS system with the provider of your choice, and then bootstrap with chef-solo:
    `knife solo bootstrap root@${host} -r 'recipe[metroextractor]'`
* and re-cook with the following:
    `knife solo cook root@${host} -r 'recipe[metroextractor]'`
* alternatively, you can add the metroextractor cookbook to your chef server and wrap it as you see fit

License and Authors
-------------------
License: GPL
Authors: grant@mapzen.com
