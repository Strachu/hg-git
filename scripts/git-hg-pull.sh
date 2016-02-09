#!/bin/bash

scripts_dir=`dirname $0`

bash $scripts_dir/git-hg-fetch.sh

original_branch=`git rev-parse --abbrev-ref HEAD`

branches=`hg branches | cut -d' ' -f 1`

for branch in $branches
do
  git checkout $branch
  git merge hg/$branch
done

git checkout $original_branch
