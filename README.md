osmpolygons Chef Cookbook
===========
[![Build Status](https://circleci.com/gh/mapzen/chef-osmpolygons.svg?style=svg)](https://circleci.com/gh/mapzen/chef-osmpolygons)

What does it do?
----------------
Downloads the planet pbf, installs dependencies and extracts admin boundaries from the data. Optionally,you can slice up the resulting data into smaller extracts defined by bounding boxes.

What hardware do I need?
------------------------
The equivalent of an AWS r3.xlarge or better: quad-core, 30GB RAM.
Data storage of ~100GB and support for ~500iops.

How Long Does it Take
---------------------
To process the planet admin boundaries on the hardware indicated above takes roughly 8 hours.
How long processing any additional extracts from that data is variable.

Contributing
------------
Please fork, update, write specs for your changes and submit a pull.

Usage
-----
    include_recipe 'osmpolygons::default'

This will install the required dependencies, set up the filesystem structure, download the planet pbf,
and process admin boundary data. See the attributes file below for information on where all this is
being placed.

If you would additionally like to extract smaller regions from the resultant data, you can do so in one of two ways. One is to directly specify the hash as shown below. Name is translated into a directory and is currently not sanitized, so it should not contain spaces, etc. The bbox parameter is an array containing the coordinates of the bbox you want to process:

    node[:osmpolygons][:extracts][:hash] = {
      "usa" => ["top", "left", "bottom", "right"]
      "australia" => ["top", "left", "bottom", "right"]
    }

The other is to create a file and specify the path to it:

    node[:osmpolygons][:extracts][:hash_from_file] = '/etc/some_file_containing_json'

The file should contain json in the format below:

    {
      "usa": ["top", "left", "bottom", "right"],
      "australia: ["top", "left", "bottom", "right"]
    }

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

Cookbook Dependencies
---------------------
apt, user, nodejs

License and Authors
-------------------
License: GPL
Authors: grant@mapzen.com
