#!/bin/bash    

ExportAllBranchesAsBookmarks()
{
	branches=`hg branches | sed "s/   */\t/g" | cut -f 1`

	IFS=$'\n'
	
	for branch in $branches
	do
	  hg bookmark hg/$branch -r $branch
	done
}

ImportAllBranchesToGit()
{
	branches=`hg branches | sed "s/   */\t/g" | cut -f 1`

	IFS=$'\n'

	for branch in $branches
	do
	  git branch $branch hg/$branch
	done
}

scripts_dir=`dirname $0`
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

ImportAllBranchesToGit
git reset --hard

echo '[ui]' >> .hg/hgrc
echo 'ignore = "$current_dir/.hg/hgignore"' >> .hg/hgrc
echo '.git' >> .hg/hgignore

bash $scripts_dir/git-hg-ignore-update.sh
