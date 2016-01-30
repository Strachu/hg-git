#!/bin/bash    

cat .hgignore > .git/info/exclude
echo '.hg' >> .git/info/exclude
