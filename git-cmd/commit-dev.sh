#!/bin/bash
#@author Brichard ZAFY <brichardzafy@gmail.com>
current_rep=`pwd`;
cd $current_rep;
echo "Je suis dans $current_rep " ;
id_last_commit=`git rev-parse HEAD`
read -p "Voulez-vous utiliser la derniere commit? [y/n]" use_last_commit
if [ $use_last_commit = "y" ]
then
      git commit -ac $id_last_commit --no-verify --no-status
else
    read -p "Entrer votre commit message : "  commit_message
    git commit -am "$commit_message" --no-verify --no-status
fi
current_branch=`git rev-parse --abbrev-ref HEAD`
#@todo : A remplacer selon nom de la branche qui fait le deploiement en DEV
branch_dev="dev-v3"
git checkout $branch_dev
git pull origin $branch_dev
git merge $current_branch
git push origin $branch_dev
git checkout $current_branch

#Si on veut pusher en Prod directement apres
read -p "Voulez-vous merger en PROD ? [y/n]" merge_on_prod

if [ $merge_on_prod = "y" ]
then
     eval "commit-merge-dev-prod/git-cmd/merge-on-prod.sh"
fi
