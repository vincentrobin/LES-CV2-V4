#!/bin/bash

srcdir="../run/"
destdir="../results/"
nameresult=$(date +%Y%m%d_%H%M)

mkdir $destdir/$nameresult
cd $srcdir
for file in $(ls | grep processor)  
do
   echo "$file"
# if some specific variables are selected to be compressed when the mesh is heavy : must be check before use
#   for iteNumber in $(ls $file | grep -e 0)
#   do
#   echo $iteNumber
#     mkdir RAPATRI/$file/$iteNumber
#     cp -r $file/$iteNumber/T ./RAPATRI/$file/$iteNumber
#     cp -r $file/$iteNumber/p ./RAPATRI/$file/$iteNumber
#     cp -r $file/$iteNumber/scal1 ./RAPATRI/$file/$iteNumber
#     cp -r $file/$iteNumber/U ./RAPATRI/$file/$iteNumber
#   done
#   cp -r $file/constant ./RAPATRI/$file
#   cd RAPATRI
#   tar -zcf $file.tar.gz $file
#   rm -rf ./RAPATRI/$file
#
# if all variable are compressed   
   tar -zcvf $file.tar.gz $file
   rm -r $file
done
touch toto.foam
mv * $destdir/$nameresult/.
cd $destdir
tar -zcvf $nameresult.tar.gz $nameresult
rm -r $nameresult
