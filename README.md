osmpolygons
===========
[![Build Status](https://circleci.com/gh/mapzen/chef-osmpolygons.svg?style=svg)](https://circleci.com/gh/mapzen/chef-osmpolygons)

What does it do?
----------------
Downloads the planet pbf, installs dependencies and extracts admin boundaries from the data. Optionally, you can slice up the resulting data into smaller extracts defined by bounding boxes.

What hardware do I need?
------------------------
* ~150GB of free disk space
* ~6GB of free RAM

How Long Does it Take
---------------------
* ~5 hours
  * this is largely dependent on the both disk speed for the initial conversion process, and on single cpu core speed for the build process

Contributing
------------
Please fork and create a pull request. At a minimum, verify that your changes are passing basic syntax tests via `bundle install && bundle exec rake`.

Usage
-----
    include_recipe 'osmpolygons::default'

This will install the required dependencies, set up the filesystem structure, download the planet pbf,
and process admin boundary data. See the default [attributes](https://github.com/pelias/chef-osmpolygons/blob/master/attributes/default.rb) file to understand (or override) where all this is being placed.

If you would additionally like to extract smaller regions from the resultant data, you can do so in one of two ways. The first is to directly specify the hash as an attribute value, as shown below. Name is translated into a directory (the input will be sanitized if you use spaces, etc). The bbox parameter is an array containing the coordinates of the bbox you want to process:

    default[:osmpolygons][:extract][:slices][:hash] = {
      "usa" => ["left", "bottom", "right", "top"],
      "australia" => ["left", "bottom", "right", "top"]
    }

The second method is to create a file and specify the path to it. This file should be managed directly via a process outside of this cookbook (i.e. in a wrapper cookbook):

    node[:osmpolygons][:extract][:slices][:file] = '/etc/a_file.json'

The file should contain json in the format below:

```json
    {
      "usa": ["left", "bottom", "right", "top"],
      "australia": ["left", "bottom", "right", "top"],
      "ad_infinitum": ["left", "bottom", "right", "top"]
    }
```

In either case, the bbox will be validated for the following conditions:
- is it an array?
- does it contain four elements?
- do the elements produce a valid bounding box?

Failure of any condition will abort the run.

See the [code](https://github.com/pelias/chef-osmpolygons/blob/master/recipes/_extract_slices.rb) for details.

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
