#!/bin/bash

echo $(pwd)

git checkout master
git pull
git submodule init
git submodule update

(cd _site && git checkout master && git pull)

gollum-site generate

cd _site
git checkout master
if [[ 0 -eq "`git diff | wc -l`" ]]
then
  echo "No changes."
else
  git add .
  git commit -m "Generated newest site."
  git push
fi
cd ..

if [[ 0 -eq "`git diff | wc -l`" ]]
then
  echo "No changes."
else
  git commit -am "Updated _site"
  git push
fi

