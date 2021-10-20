#!/usr/bin bash -e
ECHO GIT CHECKOUT MAIN
git checkout main
ECHO GIT fetch origin
git fetch origin 
ECHO GIT hard 
git reset --hard origin/main
ECHO GIT CHECKOUT br2
git checkout -b br2
ECHO GIT pull
git pull br2
ECHO GIT config
git config --global user.email "Kannan_KVS@Dell.com"
git config --global user.name "kannankvs"
echo '{ KVSK1-Prasanna1 - S1 - Try1' > s1.json
echo "\n}" >> s1.json
ECHO GIT add
git add s1.json
git commit -m "latest links for sonic images"
ECHO GIT last push
git push -u origin br2
