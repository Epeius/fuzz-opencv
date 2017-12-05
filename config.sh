#!/bin/sh

MYCC=`which clang`
MYCXX=`which clang++`
INSTALL_DIR=/home/binzhang/fuzz/target/opencv-install

ADDR_COV_FLAGS="-fsanitize=address -fsanitize-coverage=trace-pc-guard,trace-cmp,trace-gep,trace-div"

cmake -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=$MYCXX -DCMAKE_CC_COMPILER=$MYCC -DCMAKE_CXX_FLAGS="${ADDR_COV_FLAGS}" -DCMAKE_C_FLAGS="${ADDR_COV_FLAGS}" -DCMAKE_EXE_LINKER_FLAGS=-lasan -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR ..
