#!/bin/bash

tar -zxvf $1.tar.gz -C ../results/.
cd $1
for file in $(ls processor*)
do
tar -xvf $file
rm $file
done
