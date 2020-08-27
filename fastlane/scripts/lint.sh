#!/usr/bin/env bash

error=false

cd ..

# run flutter lint and set error flag 
# if an issue in lint is founded
flutter analyze || error=true

# fail build if there was an error
if [[ ${error} = true ]];
then
    exit -1
fi
