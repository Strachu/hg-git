#!/bin/bash

hg pull

branches=`hg branches | cut -d' ' -f 1`

for branch in $branches
do
  hg bookmark --delete $branch
  hg bookmark -f hg/$branch -r $branch
done

hg gexport
