#!/bin/bash

export IMPORT_PATH=$GOPATH/src:./protos
export GENERATOR="gofast_out"
export OUTPUT_DIR="./src/mchatpb"
export PROTO_FILES="./protos/*.proto"

protoc --proto_path=$IMPORT_PATH --${GENERATOR}=${OUTPUT_DIR} $PROTO_FILES
protoc --proto_path=$IMPORT_PATH --swift_out="./Otsimo Test" $PROTO_FILES

