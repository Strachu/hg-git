#!/bin/bash    

ExportAllBranchesAsBookmarks()
{
	branches=`hg branches | cut -d' ' -f 1`

	for branch in $branches
	do
	  hg bookmark hg/$branch -r $branch
	done
}

ImportAllBranchesToGit()
{
	branches=`hg branches | cut -d' ' -f 1`

	for branch in $branches
	do
	  git branch $branch hg/$branch
	done
	
	git branch master hg/default
}
 
repo_dir=`basename $1`

hg clone -U $1
cd $repo_dir

current_dir=`pwd`

echo '[git]' >> .hg/hgrc
echo 'intree=1' >> .hg/hgrc

ExportAllBranchesAsBookmarks
hg gexport

git config core.bare false
git config core.worktree "$current_dir"

#ImportAllBranchesToGit
git checkout hg/default
git reset --hard

echo '.hg' >> .git/info/exclude
echo '[ui]' >> .hg/hgrc
echo 'ignore = "$current_dir/.hg/hgignore"' >> .hg/hgrc
echo '.git' >> .hg/hgignore