#!/bin/bash -l

source ~/.rvm/scripts/rvm && rvm use --install --create ruby-1.9.3-p327@knowledgebase && export > rvm.env

echo $(pwd)

git checkout master
bundle check || bundle install --path vendor/bundle
git pull
git submodule init
git submodule update

(cd _site && git checkout master && git pull)

bundle exec gollum-site generate

cd _site
git checkout master
git checkout .gitignore
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
  git pull --rebase
  git push
fi

