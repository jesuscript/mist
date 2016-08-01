#!/bin/bash

function up() {
	echo "Getting $1 binaries from $2"

	mkdir -p ./nodes/parity
	curl -L $2 > "./nodes/parity/$1.zip"

	if [[ $1 == win32-x64 ]]; then
		unzip -j "./nodes/parity/$1.zip" target/release/parity.exe -d "./nodes/parity/$1" 
	else
		unzip -j "./nodes/parity/$1.zip" target/release/parity -d "./nodes/parity/$1" 
	fi
	
}


up darwin-x64 https://gitlab.ethcore.io/Mirrors/parity/builds/452/artifacts/download
up linux-x64  https://gitlab.ethcore.io/Mirrors/parity/builds/445/artifacts/download
up win32-x64  https://gitlab.ethcore.io/Mirrors/parity/builds/453/artifacts/download
