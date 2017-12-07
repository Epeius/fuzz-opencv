#!/bin/bash

if [ "x$1" = "x" ]; then
    echo "No target binary is selected!"
    exit
fi

TARGET=$1
AFL_HOME=/home/binzhang/fuzz/afl-fuzz/
INPUT=`pwd`/input/
OUTPUT=`pwd`/output/
CB_DIR=/home/binzhang/fuzz/cb-multios-pure/cb-multios/build/challenges/

# Create test environment for a CB
create_env () {
    if [ ! -d $INPUT/$TARGET ]; then
        mkdir -p $INPUT/$TARGET
    fi

    rm -rf $INPUT/$TARGET/*
    echo "AAAAAAAAAAAAAAAAAAAAA" > $INPUT/$TARGET/seed

    if [ ! -d $OUTPUT/$TARGET ]; then
        mkdir -p $OUTPUT/$TARGET
    fi

    rm -rf $OUTPUT/$TARGET/*
}

create_env

$AFL_HOME/afl-fuzz -m 16G -t 1000+ -Q -i $INPUT/$TARGET -o $OUTPUT/$TARGET $CB_DIR/$TARGET/$TARGET
