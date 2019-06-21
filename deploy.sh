#!/usr/bin/env bash

git checkout deploy
git pull
git merge master
bundle exec middleman build --clean
echo "Agora comite as mudanças e volte para o master"
