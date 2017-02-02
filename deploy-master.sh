#! /bin/bash

berks package my-cookbooks.tar.gz

aws s3 cp my-cookbooks.tar.gz s3://homesync-general
