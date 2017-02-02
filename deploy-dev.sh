#! /bin/bash

echo 'Packaging cookbooks.'
berks package my-cookbooks.tar.gz
echo 'Done packaging cookbooks.'

echo 'Uploading to S3 Development.'
aws s3 cp my-cookbooks.tar.gz s3://homesync-general-dev --acl public-read
echo 'Finished Uploading.'
rm my-cookbooks.tar.gz
