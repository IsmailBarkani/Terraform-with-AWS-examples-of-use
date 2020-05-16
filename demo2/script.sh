#!/bin/bash
# install nginx
apt-get update
apt-get -y install nginx

# make sure nginx is started
service nginx start