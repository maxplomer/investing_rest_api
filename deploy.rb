require 'net/ssh'
require 'net/scp'

instance_id = 'i-f4e6bc2c'
host = '54.186.237.58'
username = 'ec2-user'
keys = './investing_rest_api.pem'
remote_folder = 'investing_rest_api_aws'
remote_directory = '/home/' + username
files = ['.env', 'config.ru', 'Gemfile', 'Gemfile.lock', 'serve_nohup.rb', 'serve_nohup.sh']
folders = ['app', 'config', 'spec'] # 'tmp'

# Restart server and wait
`aws ec2 reboot-instances --instance-ids #{ instance_id }`
sleep(100)

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

# SSH in, bundle install and run server
Net::SSH.start(host, username, :keys => keys) do |ssh|
  cmd  = "export PATH=/home/ec2-user/.rvm/gems/ruby-2.2.2/bin:/home/ec2-user/.rvm/gems/ruby-2.2.2@global/bin:/home/ec2-user/.rvm/rubies/ruby-2.2.2/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/aws/bin:/home/ec2-user/.rvm/bin:/home/ec2-user/.local/bin:/home/ec2-user/bin; "
  cmd += "cd #{ remote_folder }; gem install bundler; chmod u+x serve_nohup.sh; ./serve_nohup.sh"

  ssh.exec cmd 
end

`rm -rf #{ remote_folder }`
