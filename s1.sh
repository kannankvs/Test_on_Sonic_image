#!/usr/bin bash
echo '{ KVSK1-Prasanna - S1 - Try1' > s1.json
echo "\n}" >> s1.json
git add s1.json
git commit -m "d2 latest links for sonic images"
git config user.email "Kannan_KVS@Dell.com"
git config user.name "kannankvs"
git push origin BR1
