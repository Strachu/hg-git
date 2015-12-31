#!/bin/bash

branches=`hg branches | cut -d' ' -f 1`

hg pull

for branch in $branches
do
  hg bookmark -f hg/$branch -r $branch
done

hg gexport

#for branch in $branches
#do
#  git checkout $branch
#  git merge hg/$branch
#done