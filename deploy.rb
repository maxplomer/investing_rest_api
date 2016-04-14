require 'net/ssh'

instance_id = "i-f4e6bc2c"
host = '54.186.237.58'
keys = "./investing_rest_api.pem"

# Restart server and wait
`aws ec2 reboot-instances --instance-ids #{ instance_id }`
sleep(60)

# SSH in and delete current files
Net::SSH.start(host, 'ec2-user', :keys => keys) do |ssh|
  ssh.exec "rm -rf helloworld.txt"
end





