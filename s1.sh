#!/usr/bin bash -e
echo '{ KVSK1-Prasanna - S1 - Try1' > s1.json
echo "\n}" >> s1.json
git branch br2
git checkout br2
git push origin br2
git init
git add s1.json
git config --global user.email "Kannan_KVS@Dell.com"
git config --global user.name "kannankvs"
git add sonic_image_links.json
git commit -m "latest links for sonic images"
git push --set-upstream origin br2
