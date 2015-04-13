osmpolygons changelog
=====================

0.3.0
-----
* install from npm
* account for changes to cli binary

0.2.0
-----
* cut admin boundaries from the planet rather than from extracts, which proved problematic
* update repo to directly reference Fences repos
* still need to try and download if force == true, because it might be our first run and we as yet have no data

0.1.0
-----
* lint
* gdal-bin, prep for building previews

0.0.5
-----
* don't try to download when force == true

0.0.4
-----
* allow forcing of extracts with attribute

0.0.3
-----
* drive extract creation off download of new data rather than template existence

0.0.2
-----
* always download data rather than let osmium retrieve it (which can prove to be problematic)
* extract creation is triggered from config file: to rebuild for a given dataset, simply remove its config and re-cook
 
0.0.1
-----
* initial release
