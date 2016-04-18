#!/bin/bash

bundle install
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 3000
nohup bundle exec volt server > allout.txt 2>&1 &