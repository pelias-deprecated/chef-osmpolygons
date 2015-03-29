#
# Cookbook Name:: osmpolygons
# Recipe:: _download
#

# override tempfile location so the download
#   temp file goes somewhere with enough space
ENV['TMP'] = node[:osmpolygons][:setup][:datadir]

filename = node[:osmpolygons][:planet][:url].split('/').last
fail if filename !~ /\.pbf$/

remote_file "#{node[:osmpolygons][:setup][:datadir]}/#{filename}.md5" do
  action    :create
  backup    false
  source    "#{node[:osmpolygons][:planet][:url]}.md5"
  mode      0644
  notifies  :run, 'execute[download planet]', :immediately
  notifies  :run, 'ruby_block[verify md5]',   :immediately
end

# use wget because remote_file is incredibly awful for files this large
execute 'download planet' do
  action  :nothing
  user    node[:osmpolygons][:user][:id]
  timeout 14_400
  command <<-EOH
    wget --quiet -O \
      #{node[:osmpolygons][:setup][:datadir]}/#{filename} #{node[:osmpolygons][:planet][:url]}"
  EOH
end

ruby_block 'verify md5' do
  action :nothing

  block do
    require 'digest'

    planet_md5  = Digest::MD5.file("#{node[:osmpolygons][:setup][:datadir]}/#{filename}").hexdigest
    md5         = File.read("#{node[:osmpolygons][:setup][:datadir]}/#{filename}.md5").split(' ').first

    if planet_md5 != md5
      Chef::Log.info('Failure: the md5 of the planet we downloaded does not appear to be correct. Aborting.')
      abort
    end
  end
end

