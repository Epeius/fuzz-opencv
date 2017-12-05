#!/bin/sh
#export AFL_NO_FORKSRV=1
if [ "$1" = "1" ]; then
/home/binzhang/afl/afl-fuzz -i /home/binzhang/test/in -o /tmp/afl  -m none -M $1 /home/binzhang/test/target/asan/opencv_afl @@
else
/home/binzhang/afl/afl-fuzz -i /home/binzhang/test/in -o /tmp/afl -m none -S $1 /home/binzhang/test/target/asan/opencv_afl @@
fi
