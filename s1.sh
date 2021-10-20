#!/usr/bin bash -e
git clone https://github.com/kannankvs/Test2.git
cd Test2
git checkout br2
git config --global user.email "Kannan_KVS@Dell.com"
git config --global user.name "kannankvs"
git push origin br2
echo '{ KVSK1-Prasanna - S1 - Try1' > s1.json
echo "\n}" >> s1.json
git status
git add s1.json
git commit -m "latest links for sonic images"
git push --set-upstream origin br2
