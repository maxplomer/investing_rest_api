# Ruby Investing Rest API

This is the backend for the Angular 2 app.



## Create trade route

POST to

    localhost:3000/api/trades?company=AAPL&shares=5



## Run with 

    $ ruby serve.rb



##  Sample .env file

    COMPOSEIO_URI='mongodb://db_user:db_password@candidate.52.mongolayer.com:10794/investing_rest_api'
    ACCESS_CONTROL_ALLOW_ORIGIN='http://localhost:3000'


# Deployment using SCP

Deploy with

    $ ruby deploy.rb

## Directions to create new EC2 Instance

Log into dashboard go to ec2, go to new instance, then click Amazon Linux AMI

## Create Amazon Linux AMI instance

In security settings add rule for http.
SSH into instance and update to get latest version of AWS CLI

    $ ssh -i investing_rest_api.pem ec2-user@54.186.237.58
    $ sudo yum update


## How to install ruby on instance 

Install new Ruby on Ubuntu

    $ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    $ curl -L https://get.rvm.io | bash -s stable
    $ source ~/.rvm/scripts/rvm
    $ rvm install 2.2.2
    $ rvm use 2.2.2 --default
    $ ruby -v

Install newest bundler 

    $ gem install bundler --pre
  

## Install AWS CLI on your machine (mac osx). Install pip first.

    $ sudo easy_install pip
    $ sudo pip install awscli

Note: On OS X, if you see an error regarding the version of six that came with distutils in El Capitan, use the --ignore-installed option:

    $ sudo pip install awscli --ignore-installed six


## Check if AWS CLI installed with

    $ aws help


## Configuring the AWS Command Line Interface

    $ aws configure

I am using "us-west-2" for Default region name, when my instance had the Availablity Zone "us-west-2b"


## Reboot instance with 

    $ aws ec2 reboot-instances --instance-ids i-f4e6bc2c

# Deployment using Dokku ( http://dokku.viewdocs.io/dokku/ )

Deploy with

    $ git push dokku master

## Create Amazon Linux AMI instance

In security settings add rule for http.



