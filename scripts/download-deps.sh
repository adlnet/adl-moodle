#!/bin/sh

set -e

SCRIPT_DIR=$(cd $(dirname $0) && pwd)
echo "Script dir: $SCRIPT_DIR"

cd $SCRIPT_DIR/..
mkdir -p source
cd source
SOURCE_DIR=$(pwd)

mkdir -p $SOURCE_DIR/binary
cd $SOURCE_DIR/binary
wget -O gosu https://github.com/tianon/gosu/releases/download/1.14/gosu-amd64
