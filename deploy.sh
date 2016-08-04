#!/bin/bash

echo "Deploying builds from dist_wallet/"

if [ ! -d dist_wallet ]; then
	echo "Directory not found"
	exit 1
fi

for build_path in dist_wallet/*
do
	if [ -d "${build_path}" ]; then
		dir_name=$(basename $build_path)
		if [ $dir_name != "app" ]; then
			echo "Zipping up $dir_name"
			
			zip -r "dist_wallet/$dir_name.zip" $build_path

			echo "Uploading $dir_name.zip to S3"

			aws s3api put-object --bucket builds-mist2 --key $dir_name.zip  --body $build_path.zip
		fi
	fi
done

echo "Deploy finished"
