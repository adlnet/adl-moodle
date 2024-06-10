#!/bin/bash

bash ./scripts/install-docker.sh
bash ./scripts/download-deps.sh
bash ./pull-images.sh

git clone https://github.com/adlnet/catapult catapult
