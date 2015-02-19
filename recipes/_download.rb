#
# Cookbook Name:: osmpolygons
# Recipe:: _download
#

# override tempfile location so the download
#   temp file goes somewhere with enough space
ENV['TMP'] = node[:osmpolygons][:setup][:datadir]

node[:osmpolygons][:extracts][:array].each do |extract|
  # fail if someone tries to pull something other than
  #   a pbf data file
  filename = extract.split('/').last
  fail if filename !~ /\.pbf$/

  remote_file "#{node[:osmpolygons][:setup][:datadir]}/#{filename}.md5" do
    action    :create
    backup    false
    source    "#{extract}.md5"
    mode      0644
    notifies  :run, "execute[download #{extract}]",       :immediately
  end

  execute "download #{extract}" do
    action  :nothing
    command "wget --quiet -O #{node[:osmpolygons][:setup][:datadir]}/#{filename} #{extract}"
    user    node[:osmpolygons][:user][:id]
    timeout 14_400
  end
end
