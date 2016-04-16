require 'net/ssh'
require 'net/scp'

instance_id = 'i-f4e6bc2c'
host = '54.186.237.58'
username = 'ec2-user'
keys = './investing_rest_api.pem'
remote_folder = 'investing_rest_api_aws'
remote_directory = '/home/' + username
files = ['.env', 'config.ru', 'Gemfile', 'Gemfile.lock', 'serve_nohup.rb']
folders = ['app', 'config', 'spec'] # 'tmp'

# Restart server and wait
`aws ec2 reboot-instances --instance-ids #{ instance_id }`
sleep(60)

# SSH in and delete current files
Net::SSH.start(host, username, :keys => keys) do |ssh|
  ssh.exec "rm -rf #{ remote_folder }"
end

# Upload files to remote server
`mkdir #{ remote_folder }`
folders.each { |folder| `cp -r #{ folder } #{ remote_folder }` }
files.each { |file| `cp #{ file } #{ remote_folder }` }

Net::SCP.start(host, username, :keys => keys) do |scp|
  scp.upload! remote_folder, remote_directory, :recursive => true
end

`rm -rf #{ remote_folder }`
