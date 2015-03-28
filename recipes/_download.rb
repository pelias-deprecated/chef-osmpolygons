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
  not_if    { node[:osmpolygons][:extracts][:force] == true }
end

execute 'download planet' do
  action  :nothing
  command "wget --quiet -O #{node[:osmpolygons][:setup][:datadir]}/#{filename} #{node[:osmpolygons][:planet][:url]}"
  user    node[:osmpolygons][:user][:id]
  timeout 14_400
end
