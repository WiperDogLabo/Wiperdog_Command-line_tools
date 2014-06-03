#!/bin/sh
path=`pwd`/
cd $2"bin"
if [ "$#" -eq 4 ]; then
  groovy $path"run_test.groovy" "$@" "$path"
else
 echo           Incorrect parameters!
 echo			Format:
 echo			run_test.sh -p [/path/to/wiperdog/] -c [Folder_Test_Case]
 echo			Example:
 echo			run_test.sh -p /home/mrtit/Wiperdog/1205Wiperdog/ -c Case1
fi
