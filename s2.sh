#!/usr/bin bash -e
git checkout -b br2
git config --global user.email "Kannan_KVS@Dell.com"
git config --global user.name "kannankvs"
git pull --ff-only origin br2
echo '{ KVSK - s2 script ?' > s2.json
echo "\n}" >> s2.json
git add s2.json
git commit -m "latest links for sonic images"
git push -f --set-upstream origin br2
