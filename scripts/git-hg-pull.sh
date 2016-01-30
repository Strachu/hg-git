#!/bin/bash

scripts_dir=`dirname $0`

bash $scripts_dir/git-hg-fetch.sh

branches=`hg branches | cut -d' ' -f 1`

for branch in $branches
do
  git checkout $branch
  git merge hg/$branch
done