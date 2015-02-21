osmpolygons changelog
=====================

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
