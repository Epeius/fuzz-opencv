#!/bin/bash

if [ $# != 2 ]; then
    echo "Usage: ./startWorker index index"
    exit
fi

START=$1
END=$2

ALL_CB_NAMES=`pwd`/cbs
index=1

run_fuzzer () {
    cb_name=$1
    echo "Testing $cb_name"
    x-terminal-emulator -e "`pwd`/runFuzzer.sh $cb_name" 
}

cat $ALL_CB_NAMES | \
    while read CB_NAME; do
        if [ "$index" -ge "$START" ]; then
            if [ "$index" -le "$END" ]; then
                run_fuzzer $CB_NAME
                sleep 1 
            fi
        fi

        index=`expr $index + 1`
    done

