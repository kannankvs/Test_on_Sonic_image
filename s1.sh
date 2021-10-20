#!/usr/bin bash -e
git checkout main
git fetch origin 
git reset --hard origin/main
git checkout -b br2
git pull br2
git config --global user.email "Kannan_KVS@Dell.com"
git config --global user.name "kannankvs"
echo '{ KVSK1-Prasanna1 - S1 - Try1' > s1.json
echo "\n}" >> s1.json
git add s1.json
git commit -m "latest links for sonic images"
git push -u origin br2
