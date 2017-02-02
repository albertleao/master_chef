#! /bin/bash

echo 'Packaging cookbooks.'
berks package my-cookbooks.tar.gz
echo 'Done Packaging cookbooks.'

echo 'Uploading to S3 Production.'
aws s3 cp my-cookbooks.tar.gz s3://homesync-general
echo 'Done uploading to S3.'

rm my-cookbooks.tar.gz
