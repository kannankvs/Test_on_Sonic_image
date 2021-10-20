#!/usr/bin bash -e
echo '{ KVSK1-Prasanna - S1 - Try1' > s1.json
echo "\n}" >> s1.json
git add s1.json
git commit -m "d2 latest links for sonic images"
git config --global user.email "Kannan_KVS@Dell.com"
git config --global user.name "kannankvs"
git push 
