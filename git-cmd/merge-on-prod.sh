#!/bin/bash
#@author Brichard ZAFY <brichardzafy@gmail.com>
current_rep=`pwd`;
cd $current_rep;
echo "Répertoire Actuel : $current_rep " ;
current_branch=`git rev-parse --abbrev-ref HEAD`
#@todo : A remplacer selon nom de la branche qui fait le deploiement en PROD
branch_prod="master"
echo "Branch Actuel : $branch_prod " ;
git checkout $branch_prod
git pull origin $branch_prod
git merge $current_branch
git push origin $branch_prod
git checkout $current_branch