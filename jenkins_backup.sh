#!/bin/bash -e

# enforce Git config username and e-mail set on Jenkins Master node will be always used, not being overwritten by Git Stash Jenkins plugin
unset GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME GIT_COMMITTER_EMAIL GIT_COMMITER_NAME 

echo ".gitconfig" && rsync -av ~/.gitconfig . && echo
echo "xml configs from $HOME/" && rsync -av --delete ~/*.xml ./jenkins/ && echo
echo "secrets" && rsync -av --delete ~/secrets/ jenkins/secrets/ && echo
echo "users" && rsync -av --delete ~/users/ jenkins/users/ && echo
echo "jobs config.xml files" && rsync -av --delete  --prune-empty-dirs --include '*/' --include=config.xml --exclude='*' ~/jobs/ jenkins/jobs/ && echo

git add --all .
set +e
git diff --cached --quiet >/dev/null
if [[ "$?" != "0" ]] ; then
 git commit -m "${JOB_NAME}-${BUILD_NUMBER}"
fi
set -e

git push origin HEAD:master
