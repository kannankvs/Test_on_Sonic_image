#!/usr/bin bash -e
git checkout -b br2
git config --global user.email "Kannan_KVS@Dell.com"
git config --global user.name "kannankvs"
git pull --ff-only origin br2
git push origin br2
echo '{ KVSK2-Prasanna2 - is it working now2?' > s1.json
echo "\n}" >> s1.json
git add s1.json
git commit -m "latest links for sonic images"
git push -f --set-upstream origin br2
