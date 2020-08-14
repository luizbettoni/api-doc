#!/usr/bin/env bash

git checkout deploy
git pull
git merge master
bundle exec middleman build --clean
echo "comitando as mudanças e volte para o master"
git add -u
git commit && git push && git checkout master
