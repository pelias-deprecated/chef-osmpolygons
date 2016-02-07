name             'osmpolygons'
maintainer       'mapzen'
maintainer_email 'grant@mapzen.com'
license          'GPL v3'
description      'Installs/Configures extractor'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.5.0'

recipe 'osmpolygons', 'Builds metro extracts'

depends 'apt'
depends 'user'
depends 'nodejs', '~> 2.4.0'

%w(ubuntu).each do |os|
  supports os
end
