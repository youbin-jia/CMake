#!/bin/bash

rm -rf ../Step2_build
mkdir -p ../Step2_build
cd ../Step2_build
if [ "$1" == "ON" ]; then
    cmake ../Step2 -DUSE_MYMATH=ON
else
    cmake ../Step2 -DUSE_MYMATH=OFF
fi
cmake --build .